import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../Admin/shared/emp_info.dart';
import '../../Admin/shared/user_provider.dart';
import '../services/Emergencyapply.dart';
import '../services/PushNotification.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/AlreadyTakenAnim.dart';
import '../widgets/EmergencySentAnimation.dart';
import 'UserHome.dart';

class Emergency extends StatefulWidget {
  final Employees? employees;
  const Emergency({Key? key, this.employees}) : super(key: key);

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  ValueNotifier<DateTime> _dateTimeNotifier = ValueNotifier<DateTime>(DateTime.now());
  TextEditingController name=TextEditingController();
  TextEditingController mail=TextEditingController();
  TextEditingController dept=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController leavetype=TextEditingController();
  TextEditingController reason=TextEditingController();
  TextEditingController toDate=TextEditingController();
  TextEditingController employeeid=TextEditingController();
  String? dropdownvalue;
  final dropdowncontroller=TextEditingController();
  int currentStep=0;
  bool _validateReason=false;
  bool _validatefromDate=false;
  bool _validatetoDate=false;
  bool _validateleavetype=false;
  bool _isloading=false;
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.value=TextEditingValue(text: widget.employees!.emp_name);
    mail.value=TextEditingValue(text: widget.employees!.emp_mail);
    dept.value=TextEditingValue(text: widget.employees!.emp_dept);
    employeeid.value=TextEditingValue(text: widget.employees!.employee_id);
    addData();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  PushNotification pushNotification=PushNotification();


  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
        backgroundColor: Colors.green,
        elevation: 10,
        title: Text('Apply Emergency Leave'),
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
                  if(isLastStep){
                    DocumentSnapshot? token;
                    try {
                      DocumentSnapshot tokens=snapshot.data!.docs.last;
                      token = tokens;
                    } catch (e) {
                      print(e.toString());
                    }
                    DateTime selectedDate = DateFormat("dd-MM-yyyy").parse(date.text);
                    DateTime toSelected=DateFormat("dd-MM-yyyy").parse(toDate.text);
                    setState((){
                      reason.text.isEmpty?_validateReason=true:_validateReason=false;
                      selectedDate==null?_validatefromDate=true:_validatetoDate=false;
                      toSelected==null?_validatetoDate=true:_validatetoDate=false;
                      dropdowncontroller.text.isEmpty?_validateleavetype=true:_validateleavetype=false;
                    });
                    String? emp_token=await FirebaseMessaging.instance.getToken();
                    var employeeSnapshot=await FirebaseFirestore.instance.collection('employees').where('emp_id',isEqualTo:user!.uid).get();
                    if(employeeSnapshot.docs.length==0){
                      print("Employee is not registered");
                    }
                  final querysnapshot=FirebaseFirestore.instance.collection('allemergencyleaves').
                  where('emp_id',isEqualTo:user.uid).
                  get().then((snaphsot) async {
                    int leaveTaken=0;
                    if(_validatefromDate==false&&_validatetoDate==false&&_validateReason==false&&_validateleavetype==false){
                      if(snaphsot.docs.length>0){
                        for (var i = 0; i < snaphsot.docs.length; i++) {
                          DocumentSnapshot snap = snaphsot.docs[i];
                          DateTime fromleaveDate = snap.get('fromDate').toDate();
                          DateTime toleaveDate=snap.get('toDate').toDate();

                          if ((selectedDate.month == fromleaveDate.month && selectedDate.year == fromleaveDate.year) || (toSelected.month == toleaveDate.month && toSelected.year == toleaveDate.year) ||
                              (selectedDate.month < fromleaveDate.month && toSelected.month > toleaveDate.month && selectedDate.year == fromleaveDate.year && toSelected.year == toleaveDate.year)) {
                            leaveTaken++;
                          }
                        }
                      }
                    }
                  if(leaveTaken>=1){
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
                                  Lottie.network('https://assets10.lottiefiles.com/packages/lf20_U60Y3Wpvkx.json',height:200,repeat:true),
                                  Text("You have already taken \nLeave for this month ",textAlign: TextAlign.center,style: GoogleFonts.kanit(fontSize: 20,color: Colors.black)),
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
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>AlreadyTaken()));
                  } else{
                    if(_validatefromDate==false&&_validatetoDate==false&&_validateReason==false&&_validateleavetype==false){
                      setState(() {
                        _isloading=true;
                      });
                      String? res=await EmergencyApply().applyemergencyleave(emp_id:user.uid,employee_id:employeeid.text,emp_profile: widget.employees!.emp_profile, emp_name: name.text, emp_mail: mail.text, emp_dept: dept.text, leavetype: dropdowncontroller.text, fromDate: selectedDate,toDate: toSelected, reason: reason.text,timestamp: Timestamp.now(),token:emp_token!);
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
                                      Text("Emergency Leave Applied \nSuccessfully",style: GoogleFonts.kanit(fontSize: 20,color: Colors.black)),
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
                       // _isloading?Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencySent())):Center(child:CircularProgressIndicator());
                        sendNotifictaion("Requested Emeregency Leave", token!.get('token'));
                      }
                    else{
                      setState(() {
                        _isloading=false;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some Fields Are Incorrect')));
                      });

                    }
                    }
                  }
                  });
                  }else
                    setState(() {
                      currentStep+=1;
                    });
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
        title: Text('Date',style: GoogleFonts.poppins(fontWeight:FontWeight.bold),),
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
              child: DropdownButtonFormField(
                  hint: Text("Select Leave Type"),
                isExpanded: true,
                  value: dropdownvalue,
                  decoration: InputDecoration(
                    errorText: _validateleavetype?'Field Can\'t Empty':null,
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                    ),
                  ),
                  items: <String>['Parental Leave','Sick Leave','Accidental Leave','Condolence Leave','Public issues'].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem(
                        value: value,
                        child: Text(value));
                  }).toList(),
                  onChanged: (String? newvalue){
                    setState(() {
                      dropdownvalue=newvalue;
                      dropdowncontroller.text=newvalue!;
                      _validateleavetype=false;
                    });
                  })
            ),
            SizedBox(height: 25,),
            DateInput(lable: 'From Date',hint:'Enter Date',suffixIcon: Icon(Icons.calendar_month_sharp),),
            SizedBox(height: 10,),
            toDateInput(lable: 'ToDate',hint: 'Enter Date',suffixIcon: Icon(Icons.calendar_month_sharp)),
            SizedBox(height: 10,)
          ],
        )),
    Step(
        state: currentStep>1?StepState.complete:StepState.indexed,
        isActive: currentStep>=1,
        title: Text('Final',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          maxLines: 5,
          controller: reason,
          decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)
              ),
              errorText: _validateReason?'Field Can\'t Empty':null,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400)
              )
          ),
        ),
      ],
    );
  }

  Widget DateInput({lable,suffixIcon,hint}){
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
                errorText: _validatefromDate?'Field Can\'t Empty':null,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                )
            ),
            controller:date,
            onShowPicker: (context,currentValue)async{
              final  DateTime? picked=await showDatePicker(
                  context: context,
                  initialDate: _dateTimeNotifier.value,
                  firstDate: _dateTimeNotifier.value,
                  lastDate: DateTime(2100));
                  if(picked != null) {
                setState(() {
                  
                  date.text =dformat.format(picked);
                });
              }if(picked==null){
                    setState((){
                      date.text.isEmpty?_validatefromDate=true:_validatefromDate=false;
                    });
              }
            }),
        SizedBox(height: 20,)
      ],
    );
  }
  Widget toDateInput({lable,suffixIcon,hint}){
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
                errorText: _validatetoDate?'Field Can\'t Empty':null,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500)
                )
            ),
            controller:toDate,
            onShowPicker: (context,currentValue)async{
              final  DateTime? picked=await showDatePicker(
                  context: context,
                  initialDate: _dateTimeNotifier.value,
                  firstDate: _dateTimeNotifier.value,
                  lastDate: DateTime(2100));
              if(picked != null) {
                setState(() {
                  toDate.text = dformat.format(picked);
                });
              }if(picked==null){
                setState((){
                  toDate.text.isEmpty?_validatetoDate=true:_validatetoDate=false;
                });

              }
            }),
        SizedBox(height: 20,)
      ],
    );
  }
}
