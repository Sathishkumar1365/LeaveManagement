import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/leaveform.dart';

class PendingLeaveDetails extends StatefulWidget {
  final LeaveForm? leave;
  PendingLeaveDetails({Key? key, this.leave}) : super(key: key);

  @override
  State<PendingLeaveDetails> createState() => _PendingLeaveDetailsState();
}

class _PendingLeaveDetailsState extends State<PendingLeaveDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading:  InkWell(
          onTap:(){
            Navigator.pop(context);
          },
          child:Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        title: Text('Details',style: GoogleFonts.ubuntu(color: Colors.black,fontWeight:FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle:SystemUiOverlayStyle(statusBarColor:Colors.white,
            statusBarIconBrightness:Brightness.dark,
            statusBarBrightness:Brightness.light),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.leave!.emp_profile!),
            ),
            Text(widget.leave!.name,style: GoogleFonts.ubuntu(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Emp ID:',
                        style: GoogleFonts.ubuntu(color: Colors.black),
                        children: [
                          TextSpan(
                              text:widget.leave!.employee_id,
                              style: GoogleFonts.ubuntu(color:Colors.black)
                          )
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: 5,),
            Text(widget.leave!.dept,style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.grey),
            ),
            SizedBox(height: 10,),
            Container(
                width: 100,
                padding: EdgeInsets.all(10),
                decoration:BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                    child: Text('Pending',style: GoogleFonts.ubuntu(color: Colors.brown)))),
            SizedBox(height: 20,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height:MediaQuery.of(context).size.height*0.08,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300, //New
                      blurRadius: 14.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('From Date',style: GoogleFonts.poppins(color: Colors.black,
                              fontWeight: FontWeight.bold,fontSize: 15),),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(widget.leave!.fromDate,style: GoogleFonts.poppins(
                              fontSize: 12,color: Colors.black,
                            ),),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height:MediaQuery.of(context).size.height*0.08,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, //New
                    blurRadius: 14.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('To Date',style: GoogleFonts.poppins(color: Colors.black,
                            fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(widget.leave!.toDate,style: GoogleFonts.poppins(
                            fontSize: 12,color: Colors.black,
                          ),),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height:MediaQuery.of(context).size.height*0.08,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, //New
                    blurRadius: 14.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Leave types',style: GoogleFonts.poppins(color: Colors.black,
                            fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(widget.leave!.leavetype,style: GoogleFonts.poppins(
                            fontSize: 12,color: Colors.black,
                          ),),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height:MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, //New
                    blurRadius: 14.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Reason',style: GoogleFonts.poppins(color: Colors.black,
                            fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(widget.leave!.reason,style: GoogleFonts.poppins(
                              fontSize: 12,color: Colors.black,
                            ),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
