import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../EndUser/shared/leaveform.dart';
import '../../EndUser/ui/applyleave.dart';

class UserLeaveDetails extends StatefulWidget {
  final LeaveForm? leave;
  UserLeaveDetails({Key? key, this.leave}) : super(key: key);

  @override
  State<UserLeaveDetails> createState() => _UserLeaveDetailsState();
}

class _UserLeaveDetailsState extends State<UserLeaveDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        title: Text('Details',style: GoogleFonts.ubuntu(color: Colors.white,fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.leave!.emp_profile!),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Text('Name',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.leave!.name,style: GoogleFonts.roboto(color: Colors.white,),),
                SizedBox(height: 30,),
                Text('Employee ID',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.leave!.employee_id,style: GoogleFonts.roboto(color: Colors.white,),),
                SizedBox(height: 30,),
                Text('Department',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                SizedBox(height: 15,),
                Text(widget.leave!.dept,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('Mail',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                SizedBox(height: 15,),
                Text(widget.leave!.mail,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('LeaveType',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.leave!.leavetype,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('FromDate',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.leave!.fromDate,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('ToDate',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.leave!.toDate,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('Reason',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.leave!.reason,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text((DateFormat('dd/MM/yyyy hh:mm').format(widget.leave!.timestamp!.toDate())),style: GoogleFonts.roboto(color: Colors.white),),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
