import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/emp_info.dart';
import 'editprofile.dart';
import 'ManageEmployees.dart';

class EmpProfile extends StatefulWidget {
  final Employees? employees;
  const EmpProfile({Key? key, this.employees,}) : super(key: key);

  @override
  State<EmpProfile> createState() => _EmpProfileState();
}

class _EmpProfileState extends State<EmpProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: Text('Details',style: GoogleFonts.ubuntu(color: Colors.white,fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 52,
                          backgroundImage: NetworkImage(widget.employees!.emp_profile),
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    Text('Name',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.emp_name,style: GoogleFonts.roboto(color: Colors.white,),),
                    SizedBox(height: 30,),
                    Text('Employee ID',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.employee_id,style: GoogleFonts.roboto(color: Colors.white,),),
                    SizedBox(height: 30,),
                    Text('Department',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.emp_dept,style: GoogleFonts.roboto(color: Colors.white),),
                    SizedBox(height: 30,),
                    Text('Mail',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.emp_mail,style: GoogleFonts.roboto(color: Colors.white),),
                    SizedBox(height: 30,),
                    Text('Address',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize:18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.emp_address,style: GoogleFonts.roboto(color: Colors.white),),
                    SizedBox(height: 30,),
                    Text('Gender',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.emp_gender,style: GoogleFonts.roboto(color: Colors.white),),
                    SizedBox(height: 30,),
                    Text('Mobile',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.emp_mobile,style: GoogleFonts.roboto(color: Colors.white),),
                    SizedBox(height: 30,),
                    Text('Password',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18),),
                    SizedBox(height: 15,),
                    Text(widget.employees!.emp_password,style: GoogleFonts.roboto(color: Colors.white),),
                    SizedBox(height: 30,),


                  ],
                ),
              ),
            ),
      )
    );
  }
}
