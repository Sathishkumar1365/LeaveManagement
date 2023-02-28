import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../EndUser/shared/PermissionForm.dart';

class UserPermissionDetails extends StatefulWidget {
  final PermissionForm? permissionForm;
  const UserPermissionDetails({Key? key, this.permissionForm}) : super(key: key);

  @override
  State<UserPermissionDetails> createState() => _UserPermissionDetailsState();
}

class _UserPermissionDetailsState extends State<UserPermissionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        title: Text('Permission Details',style: GoogleFonts.ubuntu(color: Colors.white,fontWeight: FontWeight.bold),),
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
                      backgroundImage: NetworkImage(widget.permissionForm!.emp_profile!),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Text('Name',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.name,style: GoogleFonts.roboto(color: Colors.white,),),
                SizedBox(height: 30,),
                Text('Employee ID',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.employee_id,style: GoogleFonts.roboto(color: Colors.white,),),
                SizedBox(height: 30,),
                Text('Department',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.dept,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('Mail',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.mail,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('Date',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.Date,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('FromTime',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.fromtime,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('ToTime',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.totime,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Text('Reason',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                SizedBox(height: 15,),
                Text(widget.permissionForm!.reason,style: GoogleFonts.roboto(color: Colors.white),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text((DateFormat('dd/MM/yyyy hh:mm').format(widget.permissionForm!.timestamp!.toDate())),style: GoogleFonts.roboto(color: Colors.white),),
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
