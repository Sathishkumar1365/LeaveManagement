import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AdminAllLeaves.dart';
import 'AdminApprovedLeaves.dart';
import 'AdminPendingLeaves.dart';
import 'AdminRejectedLeaves.dart';


class ManageLeave extends StatefulWidget {
  const ManageLeave({Key? key}) : super(key: key);

  @override
  State<ManageLeave> createState() => _ManageLeaveState();
}

class _ManageLeaveState extends State<ManageLeave> {
  //final tabs=[AdminAllLeaves(),AdminApprovedLeaves(),AdminRejectedLeaves(),AdminPendingLeaves()];
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
            title: Text('Manage Leaves',style: GoogleFonts.inder(color: Colors.white),),
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
              AdminAllLeaves(),
              AdminApprovedLeaves(),
              AdminRejectedLeaves(),
              AdminPendingLeaves()
            ]
        )
      ),
    );
  }
}
