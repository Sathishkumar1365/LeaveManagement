import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:leavemanagement/EndUser/services/PushNotification.dart';
import 'package:provider/provider.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import '../../Admin/shared/emp_info.dart';
import '../../Admin/shared/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../services/leaveapply.dart';
import '../widgets/LeaveSentAnimation.dart';
import 'package:lottie/lottie.dart';

import 'UserHome.dart';

class Leave extends StatefulWidget {
  final Employees? employees;
  const Leave({Key? key, this.employees}) : super(key: key);

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {


  final FirebaseAuth auth = FirebaseAuth.instance;//authentication for user
  var selected_leave;
  ValueNotifier<DateTime> _dateTimeNotifier = ValueNotifier<DateTime>(DateTime.now().add(Duration(days: 2)));
  int currentStep=0;
  bool _validateleavetype=false;
  bool _validatefromDate=false;
  bool _validatetoDate=false;
  bool _validatereason=false;


  addData()async{
    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.refreshEmp();
  }
  TextEditingController name=TextEditingController();
  TextEditingController employee_id=TextEditingController();
  TextEditingController mail=TextEditingController();
  TextEditingController dept=TextEditingController();
  TextEditingController leavetype=TextEditingController();
  TextEditingController fromDate=TextEditingController();
  TextEditingController toDate=TextEditingController();
  TextEditingController reason=TextEditingController();
  final dropdowncontroller=TextEditingController();
  String? dropdownvalue;
  PushNotification pushNotification=PushNotification();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.value=TextEditingValue(text: widget.employees!.emp_name,);
    mail.value=TextEditingValue(text: widget.employees!.emp_mail);
    dept.value=TextEditingValue(text: widget.employees!.emp_dept);
    employee_id.value=TextEditingValue(text: widget.employees!.employee_id);
    addData();
    FirebaseMessaging.instance.getInitialMessage();
    PushNotification.initialiseNotifications();
  }
  sendNotifictaion(String title,String token)async{
    final data={
      'click_action':'FLUTTER_NOTIFICATION_CLICK',
      'id':'1',
      'status':'done',
      'message':title,
    };
    try{
      http.Response response= await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: <String,String>{
        'Content-Type':'application/json',
        'Authorization':'key=AAAAC5PfqaE:APA91bGCpRRsGzTcx1ev6LvAOZ0IJAY5JdXNNMsJ2V3j5LPK7XfpF7feE4RSgbeMSDr-Hz2FhZ9ynnHQt3BTArSqp184UpDTKyOdAesPLX-bbqyR5FgJBCO2n9eEff7NFKYKIjMyn6-O'
      },
        body: jsonEncode(<String,dynamic>{
          'notification':<String,dynamic>{'title':title,'body':'Check Your application status'},
          'priority':'high',
          'data':data,
          'to':'$token'
        })
      );
      if(response.statusCode==200){

        print("yeah notification sended");

      }else{
        print("error");
      }
    }catch(e){
      print(e.toString());
    }
  }


  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dropdowncontroller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
        backgroundColor: Colors.green,
       elevation: 10,
        title: Text('Apply Leave'),
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
        ),
        leadingWidth: 37,
      ),
      body: Theme(
          data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: Colors.green)),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('admin').snapshots(),
            builder: (context, snapshot) {
              return Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                currentStep: currentStep,
                steps:getSteps(),
                onStepContinue: ()async{
                  final isLastStep=currentStep==getSteps().length-1;
                  if(isLastStep) {
                    setState(() {
                      leavetype.text.isEmpty?_validateleavetype=true:_validateleavetype=false;
                      fromDate.text.isEmpty?_validatefromDate=true:_validatefromDate=false;
                      toDate.text.isEmpty?_validatetoDate=true:_validatetoDate=false;
                      reason.text.isEmpty?_validatereason=true:_validatereason=false;
                    });
                    String? emp_token=await FirebaseMessaging.instance.getToken();
                    DocumentSnapshot? token;
                    try {
                      DocumentSnapshot tokens=snapshot.data!.docs.last;
                      token = tokens;
                    } catch (e) {
                      print(e.toString());
                    }
                    if(_validatefromDate==false&&_validatetoDate==false&&_validatereason==false){
                      String? res=await LeaveApply().applyleave(
                        emp_id:user!.uid,
                        emp_profile:widget.employees!.emp_profile,
                        employee_id: employee_id.text,
                        emp_name: name.text,
                        emp_mail: mail.text,
                        emp_dept: dept.text,
                        leavetype: dropdowncontroller.text,
                        fromDate: fromDate.text,
                        toDate: toDate.text,
                        reason: reason.text,
                        timestamp: Timestamp.now(),
                        status: 'Pending',
                        token:emp_token!,
                      );
                      if(res==null){
                        showModalBottomSheet(
                          isDismissible: false,
                          enableDrag: false,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 400,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10,),
                                  Lottie.network('https://assets10.lottiefiles.com/private_files/lf30_uifl1mmi.json',height:200,repeat:false),
                                  Text("Leave Applied Successfully",style: GoogleFonts.kanit(fontSize: 20,color: Colors.black)),
                                  SizedBox(height: 20,),
                                  OutlinedButton(
                                      style: ButtonStyle(
                                          side:MaterialStateProperty.all(BorderSide(color: Colors.indigo))

                                      ),
                                      onPressed: (){
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserHome()), (route) => false);
                                      },
                                      child: Text('Back to home',style: TextStyle(color: Colors.indigo),))
                                ],
                              )
                            );
                          }
                        );
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveSent()));
                        sendNotifictaion("Requested Leave", token!.get('token'));
                      }
                    }
                  } else{
                    setState(() {
                      currentStep+=1;
                    });
                  }
                },
                onStepTapped: (step)=>setState(() {
                  currentStep=step;
                }),
                onStepCancel: currentStep==0?null:()=>setState(() {
                  currentStep-=1;
                }),
              );
            }
          )
      ),
    );
  }
  List<Step>getSteps()=>[
    Step(
        state: currentStep>0?StepState.complete:StepState.indexed,
        isActive: currentStep>=0,
        title: Text('LeaveType',style: GoogleFonts.poppins(fontWeight:FontWeight.bold),),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            RichText(
              text: TextSpan(
                  text: 'Leave Type',
                  style: GoogleFonts.ubuntu(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black87),
                  children: [
                    TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red)
                    )
                  ]
              ),
            ),
            SizedBox(
              width: 360,
              child: DropdownButton(
                hint: Text("Select Leave Type"),
                isExpanded: true,
                    value: dropdownvalue,
                      items: <String>["Medical Leave","Festival Leave","Function Leave","HomeTown Leave","Condolence Leave","Educational Leave","Official Leave"].map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem(
                          value: value,
                            child: Text(value));
                      }).toList(),
                      onChanged: (String? newvalue){
                      setState(() {
                        dropdownvalue=newvalue;
                        dropdowncontroller.text=newvalue!;
                      });
                      }),
            ),
            SizedBox(height: 20,),
            fromDateInput(lable: 'From Date',hint:'Enter Date',suffixIcon: Icon(Icons.calendar_month_sharp), dateTimeNotifier: _dateTimeNotifier),
            SizedBox(height: 10,),
            toDateInput(lable: 'To Date',hint:'Enter Date',suffixIcon: Icon(Icons.calendar_month_sharp), dateTimeNotifier: _dateTimeNotifier)
          ],
        )),
    Step(
        state: currentStep>1?StepState.complete:StepState.indexed,
        isActive: currentStep>=1,
        title: Text('Final',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        content: Column(
          children: [
            makeReasonInput(lable: 'Reason ',hint: 'Enter Reason'),
          ],
        )
    )


  ];

  Widget makeReasonInput({lable,hint}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: lable,
              style: GoogleFonts.ubuntu(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black87),
              children: [
                TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red)
                )
              ]
          ),
        ),
        SizedBox(height: 10,),
        TextField(
          controller: reason,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: hint,
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              errorText: _validatereason?'Field Can\'t Empty':null,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)
              )
          ),
        ),
      ],
    );
  }
  Widget fromDateInput({lable,suffixIcon,hint,required ValueNotifier<DateTime> dateTimeNotifier}){
    final dformat=DateFormat("dd-MM-yyyy");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: lable,
              style: GoogleFonts.ubuntu(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black87),
              children: [
                TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red)
                )
              ]
          ),
        ),
        SizedBox(height: 14,),
        DateTimeField(
            format: dformat,
            decoration: InputDecoration(
              hintText:"Select Date",
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                ),
              errorText: _validatefromDate?'Field Can\'t Empty':null,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500)
              ),
            ),
            controller: fromDate,
            onShowPicker: (context,currentValue){
              return showDatePicker(
                  context: context,
                  initialDate: _dateTimeNotifier.value,
                  firstDate: _dateTimeNotifier.value,
                  lastDate: DateTime(2100)).then((DateTime? dateTime) => _dateTimeNotifier.value = dateTime  as DateTime);
            }),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget toDateInput({lable,suffixIcon,hint,required ValueNotifier<DateTime> dateTimeNotifier}){
    final dformat=DateFormat("dd-MM-yyyy");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: lable,
              style: GoogleFonts.ubuntu(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black87),
              children: [
                TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red)
                )
              ]
          ),
        ),
        SizedBox(height: 14,),
        DateTimeField(
            format: dformat,
            decoration: InputDecoration(
              hintText:"Select Date",
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500)
              ),
              errorText: _validatetoDate?'Field Can\'t Empty':null,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade500)
              ),
            ),
            controller: toDate,
            onShowPicker: (context,currentValue){

              return showDatePicker(
                  context: context,
                  initialDate: _dateTimeNotifier.value,
                  firstDate: _dateTimeNotifier.value,
                  lastDate: DateTime(2100));
            }),
        SizedBox(height: 20,)
      ],
    );
  }

}


