import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leavemanagement/EndUser/shared/AnnouncedItems.dart';

import 'package:leavemanagement/EndUser/widgets/announcementwidget.dart';
import 'package:leavemanagement/EndUser/ui/AnnouncementDetails.dart';

import '../../Admin/ui/AdminAnnouncement.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> with SingleTickerProviderStateMixin{



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black,statusBarIconBrightness: Brightness.light,statusBarBrightness: Brightness.light),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Announcement',style: GoogleFonts.ubuntu(color: Colors.black),),
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        ),
        leadingWidth: 37,

      ),
      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection("announcement").orderBy("timestamp", descending: true).snapshots() ,
          builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount:snapshot.data?.docs.length,
                itemBuilder: (context,index){
                  DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>AnnouncementDetails(announcedItems: AnnouncedItems(documentSnapshot.id, documentSnapshot["title"], documentSnapshot["description"],documentSnapshot["timestamp"],documentSnapshot["announcement_image"]),)
                      ));
                    },
                    child: AnnouncementWidget(documentSnapshot.id,documentSnapshot["title"], documentSnapshot["description"],documentSnapshot["announcement_image"])
                  );
                },
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
          })

    );
  }
}
