import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leavemanagement/EndUser/widgets/infowidget.dart';

import '../ui/ApprovedEmergencyLeaves.dart';
import '../ui/EmergencyLeaveList.dart';
import '../ui/PendingEmergencyLeaves.dart';
import '../ui/RejectedEmergencyLeaves.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Histories',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(height: 10,),
              Text('You can make a view of an your emergency leaves in this page.',maxLines: 2,style: GoogleFonts.roboto(),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('All',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 20),),
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyLeaveList()));
                      },
                      icon: Icon(Icons.arrow_circle_right_sharp,color: Colors.blue,size: 30,))
                ],
              ),
              SizedBox(height: 14,),
              infowidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyLeaveList()));
                    },
                      child: Text('Readmore...',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.blueAccent),))
                ],),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Approved',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 20),),
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ApprovedEmergencyLeaves()));
                      },
                      icon: Icon(Icons.arrow_circle_right_sharp,color: Colors.blue,size: 30,))
                ],
              ),
              SizedBox(height: 14,),
              ApprovedEmergency(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ApprovedEmergencyLeaves()));
                    },
                      child: Text('Readmore...',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.blueAccent),))
                ]
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rejected',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 20),),
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RejectedEmergencyLeaves()));
                      },
                      icon: Icon(Icons.arrow_circle_right_sharp,color: Colors.blue,size: 30,))
                ],
              ),
              SizedBox(height: 14,),
              rejectedemergency(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RejectedEmergencyLeaves()));
                      },
                      child: Text('Readmore...',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.blueAccent),))
                ],),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pending',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 20),),
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingEmergencyLeaves()));
                      },
                      icon: Icon(Icons.arrow_circle_right_sharp,color: Colors.blue,size: 30,
                  ))
                ],
              ),
              SizedBox(height: 14,),
              pendingemergency(),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingEmergencyLeaves()));
                    },
                      child: Text('Readmore...',style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.blueAccent),))
                ],),
              SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}
