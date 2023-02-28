import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../EndUser/services/PushNotification.dart';
import '../../EndUser/shared/Emergencyform.dart';
import '../../EndUser/shared/PermissionForm.dart';
import '../services/Admin_AddEmployee.dart';
import 'PermissionDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UPermission extends StatefulWidget {
  const UPermission({Key? key}) : super(key: key);

  @override
  State<UPermission> createState() => _UPermissionState();
}

class _UPermissionState extends State<UPermission> {
  late AdminAddEmp db;
  PushNotification pushNotification=PushNotification();
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text('Permission',style: GoogleFonts.inder(),),
        ),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("permission").orderBy("timestamp",descending: true).snapshots(),
          builder: (BuildContext context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                    String name_id=documentSnapshot["name"]+"[ "+documentSnapshot["employee_id"]+" ]";
                    return Column(
                      children: [
                        Card(
                          color: Colors.black26,
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>UserPermissionDetails(permissionForm:
                              PermissionForm(
                                  leave_id:documentSnapshot.id,
                                  emp_profile: documentSnapshot["emp_profile"],
                                  employee_id: documentSnapshot["employee_id"],
                                  emp_id: documentSnapshot["emp_id"],
                                  name: documentSnapshot["name"],
                                  mail: documentSnapshot["mail"],
                                  dept: documentSnapshot["dept"],
                                  Date: documentSnapshot["date"],
                                  fromtime: documentSnapshot["fromtime"],
                                  totime: documentSnapshot["toTime"],
                                  reason: documentSnapshot["reason"],
                                timestamp: documentSnapshot["timestamp"]
                              ),)));
                            },
                            leading: CircleAvatar(backgroundImage: NetworkImage(documentSnapshot["emp_profile"]),radius: 30,),
                            title: Text(name_id,style: GoogleFonts.roboto(color: Colors.white),),
                            subtitle: Row(children: [
                              Text(documentSnapshot["fromtime"],style: GoogleFonts.roboto(color: Colors.white),),
                              Text("-",style: TextStyle(color: Colors.white),),
                              Text(documentSnapshot["toTime"],style: GoogleFonts.roboto(color: Colors.white))
                            ],),

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
                                  sendNotifictaion("your Permission is Approved", documentSnapshot["token"]);
                                  await FirebaseFirestore.instance.collection("permission").doc(documentSnapshot.id).delete().
                                  then((value) =>FirebaseFirestore.instance.collection('approvedpermission').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'date':documentSnapshot['date'],
                                    'fromtime':documentSnapshot['fromtime'],
                                    'toTime':documentSnapshot['toTime'],
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Approved'
                                  })).then((value) =>FirebaseFirestore.instance.collection('allpermissions').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'date':documentSnapshot['date'],
                                    'fromtime':documentSnapshot['fromtime'],
                                    'toTime':documentSnapshot['toTime'],
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Approved'
                                  })).then((value) =>FirebaseFirestore.instance.collection('previous').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'date':documentSnapshot['date'],
                                    'fromtime':documentSnapshot['fromtime'],
                                    'toTime':documentSnapshot['toTime'],
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Approved'
                                  }));
                                },
                                child: Text('Approve',style: GoogleFonts.roboto(color: Colors.green),)),
                            SizedBox(width: 30,),
                            OutlinedButton(
                                style: ButtonStyle(
                                    side:MaterialStateProperty.all(BorderSide(color: Colors.red))
                                ),
                                onPressed: ()async{
                                  sendNotifictaion("your Permission is Rejected", documentSnapshot["token"]);
                                  await FirebaseFirestore.instance.collection("permission").doc(documentSnapshot.id).delete().
                                  then((value) =>FirebaseFirestore.instance.collection('rejectedpermission').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'date':documentSnapshot['date'],
                                    'fromtime':documentSnapshot['fromtime'],
                                    'toTime':documentSnapshot['toTime'],
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Rejected'
                                  })).then((value) =>FirebaseFirestore.instance.collection('allpermissions').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'date':documentSnapshot['date'],
                                    'fromtime':documentSnapshot['fromtime'],
                                    'toTime':documentSnapshot['toTime'],
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'rejected'
                                  })).then((value) =>FirebaseFirestore.instance.collection('previous').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'date':documentSnapshot['date'],
                                    'fromtime':documentSnapshot['fromtime'],
                                    'toTime':documentSnapshot['toTime'],
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Rejected'
                                  }));
                                },
                                child: Text('Reject',style: GoogleFonts.roboto(color: Colors.red)))

                          ],
                        ),
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
