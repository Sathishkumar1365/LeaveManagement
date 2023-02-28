import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:leavemanagement/Admin/shared/emp_info.dart';
import 'package:leavemanagement/Admin/shared/user_provider.dart';
import 'package:leavemanagement/EndUser/services/PushNotification.dart';
import 'package:leavemanagement/EndUser/ui/applyleave.dart';
import 'package:page_transition/page_transition.dart';
import 'package:leavemanagement/EndUser/ui/applypermission.dart';
import 'package:leavemanagement/EndUser/ui/Emergencyleave.dart';
import 'package:provider/provider.dart';
import '../../Admin/shared/admin_info.dart';
import '../ui/AllLeaves.dart';
import '../ui/AllPermissions.dart';
import '../ui/ApprovedLeaves.dart';
import '../ui/ApprovedPermission.dart';
import '../ui/PendingLeaves.dart';
import '../ui/PendingPermission.dart';
import '../ui/RejectedLeaves.dart';
import '../ui/RejectedPermission.dart';
import 'Indicator.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex=0;
  addData()async{
    UserProvider _userprovider=Provider.of(context,listen: false);
    await _userprovider.refreshEmp();
  }
  String star='*';
  bool refresh=false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;

   List counts=[
     FutureBuilder(
         future: FirebaseFirestore.instance.collection('approvedleave').where('emp_id',isEqualTo: user!.uid).count().get(),
         builder: (context,snapshot){
           if(!snapshot.hasData){
             return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
           }
           int rcount=snapshot.data!.count;
           return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
     FutureBuilder(
         future: FirebaseFirestore.instance.collection('rejectedleaves').where('emp_id',isEqualTo: user.uid).count().get(),
         builder: (context,snapshot){
           if(!snapshot.hasData){
             return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
           }
           int rcount=snapshot.data!.count;
           return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
     FutureBuilder(
         future: FirebaseFirestore.instance.collection('leave').where('emp_id',isEqualTo: user.uid).count().get(),
         builder: (context,snapshot){
           if(!snapshot.hasData){
             return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
           }
           int rcount=snapshot.data!.count;
           return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
     FutureBuilder(
         future: FirebaseFirestore.instance.collection('approvedpermission').where('emp_id',isEqualTo: user.uid).count().get(),
         builder: (context,snapshot){
           if(!snapshot.hasData){
             return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
           }
           int rcount=snapshot.data!.count;
           return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
     FutureBuilder(
         future: FirebaseFirestore.instance.collection('rejectedpermission').where('emp_id',isEqualTo: user.uid).count().get(),
         builder: (context,snapshot){
           if(!snapshot.hasData){
             return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
           }
           int rcount=snapshot.data!.count;
           return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
     FutureBuilder(
         future: FirebaseFirestore.instance.collection('permission').where('emp_id',isEqualTo: user.uid).count().get(),
         builder: (context,snapshot){
           if(!snapshot.hasData){
             return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
           }
           int rcount=snapshot.data!.count;
           return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
   ];
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh:()async{
          setState(() {
            refresh=true;
          });
          setState(() {
            refresh=false;
          });
        },
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context,AsyncSnapshot? snapshot) {
            DocumentSnapshot userData=snapshot!.data;
            if(snapshot.hasError){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width,
                      color:Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child: RichText(
                            text: TextSpan(
                                text: 'Welcome ',
                                style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 25,color:Colors.black),
                                children: [
                                  TextSpan(
                                    text: userData['empname'],
                                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 25,color:Colors.black),
                                  )
                                ]
                            )),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Latest Announcements *",style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.red.shade500,fontSize: 18),),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("announcement").limit(4).orderBy("timestamp", descending: true).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 16),
                            height: 200,
                            child: PageView.builder(
                                onPageChanged: (index){
                                  setState(() {
                                    _selectedIndex=index;
                                  });
                                },
                                controller: PageController(),
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder:(context,index){
                                  DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                                  var _scale=_selectedIndex==index?1.0:0.8;
                                  return TweenAnimationBuilder(
                                    duration: Duration(milliseconds: 350),
                                    tween: Tween(begin: _scale,end: _scale),
                                    curve: Curves.ease,
                                    builder: (context,value,child){
                                      return Transform.scale(scale: value,child: child,);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              tileMode: TileMode.clamp,
                                              colors: [
                                                Colors.purple.shade400,
                                                Colors.purple.shade700

                                              ]
                                          )
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        width:230,
                                                          child: Text(documentSnapshot["title"],style: GoogleFonts.inder(color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 18),)),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(3),
                                                        decoration:BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                            color: Colors.black26
                                                        ),
                                                        child: Text((DateFormat('dd-MM-yyyy hh:mm').format((documentSnapshot["timestamp"] as Timestamp).toDate())),style: GoogleFonts.inder(color: Colors.white,fontSize: 10)))
                                                  ],
                                                ),
                                                SizedBox(height: 15,),
                                                Flexible(child: Text(documentSnapshot["description"],textScaleFactor:1.0,textAlign:TextAlign.start,style: GoogleFonts.roboto(color: Colors.white),))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );

                                }),
                          );
                        }
                        return Container(
                          height: 150,
                            child: Center(
                                child: CircularProgressIndicator())
                        );
                      }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(4, (index) => Indicator(
                          isActive: _selectedIndex==index?true:false,
                        ))
                      ],
                    ),

                    Container(
                      width:MediaQuery.of(context).size.width,
                      color:Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text('Leave Counts $star',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.brown),),
                      ),
                    ),
                    Container(
                        height: 170,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                                children: [
                                  Container(
                                    height: 110,
                                    width:199,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                              child: FutureBuilder(
                                                  future: FirebaseFirestore.instance.collection('allleaves').where('emp_id',isEqualTo: user.uid).count().get(),
                                                  builder: (context,snapshot){
                                                    if(!snapshot.hasData){
                                                      return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
                                                    }
                                                    int rcount=snapshot.data!.count;
                                                    return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('All leaves',style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AllLeaves()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 110,
                                    width:199,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                                child: counts[0]
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Approved leaves',style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ApprovedLeaves()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 110,
                                    width:199,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                              child: counts[1],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Rejected leaves',style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RejectedLeaves()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 110,
                                    width:199,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                                child: counts[2]
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Pending leaves',style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap:(){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingLeaves()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                ]
                            ),
                          ),
                        )
                    ),
                    Container(
                      width:MediaQuery.of(context).size.width,
                      color:Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text('Permission Hours $star',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.brown),),
                      ),
                    ),
                    Container(
                        height: 170,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                                children: [
                                  Container(
                                    height: 110,
                                    width:250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                              child:  FutureBuilder(
                                                  future: FirebaseFirestore.instance.collection('allpermissions').where('emp_id',isEqualTo: user.uid).count().get(),
                                                  builder: (context,snapshot){
                                                    if(!snapshot.hasData){
                                                      return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));
                                                    }
                                                    int rcount=snapshot.data!.count;
                                                    return Text('$rcount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black));}),
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('All Permission',style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AllPermission()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 110,
                                    width:250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                                child: counts[3]
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Approved permission',style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ApprovedPermission()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 110,
                                    width:250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                                child:counts[4]
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Rejected permission',style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RejectedPermission()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    height: 110,
                                    width:250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 24,
                                            backgroundColor: Colors.white,
                                            child: Center(
                                                child: counts[5]
                                            ),
                                          ),

                                        ),
                                        SizedBox(width: 12,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Pending permission',style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(height: 2,),
                                            Text('Previous days',style: TextStyle(color: Colors.grey.shade400,fontSize: 13),),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingPermission()));
                                                },
                                                child: Text('View Details',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),))

                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                ]
                            ),
                          ),
                        )
                    ),
                    Container(
                      height: 450,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child:Column(
                        crossAxisAlignment:CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  PageTransition(
                                    duration:Duration(seconds: 1),
                                    child: Leave(
                                      employees: Employees(
                                          id: FirebaseAuth.instance.currentUser!.uid,
                                          emp_name: userData['empname'],
                                          employee_id: userData['employee_id'],
                                          emp_mail: userData['emp_mail'],
                                          emp_dept:userData['department'],
                                          emp_profile: userData['photourl'],
                                          emp_age: userData['age'],
                                          emp_address: userData['address'],
                                          emp_gender:userData['gender'],
                                          emp_mobile: userData['emp_mobile'],
                                          emp_password: userData['emp_pass'],
                                          emp_cpassword: userData['emp_cpass']),
                                    ),
                                    type: PageTransitionType.rightToLeft,));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.14,
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.red.shade600,
                                        Colors.red.shade300
                                      ])
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 13, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Apply for Leave',style: GoogleFonts.ubuntu(color: Colors.white,fontSize: 18,fontWeight:FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Row(
                                        mainAxisAlignment:MainAxisAlignment.end,
                                        children:[
                                          Icon(Icons.article_outlined,color: Colors.white24,size: 44,),
                                          SizedBox(width: 30,)
                                        ]
                                    ),
                                    Row(
                                      children: [
                                        Text('Go for apply leave',style: GoogleFonts.ubuntu(color: Colors.white),),
                                        SizedBox(width: 10,),
                                        Icon(Icons.arrow_circle_right_rounded,size:20,color: Colors.white,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(duration:Duration(seconds: 1),child: Permission(
                                  employees:Employees(
                                      id: FirebaseAuth.instance.currentUser!.uid,
                                      emp_name: userData['empname'],
                                      employee_id: userData['employee_id'],
                                      emp_mail: userData['emp_mail'],
                                      emp_dept:userData['department'],
                                      emp_profile: userData['photourl'],
                                      emp_age: userData['age'],
                                      emp_address: userData['address'],
                                      emp_gender:userData['gender'],
                                      emp_mobile: userData['emp_mobile'],
                                      emp_password: userData['emp_pass'],
                                      emp_cpassword: userData['emp_cpass'])), type: PageTransitionType.rightToLeft));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.14,
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.deepPurple.shade600,
                                        Colors.deepPurple.shade300
                                      ])
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Apply for Permission',style: GoogleFonts.ubuntu(color: Colors.white,fontSize: 18,fontWeight:FontWeight.bold),),
                                    Row(
                                        mainAxisAlignment:MainAxisAlignment.end,
                                        children:[
                                          Icon(Icons.alarm_outlined,color: Colors.white24,size: 44,),
                                          SizedBox(width: 30,)
                                        ]
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text('Go for apply permission',style: GoogleFonts.ubuntu(color: Colors.white),),
                                        SizedBox(width: 10,),
                                        Icon(Icons.arrow_circle_right_rounded,size:20,color: Colors.white,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, PageTransition(duration:Duration(seconds: 1),child: Emergency(
                                employees: Employees(
                                    id: FirebaseAuth.instance.currentUser!.uid,
                                    emp_name: userData['empname'],
                                    employee_id: userData['employee_id'],
                                    emp_mail: userData['emp_mail'],
                                    emp_dept:userData['department'],
                                    emp_profile: userData['photourl'],
                                    emp_age: userData['age'],
                                    emp_address: userData['address'],
                                    emp_gender:userData['gender'],
                                    emp_mobile: userData['emp_mobile'],
                                    emp_password: userData['emp_pass'],
                                    emp_cpassword: userData['emp_cpass']),), type: PageTransitionType.rightToLeft));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.14,
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.amber.shade600,
                                        Colors.amber.shade300
                                      ])
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Apply Emergency Leave',style: GoogleFonts.ubuntu(color: Colors.white,fontSize: 18,fontWeight:FontWeight.bold),),
                                    Row(
                                        mainAxisAlignment:MainAxisAlignment.end,
                                        children:[
                                          Icon(Icons.wallet_travel_outlined,color: Colors.white24,size: 44,),
                                          SizedBox(width: 30,)
                                        ]
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text('Go for apply EmergencyLeave',style: GoogleFonts.ubuntu(color: Colors.white),),
                                        SizedBox(width: 10,),
                                        Icon(Icons.arrow_circle_right_rounded,size:20,color: Colors.white,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ),
                    SizedBox(height: 10,),
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Text('Last 10 Updates',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 20))
                        ],
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("previous").where('emp_id',isEqualTo: user.uid).limit(10).orderBy("timestamp", descending: true).snapshots(),
                        builder: (context,snapshot){
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
                                    bool documentSnapshot1=snapshot.data!.docs[index].data().containsKey("fromDate");
                                    bool documentSnapshot2=snapshot.data!.docs[index].data().containsKey("toDate");
                                    bool documentSnapshot3=snapshot.data!.docs[index].data().containsKey("leavetype");
                                    return Container(
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
                                                      Text(documentSnapshot1?"From Date"+documentSnapshot["fromDate"]:"From Time"+documentSnapshot["fromtime"],style: GoogleFonts.ubuntu(color: Colors.black),),
                                                      SizedBox(height: 10,),
                                                      Text(documentSnapshot2?"To Date:"+documentSnapshot["toDate"]:"To Time:"+documentSnapshot["toTime"],style: GoogleFonts.ubuntu(color: Colors.black),),
                                                      SizedBox(height: 10,),
                                                      Text(documentSnapshot3?documentSnapshot["leavetype"]:documentSnapshot["date"],style: GoogleFonts.ubuntu(color: Colors.purple),),
                                                      SizedBox(height: 10,),
                                                    ],
                                                  )//
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text('Applied Date:',style: GoogleFonts.ubuntu(color: Colors.indigo)),
                                                  Text((DateFormat('dd-MM-yyyy  hh:mm').format((documentSnapshot["timestamp"] as Timestamp).toDate())),style: GoogleFonts.ubuntu(color: Colors.black,fontSize: 12)),
                                                  Padding(
                                                    padding: EdgeInsets.only(top:26),
                                                    child: Container(
                                                        padding: EdgeInsets.all(10),
                                                        decoration:BoxDecoration(
                                                            border: Border.all(color: Colors.blueAccent),
                                                            borderRadius: BorderRadius.circular(5)
                                                        ),
                                                        child: Center(
                                                            child: Text(documentSnapshot["status"],style: GoogleFonts.ubuntu(color: documentSnapshot["status"] == "Approved" ? Colors.green : Colors.red)))),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            );
                          }
                          return Center(child: Text('No records'),);
                        }),
                  ],
                ),
              );
            }
            return Center(
              child:CircularProgressIndicator()
            );
          }
        ),
      ),
    );

  }
}
