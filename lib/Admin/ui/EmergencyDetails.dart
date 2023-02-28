
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../EndUser/shared/Emergencyform.dart';
import 'package:intl/intl.dart';

class EmergencyDetails extends StatefulWidget {
  final EmergencyForm emergencyForm;
  const EmergencyDetails({Key? key, required this.emergencyForm}) : super(key: key);

  @override
  State<EmergencyDetails> createState() => _EmergencyDetailsState();
}

class _EmergencyDetailsState extends State<EmergencyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
          onTap:(){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
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
                      backgroundImage: NetworkImage(widget.emergencyForm.emp_profile!),
                    )
                  ],
                ),
                SizedBox(height: 30,),

                Text('Name',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.emergencyForm.name,style: GoogleFonts.roboto(color: Colors.white,),),
                SizedBox(height: 30,),
                Text('Employee ID',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.emergencyForm.employee_id,style: GoogleFonts.roboto(color: Colors.white,),),
                SizedBox(height: 30,),
                Text('Department',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                SizedBox(height: 15,),
                Text(widget.emergencyForm.dept,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('Mail',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                SizedBox(height: 15,),
                Text(widget.emergencyForm.mail,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('LeaveType',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.emergencyForm.leavetype,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('fromDate',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text((DateFormat('dd-MM-yyyy').format(widget.emergencyForm.fromDate)),style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('ToDate',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text((DateFormat('dd-MM-yyyy').format(widget.emergencyForm.toDate)),style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('Reason',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.emergencyForm.reason,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text((DateFormat('dd/MM/yyyy hh:mm').format(widget.emergencyForm.timestamp!.toDate())),style: GoogleFonts.roboto(color: Colors.white),),
                  ],
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
