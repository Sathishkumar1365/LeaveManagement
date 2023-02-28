import 'package:flutter/material.dart';
import 'package:leavemanagement/Admin/ui/AdminAnnouncement.dart';
import 'package:leavemanagement/EndUser/shared/AnnouncedItems.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class AnnouncementDetails extends StatefulWidget {
  final AnnouncedItems announcedItems;

  const AnnouncementDetails({super.key, required this.announcedItems,});
  //final String tag;
  //final AnnouncedItems items;
  //@required this.items,@required this.tag

  @override
  State<AnnouncementDetails> createState() => _AnnouncementDetailsState();
}

class _AnnouncementDetailsState extends State<AnnouncementDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag:'${widget.announcedItems.announcement_title}',
                        child: Container(width:480,child: Image.network(widget.announcedItems.announcement_image,fit: BoxFit.fitWidth,))),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.announcedItems.announcement_title,style: GoogleFonts.ubuntu(fontSize: 22,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text(widget.announcedItems.description,style: GoogleFonts.roboto(fontSize: 17),)
                        ],
                      ),
                    )
                  ],
                ),

              ),
              Padding(padding: EdgeInsets.only(top: 2,left: 2),
                child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)
                ),)
            ],
          ),
        ),
      ),
    );

  }
}

