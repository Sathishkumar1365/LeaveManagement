import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AdminAllEmergency.dart';
import 'AdminApprovedEmergency.dart';
import 'AdminPendingEmergency.dart';
import 'AdminRejectedEmergency.dart';

class ManageEmergency extends StatefulWidget {
  const ManageEmergency({Key? key}) : super(key: key);

  @override
  State<ManageEmergency> createState() => _ManageEmergencyState();
}

class _ManageEmergencyState extends State<ManageEmergency> {

  var index=0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text('Manage Emergency Leaves',style: GoogleFonts.inder(color: Colors.white),),
            bottom:TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.blueAccent,
                tabs: [
                  Tab(child: Text('All',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),
                  Tab(child: Text('Approved',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),
                  Tab(child: Text('Rejected',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),
                  Tab(child: Text('Pending',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),

                ]
            ),
          ),
          body: TabBarView(
              children: [
                AdminAllEmergency(),
                AdminApprovedEmergency(),
                AdminRejectedEmergency(),
                AdminPendingEmergency()
              ]
          )
      ),
    );
  }
}
