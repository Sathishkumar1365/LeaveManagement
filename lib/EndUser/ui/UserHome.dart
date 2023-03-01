import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:badges/badges.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leavemanagement/EndUser/ui/permissionNotify.dart';
import 'package:leavemanagement/EndUser/widgets/Home.dart';
import 'package:leavemanagement/EndUser/widgets/History.dart';
import 'dart:math';
import 'package:page_transition/page_transition.dart';
import 'package:leavemanagement/EndUser/ui/UserNotification.dart';
import 'package:leavemanagement/EndUser/ui/ViewProfile.dart';
import 'package:leavemanagement/EndUser/ui/Announcement.dart';
import 'package:leavemanagement/EndUser/ui/userlogin.dart';
import '../services/PushNotification.dart';
import 'emergencyNotify.dart';




class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  //this function for refresh emp each time login in diffrent user id's

  //late bool _isloading;
  var userData={};

  //this function for store generation to notification
  storeNoficationToken()async{
    String? token=await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'token':token
    },SetOptions(merge: true));
  }
  int currentpage=0;
  final pages=[
    Home(),
    History(),
  ];
  double value=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event){
      PushNotification.display(event);
    });
    storeNoficationToken();

  }

  final User? user =  FirebaseAuth.instance.currentUser;
  //this function for logout from the userpannel
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserLogin()));
  }

  @override
  Widget build(BuildContext context) {
    //Employees emp=Provider.of<UserProvider>(context).getEmp;
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context,AsyncSnapshot? snapshot) {
          DocumentSnapshot user=snapshot!.data;
          if(snapshot.hasError){
            return Center(
              child: Text('No user Records'),
            );
          }
          if(snapshot.hasData){
            return Stack(
              children: [
                // ! Here Color Of Page Drawer !
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.indigo
                  ),
                ),

                // ! simple navigation menu !
                SafeArea(
                    child: Container(
                      width: 280,
                      // color: Colors.amberAccent,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          //menu
                          DrawerHeader(
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                CircleAvatar(
                                  radius: 37,
                                  backgroundImage: NetworkImage(user['photourl']),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Text(user['empname'],style:GoogleFonts.ubuntu(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),
                                ),
                                Text(user['employee_id'],style:GoogleFonts.ubuntu(color:Colors.white))

                              ],
                            ),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHome()));
                            },
                            title: Text("Home",style:GoogleFonts.roboto(color: Colors.white)),
                            leading: Icon(Icons.home,color:Colors.white),
                          ),
                          ListTile(
                            onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfile(emp_id: FirebaseAuth.instance.currentUser!.uid,)));},
                            leading:Icon(Icons.view_carousel,color: Colors.white,),
                            title: Text('View Profile',style:GoogleFonts.roboto(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PermissionNotify()));
                            },
                            title: Text("Permission",style:GoogleFonts.roboto(color: Colors.white)),
                            leading: Icon(Icons.timer,color:Colors.white),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyNotify()));
                            },
                            title: Text("Emergency Leave",style:GoogleFonts.roboto(color: Colors.white)),
                            leading: Icon(Icons.wallet_travel_outlined,color:Colors.white),
                          ),
                          ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Announcement()));
                            },
                            title: Text("Announcement",style:GoogleFonts.roboto(color: Colors.white)),
                            leading: Icon(Icons.announcement_outlined,color:Colors.white),
                          ),
                          ListTile(
                            onTap: ()async{
                              await _signOut();
                            },
                            title: Text("Logout",style:GoogleFonts.roboto(color: Colors.white)),
                            leading: Icon(Icons.exit_to_app,color:Colors.white),
                          ),
                        ],
                      ),
                    )),

                // ! : MainScreen
                TweenAnimationBuilder(
                  // ? Here Change Animation
                    curve: Curves.easeInOut ,
                    tween: Tween<double>(begin: 0, end: value),
                    // ? and here change
                    duration: const Duration(milliseconds: 500),
                    builder: (_, double val, __) {

                      return (
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..setEntry(0, 3, 200 * val)
                              ..rotateY((pi / 6) * val),
                            child:
                            // !Scafold For MainScreen Here
                            Scaffold(
                              appBar: AppBar(
                                systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
                                elevation: 0,
                                title: Text('Home',style: GoogleFonts.roboto(color:Colors.green,fontWeight:FontWeight.bold)),
                                backgroundColor:Colors.white,
                                leading: IconButton(icon: Icon(Icons.sort,size: 30,color: Colors.black),
                                  onPressed: (){
                                    setState(() {
                                      value == 0 ? value = 1 : value = 0;
                                    });
                                  },
                                ),
                                /*actions: [
                                  Badge(
                                    toAnimate: true,
                                    position: BadgePosition(top: 18,end: 4),
                                    badgeColor: Colors.red,
                                    shape: BadgeShape.circle,
                                    child: InkWell(
                                      child: Icon(Icons.notifications,size:30,color: Colors.black,),
                                      onTap: (){
                                        Navigator.push(context, PageTransition(duration:Duration(milliseconds: 50),child: UserNotifications(), type: PageTransitionType.rightToLeft));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      width:13
                                  )
                                ],*/
                              ),
                              body: pages[currentpage],
                              bottomNavigationBar: bottomnav(context),
                            ),
                          ));
                    }),

                //! Gesture For Slide
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
  //function for bottom navigation bar
  Container bottomnav(BuildContext context){
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.green.shade800,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: (){
                setState(() {
                  currentpage=0;

                });
              },
              icon: currentpage == 0
                  ? const Icon(
                Icons.home_filled,
                color: Colors.white,
                size: 30,
              )
                  : const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 25,
              ),
          ),
          IconButton(
              onPressed: (){
                setState(() {
                  currentpage=1;
                });
              },
              icon: currentpage==1?Icon(Icons.history,color: Colors.white,size: 30,):Icon(Icons.history_outlined,color: Colors.white,size: 25,))
        ],
      ),
    );
  }
}




