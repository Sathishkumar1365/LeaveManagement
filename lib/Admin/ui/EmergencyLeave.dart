import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../EndUser/services/PushNotification.dart';
import '../../EndUser/shared/Emergencyform.dart';
import 'EmergencyDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UEmergency extends StatefulWidget {
  const UEmergency({Key? key}) : super(key: key);

  @override
  State<UEmergency> createState() => _UEmergencyState();
}

class _UEmergencyState extends State<UEmergency> {
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
          title: Text('Emergency Leave',style: GoogleFonts.inder(),),
        ),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("emergencyleave").snapshots(),
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
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>EmergencyDetails(emergencyForm:
                              EmergencyForm(
                                  leave_id:documentSnapshot.id,
                                  employee_id: documentSnapshot["employee_id"],
                                  emp_profile: documentSnapshot["emp_profile"],
                                  emp_id: documentSnapshot["emp_id"],
                                  name: documentSnapshot["name"],
                                  mail: documentSnapshot["mail"],
                                  dept: documentSnapshot["dept"],
                                  fromDate: (documentSnapshot["fromDate"] as Timestamp).toDate(),
                                  toDate: (documentSnapshot["toDate"] as Timestamp).toDate(),
                                  leavetype: documentSnapshot["leavetype"],
                                  reason: documentSnapshot["reason"],
                                timestamp: documentSnapshot["timestamp"]
                              ), )));
                            },
                            leading: CircleAvatar(backgroundImage: NetworkImage(documentSnapshot["emp_profile"]),radius: 30,),
                            title: Text(name_id,style: GoogleFonts.roboto(color: Colors.white),),
                            subtitle:Text(documentSnapshot["leavetype"],style: GoogleFonts.roboto(color: Colors.white)),
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
                                  sendNotifictaion("your Emergency Application is Approved", documentSnapshot["token"]);
                                  await FirebaseFirestore.instance.collection("emergencyleave").doc(documentSnapshot.id).delete().
                                  then((value) =>FirebaseFirestore.instance.collection('approvedemergencyleave').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'leavetype':documentSnapshot["leavetype"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'fromDate': (documentSnapshot["fromDate"] as Timestamp).toDate(),
                                    'toDate':(documentSnapshot["toDate"] as Timestamp).toDate(),
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Approved'
                                  }) ).then((value) => FirebaseFirestore.instance.collection('allemergencyleaves').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'leavetype':documentSnapshot['leavetype'],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'fromDate': (documentSnapshot["fromDate"] as Timestamp).toDate(),
                                    'toDate':(documentSnapshot["toDate"] as Timestamp).toDate(),
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Approved'
                                  })).then((value) => FirebaseFirestore.instance.collection('previous').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'leavetype':documentSnapshot['leavetype'],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'fromDate':(DateFormat('dd-MM-yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate()).toString()),
                                    'toDate':(DateFormat('dd-MM-yyyy').format((documentSnapshot["toDate"]as Timestamp).toDate()).toString()),
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Approved'
                                  }));
                                },
                                child: Text("Approve",style: GoogleFonts.roboto(color: Colors.green),)),
                            SizedBox(width: 30,),
                            OutlinedButton(
                                style: ButtonStyle(
                                    side:MaterialStateProperty.all(BorderSide(color: Colors.red))
                                ),
                                onPressed: ()async{
                                  sendNotifictaion("your Emergency Application is Rejected", documentSnapshot["token"]);
                                  await FirebaseFirestore.instance.collection("emergencyleave").doc(documentSnapshot.id).delete().
                                  then((value) =>FirebaseFirestore.instance.collection('rejectedemergencyleave').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'leavetype':documentSnapshot["leavetype"],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'fromDate': (documentSnapshot["fromDate"] as Timestamp).toDate(),
                                    'toDate':(documentSnapshot["toDate"] as Timestamp).toDate(),
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Rejected'
                                  })).then((value) => FirebaseFirestore.instance.collection('allemergencyleaves').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'leavetype':documentSnapshot['leavetype'],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'fromDate': (documentSnapshot["fromDate"] as Timestamp).toDate(),
                                    'toDate':(documentSnapshot["toDate"] as Timestamp).toDate(),
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Rejected'
                                  })).then((value) => FirebaseFirestore.instance.collection('previous').doc().set({
                                    'dept':documentSnapshot["dept"],
                                    'emp_id':documentSnapshot["emp_id"],
                                    'employee_id':documentSnapshot["employee_id"],
                                    'emp_profile':documentSnapshot["emp_profile"],
                                    'leave_id':documentSnapshot["leave_id"],
                                    'leavetype':documentSnapshot['leavetype'],
                                    'mail':documentSnapshot['mail'],
                                    'name':documentSnapshot['name'],
                                    'reason':documentSnapshot['reason'],
                                    'fromDate': (DateFormat('dd-MM-yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate()).toString()),
                                    'toDate':(DateFormat('dd-MM-yyyy').format((documentSnapshot["toDate"]as Timestamp).toDate()).toString()),
                                    'timestamp':documentSnapshot['timestamp'],
                                    'status':'Rejected'
                                  }));

                                },
                                child: Text('Reject',style:GoogleFonts.roboto(color: Colors.red)))
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