import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../shared/Emergencyform.dart';
import '../ui/EmergencyLeaveDetails.dart';
import '../ui/PendingEmergencyDetails.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
infowidget(){
  final User? user = auth.currentUser;
  return StreamBuilder(
    stream:  FirebaseFirestore.instance.collection("allemergencyleaves").where('emp_id',isEqualTo: user!.uid).limit(4).orderBy("timestamp", descending: true).snapshots(),
      builder: (context,snapshot){
      if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context,int index){
            DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
            return Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyLeaveDetails(emergencyForm:
                    EmergencyForm(
                        leave_id: documentSnapshot.id,
                        name:documentSnapshot["name"] ,
                        emp_profile:documentSnapshot["emp_profile"] ,
                        emp_id: documentSnapshot["emp_id"],
                        employee_id: documentSnapshot["employee_id"],
                        mail:  documentSnapshot["mail"],
                        dept: documentSnapshot["dept"],
                        leavetype: documentSnapshot["leavetype"],
                        fromDate: (documentSnapshot["fromDate"] as Timestamp).toDate(),
                        toDate:(documentSnapshot["toDate"] as Timestamp).toDate(),
                        reason: documentSnapshot["reason"],
                        timestamp: documentSnapshot["timestamp"],
                        status: documentSnapshot["status"]
                    ),
                      )));
                  },
                  child: Container(
                      height: 130,
                      width: 420,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                              colors: [
                                Colors.indigo.shade600,
                                Colors.indigo.shade400
                              ]
                          )
                      ),
                      child: Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 18,top: 30),
                                child: CircleAvatar(
                                  radius: 38,
                                  backgroundImage:NetworkImage(documentSnapshot['emp_profile']),),),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                          Text('-',style: TextStyle(color: Colors.white)),
                                          Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["toDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),

                                        ],
                                      ),
                                      SizedBox(height: 3,),
                                      Text(documentSnapshot['leavetype'],style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white)),
                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(child: Text(documentSnapshot['reason'],softWrap: true,overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(color: Colors.white),))
                                          //Text(documentSnapshot['reason'],softWrap: true,overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(color: Colors.white),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(height: 15,)
              ],
            );
          },

        );
      }
      return CircularProgressIndicator();
      });
}

ApprovedEmergency(){
  final User? user = auth.currentUser;
  return StreamBuilder(
      stream:  FirebaseFirestore.instance.collection("approvedemergencyleave").where('emp_id',isEqualTo: user!.uid).limit(4).orderBy("timestamp", descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context,int index){
              DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyLeaveDetails(emergencyForm:
                      EmergencyForm(
                          leave_id: documentSnapshot.id,
                          employee_id: documentSnapshot["employee_id"],
                          name:documentSnapshot["name"] ,
                          emp_profile:documentSnapshot["emp_profile"] ,
                          emp_id: documentSnapshot["emp_id"],
                          mail:  documentSnapshot["mail"],
                          dept: documentSnapshot["dept"],
                          leavetype: documentSnapshot["leavetype"],
                          fromDate: (documentSnapshot["fromDate"] as Timestamp).toDate(),
                          toDate:(documentSnapshot["toDate"] as Timestamp).toDate(),
                          reason: documentSnapshot["reason"],
                          timestamp: documentSnapshot["timestamp"],
                          status: documentSnapshot["status"]
                      ),
                      )));
                    },
                    child: Container(
                        height: 130,
                        width: 420,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.indigo.shade600,
                                  Colors.indigo.shade400
                                ]
                            )
                        ),
                        child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18,top: 30),
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundImage:NetworkImage(documentSnapshot['emp_profile']),),),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                            Text('-',style: TextStyle(color: Colors.white)),
                                            Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["toDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                            //Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                          ],
                                        ),
                                        SizedBox(height: 3,),
                                        Text(documentSnapshot['leavetype'],style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white)),
                                        SizedBox(height: 15,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(child: Text(documentSnapshot['reason'],softWrap: true,overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(color: Colors.white),))
                                            //Text(documentSnapshot['reason'],softWrap: true,overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(color: Colors.white),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 15,)
                ],
              );
            },

          );
        }
        return CircularProgressIndicator();
      });
}
rejectedemergency(){
  final User? user = auth.currentUser;
  return StreamBuilder(
      stream:  FirebaseFirestore.instance.collection("rejectedemergencyleave").where('emp_id',isEqualTo: user!.uid).limit(4).orderBy("timestamp", descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context,int index){
              DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyLeaveDetails(emergencyForm:
                      EmergencyForm(
                          leave_id: documentSnapshot.id,
                          employee_id: documentSnapshot["employee_id"],
                          name:documentSnapshot["name"] ,
                          emp_profile:documentSnapshot["emp_profile"] ,
                          emp_id: documentSnapshot["emp_id"],
                          mail:  documentSnapshot["mail"],
                          dept: documentSnapshot["dept"],
                          leavetype: documentSnapshot["leavetype"],
                          fromDate: (documentSnapshot["fromDate"] as Timestamp).toDate(),
                          toDate:(documentSnapshot["toDate"] as Timestamp).toDate(),
                          reason: documentSnapshot["reason"],
                          timestamp: documentSnapshot["timestamp"],
                          status: documentSnapshot["status"]
                      ),
                      )));
                    },
                    child: Container(
                        height: 130,
                        width: 420,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.indigo.shade600,
                                  Colors.indigo.shade400
                                ]
                            )
                        ),
                        child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18,top: 30),
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundImage:NetworkImage(documentSnapshot['emp_profile']),),),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                            Text('-',style: TextStyle(color: Colors.white)),
                                            Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["toDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                            //Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                          ],
                                        ),
                                        SizedBox(height: 3,),
                                        Text(documentSnapshot['leavetype'],style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white)),
                                        SizedBox(height: 15,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(child: Text(documentSnapshot['reason'],softWrap: true,overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(color: Colors.white),))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 15,)
                ],
              );
            },

          );
        }
        return CircularProgressIndicator();
      });
}
pendingemergency(){
  final User? user = auth.currentUser;
  return StreamBuilder(
      stream:  FirebaseFirestore.instance.collection("emergencyleave").where('emp_id',isEqualTo: user!.uid).limit(4).orderBy("timestamp", descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context,int index){
              DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingEmergencyDetails(
                        emergencyForm: EmergencyForm(
                            leave_id: documentSnapshot.id,
                            employee_id: documentSnapshot["employee_id"],
                            name:documentSnapshot["name"] ,
                            emp_profile:documentSnapshot["emp_profile"] ,
                            emp_id: documentSnapshot["emp_id"],
                            mail:  documentSnapshot["mail"],
                            dept: documentSnapshot["dept"],
                            leavetype: documentSnapshot["leavetype"],
                            fromDate: (documentSnapshot["fromDate"] as Timestamp).toDate(),
                            toDate:(documentSnapshot["toDate"] as Timestamp).toDate(),
                            reason: documentSnapshot["reason"],
                            timestamp: documentSnapshot["timestamp"],
                        ),
                      )));
                    },
                    child: Container(
                        height: 130,
                        width: 420,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.indigo.shade600,
                                  Colors.indigo.shade400
                                ]
                            )
                        ),
                        child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18,top: 30),
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundImage:NetworkImage(documentSnapshot['emp_profile']),),),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                              Text('-',style: TextStyle(color: Colors.white),),
                                              Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["toDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                              //Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
                                            ],
                                          ),
                                          SizedBox(height: 3,),
                                          Flexible(child: Text(documentSnapshot['leavetype'],style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white))),
                                          SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(child: Text(documentSnapshot['reason'],softWrap: true,overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(color: Colors.white),))
                                            ],
                                          )
                                        ],
                                      ),
                                  ),
                                )
                              ],
                            ),

                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 15,)
                ],
              );
            },

          );
        }
        return CircularProgressIndicator();
      });
}