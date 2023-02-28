import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EmergencyNotify extends StatefulWidget {
  const EmergencyNotify({Key? key}) : super(key: key);

  @override
  State<EmergencyNotify> createState() => _EmergencyNotifyState();
}

class _EmergencyNotifyState extends State<EmergencyNotify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    return Scaffold(
        appBar:AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
            elevation: 0,
            backgroundColor: Colors.green,
            leading:InkWell(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back,color: Colors.white,)),
            title:Text('Emergency',style: GoogleFonts.roboto(color: Colors.white),)
        ),
        body:StreamBuilder(
            stream: FirebaseFirestore.instance.collection('allemergencyleaves').where('emp_id',isEqualTo: user!.uid).orderBy("timestamp", descending: true).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context,index){
                      DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(backgroundImage:NetworkImage(documentSnapshot["emp_profile"]),radius: 25,),
                            title: RichText(
                                text: TextSpan(
                                    text: "Your Application was ",
                                    style: GoogleFonts.roboto(color: Colors.black,fontSize: 17),
                                    children: [
                                      TextSpan(
                                          text: documentSnapshot["status"],
                                          style: GoogleFonts.roboto(color: Colors.black,fontSize: 17)
                                      )
                                    ]
                                )
                            ),
                            subtitle:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 6,),
                                Text(documentSnapshot["leavetype"],style: GoogleFonts.roboto(color: Colors.black,fontSize: 13)),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text((DateFormat('dd/MM/yyyy hh:mm').format((documentSnapshot["timestamp"]as Timestamp).toDate())),style: GoogleFonts.roboto(color: Colors.black,fontSize: 12))
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.shade400,)
                        ],
                      );
                    });
              }
              return Center(child: CircularProgressIndicator(),);
            })
    );
  }
}
