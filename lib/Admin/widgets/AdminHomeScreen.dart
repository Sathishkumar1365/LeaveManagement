import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../EndUser/services/PushNotification.dart';


class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  var employeescount;
  bool refresh=false;
  List topcolors=[Colors.red,Colors.green,Colors.amber,Colors.red,Colors.green,Colors.amber,Colors.red,Colors.green,Colors.amber,Colors.red,Colors.green,Colors.amber];
  List botcolors=[Colors.red.shade300,Colors.green.shade300,Colors.amber.shade300,Colors.red.shade300,Colors.green.shade300,Colors.amber.shade300,Colors.red.shade300,Colors.green.shade300,Colors.amber.shade300,Colors.red.shade300,Colors.green.shade300,Colors.amber.shade300,];
  List titles=["Registered\nEmployees","Total Leave\n Days","Total Permission\nCount","Pending Permission","Pending Leave","Pending Emergency\nLeave","Declined Leave","Declined Permission","Declined Emergency\nLeave","Approved Leave","Approved Emergency","Approved Permission"];
  List icons=[Icons.person,Icons.add_chart,Icons.add_chart,Icons.cached,Icons.cached,Icons.cached,Icons.dangerous,Icons.dangerous,Icons.dangerous,Icons.task_alt,Icons.task_alt,Icons.task_alt];


  @override
  void initState() {
    // TODO: implement initState
    //empcount();
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event){
      PushNotification.display(event);
    });
    PushNotification.initialiseNotifications();
  }
  @override
  Widget build(BuildContext context){
    List counts=[
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('employees').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('allleaves').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('allpermissions').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('permission').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('leave').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('emergencyleave').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('rejectedleaves').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),

      FutureBuilder(
          future: FirebaseFirestore.instance.collection('rejectedpermission').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('rejectedemergencyleave').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('approvedleave').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('approvedemergencyleave').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
      FutureBuilder(
          future: FirebaseFirestore.instance.collection('approvedpermission').count().get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50,color: Colors.black));
            }
            int rcount=snapshot.data!.count;
            return Text('$rcount',style: TextStyle(fontSize: 50));}),
    ];
    return RefreshIndicator(
      onRefresh:()async{
        setState(() {
          refresh=true;
        });
        setState(() {
          refresh=false;
        });
      },
      child: SingleChildScrollView(
        child: Container(
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dashboard',style: GoogleFonts.ubuntu(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
                        SizedBox(height: 10,),
                        Text('Welcome Admin!',style: GoogleFonts.ubuntu(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)
                      ],
                    ),),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                            height:1250,
                            child:GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      crossAxisCount: 2
                                  ),
                                  itemCount: 12,
                                  itemBuilder: (context,index){
                                    return Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                topcolors[index],
                                                botcolors[index]
                                              ]
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(titles[index],style: GoogleFonts.ubuntu(color: Colors.white,fontWeight: FontWeight.bold),),
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                counts[index]??'',
                                                Icon(icons[index],color: Colors.white24,size: 80,)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                        ),
                  )
        ],
              ),
        ),
      ),
    );
  }
}

