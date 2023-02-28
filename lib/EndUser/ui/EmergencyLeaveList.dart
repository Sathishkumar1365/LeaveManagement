import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../shared/Emergencyform.dart';
import 'EmergencyLeaveDetails.dart';

class EmergencyLeaveList extends StatefulWidget {
  const EmergencyLeaveList({Key? key}) : super(key: key);

  @override
  State<EmergencyLeaveList> createState() => _EmergencyLeaveListState();
}

class _EmergencyLeaveListState extends State<EmergencyLeaveList> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black,statusBarIconBrightness: Brightness.light,statusBarBrightness: Brightness.light),
            backgroundColor: Colors.white,
            title: Text('All emergency Leaves',style: GoogleFonts.ubuntu(color: Colors.black),),
            leading: Padding(
              padding: EdgeInsets.only(left: 16),
              child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),

            )
        ),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("allemergencyleaves").where('emp_id',isEqualTo: user!.uid).orderBy("timestamp", descending: true).snapshots(),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyLeaveDetails(emergencyForm:
                          EmergencyForm(
                              leave_id: documentSnapshot.id,
                              name:documentSnapshot["name"] ,
                              employee_id: documentSnapshot["employee_id"],
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
                                        width: 1,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["fromDate"]as Timestamp).toDate())),style: GoogleFonts.ubuntu(color: Colors.black),),
                                              Text('-'),
                                              Text((DateFormat('dd/MM/yyyy').format((documentSnapshot["toDate"]as Timestamp).toDate())),style: GoogleFonts.ubuntu(color: Colors.black),),


                                            ],
                                          ),
                                          Text(documentSnapshot["leavetype"],style: GoogleFonts.ubuntu(color: Colors.purple),),
                                          SizedBox(height: 10,),
                                          Text((DateFormat('dd-MM-yyyy  hh:mm').format((documentSnapshot["timestamp"] as Timestamp).toDate())),style: GoogleFonts.ubuntu(color: Colors.grey.shade500)),

                                        ],
                                      ),
                                      SizedBox(width: 40,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SizedBox(height:20),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration:BoxDecoration(
                                                  border: Border.all(color: Colors.blueAccent),
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Center(
                                                  child: Text(documentSnapshot["status"],style: GoogleFonts.ubuntu(color: documentSnapshot["status"] == "Approved" ? Colors.green : Colors.red))))
                                        ],
                                      )
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
              );
            }
            return Center(child: Text('No records'),);
          },
        )
    );

  }

}
/* @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.blueAccent[200],
            elevation: 0.0,
            pinned: true,
            floating: true,
            snap: false,
            leading: Icon(Icons.arrow_back_ios),
            flexibleSpace: Column(
              children: [
                FlexibleSpaceBar(
                  title: Text('Emergency Details',style: GoogleFonts.ubuntu(fontSize: 25,color: Colors.black),
                ),
                ),
                Text('You can know your emergency leave Details in this page',style: GoogleFonts.ubuntu(fontSize: 25,color: Colors.black))
              ],
            ),
            expandedHeight: 200,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("allemergencyleaves").where('emp_id',isEqualTo: user!.uid).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return SliverList(delegate: SliverChildBuilderDelegate((context, index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Card(
                      color: Colors.indigo[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Container(
                        height: 130,
                        padding: EdgeInsets.all(30.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/istockphoto-838476004-612x612.jpg'),
                          ),
                          title: Text('Date',style: GoogleFonts.ubuntu(fontSize: 25,color: Colors.black),),
                          subtitle: Text('Leave types'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  );
                },childCount: 10,
                ),
                );
              }
            },
          ),
        ],
      ),
    );
  }*/