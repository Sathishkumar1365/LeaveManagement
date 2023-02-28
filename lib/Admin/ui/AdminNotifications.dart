import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:leavemanagement/EndUser/services/PushNotification.dart';

import '../../EndUser/shared/leaveform.dart';
import '../services/Admin_AddEmployee.dart';
import 'Leave_Details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({Key? key}) : super(key: key);

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {

  PushNotification pushNotification=PushNotification();
  late AdminAddEmp db;
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text('Notifications',style: GoogleFonts.inder(),),
      ),
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection("leave").orderBy("timestamp",descending: true).snapshots(),
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context,index){
                  DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                  //String name_id=documentSnapshot["name"]+"["+documentSnapshot["employe_id"]+"]";
                  return Column(
                    children: [
                      Card(
                        color: Colors.black26,
                        child: ListTile(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>UserLeaveDetails(leave:
                            LeaveForm(
                                leave_id:documentSnapshot.id,
                                name: documentSnapshot["name"],
                                emp_profile: documentSnapshot["emp_profile"],
                                emp_id: documentSnapshot["emp_id"],
                                employee_id: documentSnapshot["employe_id"],
                                mail: documentSnapshot["mail"],
                                dept: documentSnapshot["dept"],
                                leavetype: documentSnapshot["leavetype"],
                                fromDate: documentSnapshot["fromDate"],
                                toDate: documentSnapshot["toDate"],
                                reason: documentSnapshot["reason"],
                              timestamp: documentSnapshot["timestamp"],
                              token:documentSnapshot["token"]
                            ),
                            )));
                          },
                          leading: CircleAvatar(backgroundImage:NetworkImage(documentSnapshot["emp_profile"]),radius: 30,),
                          title: Text(documentSnapshot["name"]+"[ "+documentSnapshot["employe_id"]+" ]",style: GoogleFonts.roboto(color: Colors.white)),
                          subtitle:Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documentSnapshot["leavetype"],style: GoogleFonts.roboto(color: Colors.white)),
                              Text((DateFormat('dd-MM-yyyy  hh:mm').format((documentSnapshot["timestamp"] as Timestamp).toDate())),style: GoogleFonts.roboto(color: Colors.white,fontSize: 12))
                            ],
                          ),

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 22,),
                          OutlinedButton(
                              style: ButtonStyle(
                                  side:MaterialStateProperty.all(BorderSide(color: Colors.green))
                              ),
                              onPressed: ()async{
                                sendNotifictaion("your Application is Approved",documentSnapshot["token"]);
                                await FirebaseFirestore.instance.collection("leave").doc(documentSnapshot.id).delete().
                                then((value) =>
                                    FirebaseFirestore.instance.collection('approvedleave').doc().set({
                                      'dept':documentSnapshot["dept"],
                                      'emp_id':documentSnapshot["emp_id"],
                                      'employee_id':documentSnapshot["employe_id"],
                                      'emp_profile':documentSnapshot["emp_profile"],
                                      'fromDate':documentSnapshot["fromDate"],
                                      'leave_id':documentSnapshot["leave_id"],
                                      'leavetype':documentSnapshot['leavetype'],
                                      'mail':documentSnapshot['mail'],
                                      'name':documentSnapshot['name'],
                                      'reason':documentSnapshot['reason'],
                                      'toDate':documentSnapshot['toDate'],
                                      'timestamp':documentSnapshot['timestamp'],
                                      'status':'Approved'
                                    }).then((value) =>
                                        FirebaseFirestore.instance.collection('allleaves').doc().set({
                                          'dept':documentSnapshot["dept"],
                                          'emp_id':documentSnapshot["emp_id"],
                                          'employee_id':documentSnapshot["employe_id"],
                                          'emp_profile':documentSnapshot["emp_profile"],
                                          'fromDate':documentSnapshot["fromDate"],
                                          'leave_id':documentSnapshot["leave_id"],
                                          'leavetype':documentSnapshot['leavetype'],
                                          'mail':documentSnapshot['mail'],
                                          'name':documentSnapshot['name'],
                                          'reason':documentSnapshot['reason'],
                                          'toDate':documentSnapshot['toDate'],
                                          'timestamp':documentSnapshot['timestamp'],
                                          'status':'Approved'
                                        })).then((value) =>
                                        FirebaseFirestore.instance.collection('previous').doc().set({
                                          'dept':documentSnapshot["dept"],
                                          'emp_id':documentSnapshot["emp_id"],
                                          'employee_id':documentSnapshot["employe_id"],
                                          'emp_profile':documentSnapshot["emp_profile"],
                                          'fromDate':documentSnapshot["fromDate"],
                                          'leave_id':documentSnapshot["leave_id"],
                                          'leavetype':documentSnapshot['leavetype'],
                                          'mail':documentSnapshot['mail'],
                                          'name':documentSnapshot['name'],
                                          'reason':documentSnapshot['reason'],
                                          'toDate':documentSnapshot['toDate'],
                                          'timestamp':documentSnapshot['timestamp'],
                                          'status':'Approved'
                                        }))
                                );
                              },
                              child: Text("Accept",style: TextStyle(color: Colors.green),)),
                          SizedBox(width: 30,),
                          OutlinedButton(
                              style: ButtonStyle(
                                  side:MaterialStateProperty.all(BorderSide(color: Colors.red))
                              ),
                              onPressed: ()async{
                                sendNotifictaion("your Application is Rejected",documentSnapshot["token"]);
                                await FirebaseFirestore.instance.collection("leave").doc(documentSnapshot.id).delete().
                                then((value) =>FirebaseFirestore.instance.collection('rejectedleaves').doc().set({
                                  'dept':documentSnapshot["dept"],
                                  'emp_id':documentSnapshot["emp_id"],
                                  'employee_id':documentSnapshot["employe_id"],
                                  'emp_profile':documentSnapshot["emp_profile"],
                                  'fromDate':documentSnapshot["fromDate"],
                                  'leave_id':documentSnapshot["leave_id"],
                                  'leavetype':documentSnapshot['leavetype'],
                                  'mail':documentSnapshot['mail'],
                                  'name':documentSnapshot['name'],
                                  'reason':documentSnapshot['reason'],
                                  'toDate':documentSnapshot['toDate'],
                                  'timestamp':documentSnapshot['timestamp'],
                                  'status':'Rejected'
                                }).then((value) => FirebaseFirestore.instance.collection('allleaves').doc().set({
                                  'dept':documentSnapshot["dept"],
                                  'emp_id':documentSnapshot["emp_id"],
                                  'employee_id':documentSnapshot["employe_id"],
                                  'emp_profile':documentSnapshot["emp_profile"],
                                  'fromDate':documentSnapshot["fromDate"],
                                  'leave_id':documentSnapshot["leave_id"],
                                  'leavetype':documentSnapshot['leavetype'],
                                  'mail':documentSnapshot['mail'],
                                  'name':documentSnapshot['name'],
                                  'reason':documentSnapshot['reason'],
                                  'toDate':documentSnapshot['toDate'],
                                  'timestamp':documentSnapshot['timestamp'],
                                  'status':'Rejected'
                                })).then((value) => FirebaseFirestore.instance.collection('previous').doc().set({
                                  'dept':documentSnapshot["dept"],
                                  'emp_id':documentSnapshot["emp_id"],
                                  'employee_id':documentSnapshot["employe_id"],
                                  'emp_profile':documentSnapshot["emp_profile"],
                                  'fromDate':documentSnapshot["fromDate"],
                                  'leave_id':documentSnapshot["leave_id"],
                                  'leavetype':documentSnapshot['leavetype'],
                                  'mail':documentSnapshot['mail'],
                                  'name':documentSnapshot['name'],
                                  'reason':documentSnapshot['reason'],
                                  'toDate':documentSnapshot['toDate'],
                                  'timestamp':documentSnapshot['timestamp'],
                                  'status':'Rejected'
                                }))
                                );
                              },
                              child: Text("Reject",style: TextStyle(color: Colors.red),)),

                        ],
                      )
                    ],
                  );
            });
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )
    );
  }
}