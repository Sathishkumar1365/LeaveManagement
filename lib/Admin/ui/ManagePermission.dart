import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AdminAllPermission.dart';
import 'AdminApprovedPermission.dart';
import 'AdminPendingPermission.dart';
import 'AdminRejectedPermission.dart';

class ManagePermission extends StatefulWidget {
  const ManagePermission({Key? key}) : super(key: key);

  @override
  State<ManagePermission> createState() => _ManagePermissionState();
}

class _ManagePermissionState extends State<ManagePermission> {
  var index=0;
  final tabbars=[AdminAllPermission(),AdminApprovedPermission(),AdminRejectedPermission(),AdminPendingPermission()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text('Manage Permission',style: GoogleFonts.inder(color: Colors.white),),
          bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(child: Text('All',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),
                Tab(child: Text('Approved',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),
                Tab(child: Text('Rejected',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),
                Tab(child: Text('Pending',style:TextStyle(color:Colors.white),textAlign: TextAlign.center,),),
              ]),
        ),
        body: TabBarView(
            children: [
              AdminAllPermission(),
              AdminApprovedPermission(),
              AdminRejectedPermission(),
              AdminPendingPermission()
            ]
        ),
      ),
    );
  }
}
