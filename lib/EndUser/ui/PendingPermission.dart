import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../shared/PermissionForm.dart';
import 'AllPermissionDetails.dart';
import 'PendingPermissionDetails.dart';

class PendingPermission extends StatefulWidget {
  const PendingPermission({Key? key}) : super(key: key);

  @override
  State<PendingPermission> createState() => _PendingPermissionState();
}

class _PendingPermissionState extends State<PendingPermission> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    return  Scaffold(
        appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black,statusBarIconBrightness: Brightness.light,statusBarBrightness: Brightness.light),
            backgroundColor: Colors.white,
            title: Text('Pending Permission',style: GoogleFonts.ubuntu(color: Colors.black),),
            leading: Padding(
              padding: EdgeInsets.only(left: 16),
              child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),

            )
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("permission").where('emp_id',isEqualTo: user!.uid).orderBy("timestamp", descending: true).snapshots(),
          builder: (BuildContext context,snapshot){
            if(snapshot.hasData){
              return Container(
                color: Colors.white,
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingPermissionDetails(permissionForm:
                          PermissionForm(
                              leave_id: documentSnapshot.id,
                              name:documentSnapshot["name"] ,
                              emp_profile:documentSnapshot["emp_profile"] ,
                            employee_id: documentSnapshot["employee_id"],
                            emp_id: documentSnapshot["emp_id"],
                              mail:  documentSnapshot["mail"],
                              dept: documentSnapshot["dept"],
                              reason: documentSnapshot["reason"],
                              timestamp: documentSnapshot["timestamp"],
                              Date: documentSnapshot["date"],
                              fromtime: documentSnapshot["fromtime"],
                              totime: documentSnapshot["toTime"],
                          ),)));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 55,
                                            height: 55,
                                            child:CircleAvatar(
                                              radius: 40,
                                              backgroundColor: Colors.green,
                                              foregroundColor: Colors.green,
                                              backgroundImage:NetworkImage(documentSnapshot["emp_profile"]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("From Time:"+documentSnapshot["fromtime"],style: GoogleFonts.ubuntu(color: Colors.black),),
                                          SizedBox(height: 10,),
                                          Text("To Time:"+documentSnapshot["toTime"],style: GoogleFonts.ubuntu(color: Colors.black),),
                                          SizedBox(height: 10,),
                                          Text(documentSnapshot["date"],style: GoogleFonts.ubuntu(color: Colors.purple),),
                                          SizedBox(height: 10,),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Applied Date:',style: GoogleFonts.ubuntu(color: Colors.indigo)),
                                      Text((DateFormat('dd-MM-yyyy  hh:mm').format((documentSnapshot["timestamp"] as Timestamp).toDate())),style: GoogleFonts.ubuntu(color: Colors.black,fontSize: 12)),
                                      SizedBox(height: 20,),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration:BoxDecoration(
                                            border: Border.all(color: Colors.blueAccent),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Center(
                                          child: Text('Pending',style: GoogleFonts.ubuntu(color: Colors.brown),),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        )
    );
  }
}
