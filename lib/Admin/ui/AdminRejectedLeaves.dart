import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../EndUser/shared/leaveform.dart';
import 'AdminAllLeaveDetails.dart';

class AdminRejectedLeaves extends StatefulWidget {
  const AdminRejectedLeaves({Key? key}) : super(key: key);

  @override
  State<AdminRejectedLeaves> createState() => _AdminRejectedLeavesState();
}

class _AdminRejectedLeavesState extends State<AdminRejectedLeaves> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("rejectedleaves").orderBy("timestamp", descending: true).snapshots(),
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData) {
            final todayLeaves = <DocumentSnapshot>[];
            final previousLeaves = <DocumentSnapshot>[];
            snapshot.data!.docs.forEach((documentSnapshot) {
              final timestamp = documentSnapshot["timestamp"] as Timestamp;
              final today = DateTime.now();
              final leaveDate = DateTime.fromMillisecondsSinceEpoch(
                  timestamp.millisecondsSinceEpoch);

              if (leaveDate.day == today.day &&
                  leaveDate.month == today.month &&
                  leaveDate.year == today.year) {
                todayLeaves.add(documentSnapshot);
              } else {
                previousLeaves.add(documentSnapshot);
              }
            });
            return Container(
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(todayLeaves.isNotEmpty)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Today's Leaves", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),),
                            ),
                            ListView.builder(
                                itemCount: todayLeaves.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot documentSnapshot = todayLeaves[index];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              AdminAllLeaveDetials(leaveForm:
                                              LeaveForm(
                                                  leave_id: documentSnapshot.id,
                                                  name: documentSnapshot["name"],
                                                  emp_profile: documentSnapshot["emp_profile"],
                                                  employee_id: documentSnapshot['employee_id'],
                                                  emp_id: documentSnapshot["emp_id"],
                                                  mail: documentSnapshot["mail"],
                                                  dept: documentSnapshot["dept"],
                                                  leavetype: documentSnapshot["leavetype"],
                                                  fromDate: documentSnapshot["fromDate"],
                                                  toDate: documentSnapshot["toDate"],
                                                  reason: documentSnapshot["reason"],
                                                  timestamp: documentSnapshot["timestamp"],
                                                  status: documentSnapshot["status"]
                                              ),)));
                                    },
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15)
                                        ),
                                        child: Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisSize: MainAxisSize
                                                        .max,
                                                    children: [
                                                      Container(
                                                        width: 55,
                                                        height: 55,
                                                        child: CircleAvatar(
                                                          radius: 40,
                                                          backgroundColor: Colors
                                                              .green,
                                                          foregroundColor: Colors
                                                              .green,
                                                          backgroundImage: NetworkImage(
                                                              documentSnapshot["emp_profile"]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        documentSnapshot["name"],
                                                        style: GoogleFonts.ubuntu(
                                                            color: Colors
                                                                .black),),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        documentSnapshot["leavetype"],
                                                        style: GoogleFonts.ubuntu(
                                                            color: Colors
                                                                .purple),),
                                                      SizedBox(height: 10,),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius: BorderRadius
                                                              .circular(5)
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                              documentSnapshot["status"],
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                  color: documentSnapshot["status"] ==
                                                                      "Approved"
                                                                      ? Colors
                                                                      .green
                                                                      : Colors
                                                                      .red)))),
                                                  Text((DateFormat(
                                                      'dd-MM-yyyy hh:mm').format(
                                                      (documentSnapshot["timestamp"] as Timestamp)
                                                          .toDate())),
                                                    style: GoogleFonts.ubuntu(
                                                        color: Colors.black,fontSize: 12),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                    if(todayLeaves.isEmpty)
                      Container(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Today's Leaves", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: Center(child: Text("No Records Found",
                              style: TextStyle(color: Colors.white),),),
                          )

                        ],
                      ),),
                    if(previousLeaves.isNotEmpty)
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text("Previous Leaves", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),),
                            ),
                            ListView.builder(
                                itemCount: previousLeaves.length,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot documentSnapshot = previousLeaves[index];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              AdminAllLeaveDetials(leaveForm:
                                              LeaveForm(
                                                  leave_id: documentSnapshot.id,
                                                  name: documentSnapshot["name"],
                                                  emp_profile: documentSnapshot["emp_profile"],
                                                  employee_id: documentSnapshot['employee_id'],
                                                  emp_id: documentSnapshot["emp_id"],
                                                  mail: documentSnapshot["mail"],
                                                  dept: documentSnapshot["dept"],
                                                  leavetype: documentSnapshot["leavetype"],
                                                  fromDate: documentSnapshot["fromDate"],
                                                  toDate: documentSnapshot["toDate"],
                                                  reason: documentSnapshot["reason"],
                                                  timestamp: documentSnapshot["timestamp"],
                                                  status: documentSnapshot["status"]
                                              ),)));
                                    },
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15)
                                        ),
                                        child: Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    mainAxisSize: MainAxisSize
                                                        .max,
                                                    children: [
                                                      Container(
                                                        width: 55,
                                                        height: 55,
                                                        child: CircleAvatar(
                                                          radius: 40,
                                                          backgroundColor: Colors
                                                              .green,
                                                          foregroundColor: Colors
                                                              .green,
                                                          backgroundImage: NetworkImage(
                                                              documentSnapshot["emp_profile"]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        documentSnapshot["name"],
                                                        style: GoogleFonts.ubuntu(
                                                            color: Colors
                                                                .black),),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        documentSnapshot["leavetype"],
                                                        style: GoogleFonts.ubuntu(
                                                            color: Colors
                                                                .purple),),
                                                      SizedBox(height: 10,),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .blueAccent),
                                                          borderRadius: BorderRadius
                                                              .circular(5)
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                              documentSnapshot["status"],
                                                              style: GoogleFonts
                                                                  .ubuntu(
                                                                  color: documentSnapshot["status"] ==
                                                                      "Approved"
                                                                      ? Colors
                                                                      .green
                                                                      : Colors
                                                                      .red)))),
                                                  Text((DateFormat(
                                                      'dd-MM-yyyy hh:mm').format(
                                                      (documentSnapshot["timestamp"] as Timestamp)
                                                          .toDate())),
                                                    style: GoogleFonts.ubuntu(
                                                        color: Colors.black,fontSize: 12),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                    if(previousLeaves.isEmpty)
                      Container(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Previous Leaves", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),),
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: Center(child: Text("No Records Found",
                              style: TextStyle(color: Colors.white),),),
                          )

                        ],
                      ),),
                  ],
                )
            );
          }
          return Center(child: Text('No records'),);
        },
      ),
    );
  }
}
