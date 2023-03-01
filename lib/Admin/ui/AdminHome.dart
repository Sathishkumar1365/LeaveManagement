import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:leavemanagement/Admin/ui/permission.dart';

import '../widgets/AddEmployee.dart';
import '../widgets/AdminHomeScreen.dart';
import '../widgets/SearchEmp.dart';
//import 'package:badges/badges.dart';
import 'package:page_transition/page_transition.dart';

import 'AdminAnnouncement.dart';
import 'AdminNotifications.dart';
import 'EmergencyLeave.dart';
import 'ManageEmergency.dart';
import 'ManageEmployees.dart';
import 'ManageLeaves.dart';
import 'ManagePermission.dart';
import 'AdminLogin.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final GlobalKey<ScaffoldState>_scaffoldKey=new GlobalKey<ScaffoldState>();
  bool refresh=false;
  int currentPage=0;
  final screens=[
    AdminHomeScreen(),
    AddEmployee(),
    SearchEmp()
  ];
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
  }
  storeNoficationToken()async{
    String? token=await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('admin').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'token':token
    },SetOptions(merge: true));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event){
      print("fcm message received");
    });
    storeNoficationToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black,statusBarIconBrightness: Brightness.light,statusBarBrightness: Brightness.dark),
        backgroundColor: Colors.black,
        leading: InkWell(child: Icon(Icons.sort,size: 30,color: Colors.white,),onTap: (){_scaffoldKey.currentState!.openDrawer();},),
        

      ),
      body: IndexedStack(
        index: currentPage,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        elevation: 0,
        onTap: (index){
          setState(() {
            currentPage=index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            label: 'Home',
            icon:currentPage==0? Icon(Icons.home_sharp,color: Colors.white,size: 30,):Icon(Icons.home_sharp,color: Colors.grey.shade500,),
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
            label: 'Add Employee',
              icon: currentPage==1?Icon(Icons.group_add,color: Colors.white,size: 30,):Icon(Icons.group_add,color: Colors.grey.shade500,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.black,
            label: 'Search',
              icon: currentPage==2?Icon(Icons.search,color: Colors.white,size: 30,):Icon(Icons.search,color: Colors.grey.shade500,)
          ),

        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.green
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius:44,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: NetworkImage("https://img.freepik.com/premium-photo/young-handsome-man-with-beard-isolated-keeping-arms-crossed-frontal-position_1368-132662.jpg?w=2000"),
                      ),
                    ),
                    SizedBox(height: 11,),
                    Text('Admin',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 20),)
                  ],
                )
            ),
            ListTile(
              title: Text('Dashboard'),
              leading: Icon(
                Icons.dashboard,color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
            ListTile(
              title: Text('Manage Empolyees'),
              leading: Icon(
                Icons.group,color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageEmployees()));
              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
            ListTile(
              title: Text('Announcement'),
              leading: Icon(
                Icons.announcement_outlined,color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminAnnouncement()));
              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
            ListTile(
              title: Text('Manage Leave'),
              leading: Icon(
                Icons.manage_accounts,color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageLeave()));
              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
            ListTile(
              title: Text('Manage Permission'),
              leading: Icon(
                Icons.manage_accounts_outlined,color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagePermission()));

              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
            ListTile(
              title: Text('Manage Emergency'),
              leading: Icon(
                Icons.manage_accounts_outlined,color: Colors.black,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageEmergency()));
              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
            ListTile(
              title: Text('Permission'),
              leading: Icon(
                Icons.timer,color: Colors.black,
              ),
              /*trailing: Badge(toAnimate: true,
                badgeContent: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('permission').count().get(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white));
                      }
                      int rcount=snapshot.data!.count;
                      return Text('$rcount',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold));}),*/
                position: BadgePosition(top: 15,end: 2),

                badgeColor: Colors.red,
                shape: BadgeShape.circle,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UPermission()));

              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
            ListTile(
              title: Text('EmergencyLeave'),
              leading: Icon(
                Icons.wallet_travel_outlined,color: Colors.black,
              ),
              /*trailing: Badge(toAnimate: true,
                badgeContent: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('emergencyleave').count().get(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return Text('0',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white));
                      }
                      int rcount=snapshot.data!.count;
                      return Text('$rcount',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold));}),*/
                position: BadgePosition(top: 15,end: 2),

                badgeColor: Colors.red,
                shape: BadgeShape.circle,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UEmergency()));

              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),

            ListTile(
              title: Text('Logout'),
              leading: Icon(
                Icons.login_sharp,color: Colors.black,
              ),
              onTap: () {
                _signOut();
              },
            ),
            Divider(
              height: 0.5,thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
