import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Admin/shared/emp_info.dart';
import '../../Admin/shared/user_provider.dart';
import '../services/PushNotification.dart';
import '../services/permissionapply.dart';
import 'dart:convert';

import '../widgets/PermissionSentAnimation.dart';
import 'UserHome.dart';

class Permission extends StatefulWidget {
  final Employees? employees;
  const Permission({Key? key, this.employees}) : super(key: key);

  @override
  State<Permission> createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController name=TextEditingController();
  TextEditingController mail=TextEditingController();
  TextEditingController dept=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController fromtime=TextEditingController();
  TextEditingController toTime=TextEditingController();
  TextEditingController reason=TextEditingController();
  TextEditingController employeeid=TextEditingController();
  int currentStep=0;
  bool _validateDate=false;
  bool _validatefromTime=false;
  bool _validateToTime=false;
  bool _reason=false;
  PushNotification pushNotification=PushNotification();
  addData()async{
    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.refreshEmp();
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
  ValueNotifier<DateTime> _dateTimeNotifier = ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.value=TextEditingValue(text: widget.employees!.emp_name);
    mail.value=TextEditingValue(text: widget.employees!.emp_mail);
    dept.value=TextEditingValue(text: widget.employees!.emp_dept);
    employeeid.value=TextEditingValue(text:widget.employees!.employee_id);
    addData();
  }
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
        backgroundColor: Colors.green,
        elevation: 10,
        title: Text('Apply Permission'),
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: Icon(Icons.arrow_back_ios)),
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
                  if(isLastStep){
                    setState(() {
                      date.text.isEmpty?_validateDate=true:_validateDate=false;
                      fromtime.text.isEmpty?_validatefromTime=true:_validatefromTime=false;
                      toTime.text.isEmpty?_validateToTime=true:_validateToTime=false;
                      reason.text.isEmpty?_reason=true:_reason=false;
                    });
                    DocumentSnapshot? token;
                    String? emp_token=await FirebaseMessaging.instance.getToken();
                    try {
                      DocumentSnapshot tokens=snapshot.data!.docs.last;
                      token = tokens;
                    } catch (e) {
                      print(e.toString());
                    }
                    if(_validateDate==false&&_validatefromTime==false&&_validateToTime==false&&_reason==false){
                      String? res=await PermissionApply().applypermission(
                          emp_id:user!.uid,
                          emp_profile: widget.employees!.emp_profile,
                          employee_id: employeeid.text,
                          emp_name: name.text,
                          emp_mail: mail.text,
                          emp_dept: dept.text,
                          date: date.text,
                          reason: reason.text,
                          fromtime: fromtime.text,
                          totime: toTime.text,
                          timestamp: Timestamp.now(),
                          status: 'Pending',
                          token:emp_token!);
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
                                      Text("Permission Applied Successfully",style: GoogleFonts.kanit(fontSize: 20,color: Colors.black)),
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
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>PermissionSent()));
                        sendNotifictaion("Requested Permission", token!.get('token'));
                      }
                    }
                  }else{
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
        isActive: currentStep>0,
        title: Text('Permission',style: GoogleFonts.poppins(fontWeight:FontWeight.bold),),
        content: Column(
          children: [
            DateInput(dateTimeNotifier: _dateTimeNotifier,lable: 'Select Date',hint: 'Enter Date',suffixIcon:Icon(Icons.calendar_month_sharp)),
            SizedBox(height: 10,),
            fromTime(dateTimeNotifier: _dateTimeNotifier,lable: 'Select Time',hint: 'Enter Time',suffixIcon: Icon(Icons.alarm)),
            SizedBox(height: 10,),
            totime(dateTimeNotifier: _dateTimeNotifier,lable: 'Select End Time',hint: 'Enter End Time',suffixIcon:Icon(Icons.alarm) )

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
              errorText: _reason?'Field Can\'t Empty':null,
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
  Widget DateInput({lable,suffixIcon,hint,required ValueNotifier<DateTime> dateTimeNotifier}){
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
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                ),
                errorText: _validateDate?'Field Can\'t Empty':null,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                )
            ),
            controller: date,
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
  Widget fromTime({lable,suffixIcon,hint,required ValueNotifier<DateTime> dateTimeNotifier}) {
    final dformat = DateFormat("HH:mm");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: lable,
              style: GoogleFonts.ubuntu(fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
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
              hintText: "Select Time",
                suffixIcon: suffixIcon,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                ),
                errorText: _validatefromTime?'Field Can\'t Empty':null,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                )
            ),
            controller: fromtime,
            onShowPicker: (context, currentValue) async{
              final stime= await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(stime);
            }),
        SizedBox(height: 20,)
      ],
    );
  }
  Widget totime({lable,suffixIcon,hint,required ValueNotifier<DateTime> dateTimeNotifier}) {
    final dformat = DateFormat("HH:mm");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: lable,
              style: GoogleFonts.ubuntu(fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
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
                hintText: "Select Time",
                suffixIcon: suffixIcon,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                ),
                errorText: _validateToTime?'Field Can\'t Empty':null,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                )
            ),
            controller: toTime,
            onShowPicker: (context, currentValue) async{
              final stime= await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(stime);
            }),
        SizedBox(height: 20,)
      ],
    );
  }

  }
