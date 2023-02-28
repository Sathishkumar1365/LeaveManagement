import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leavemanagement/Admin/services/Admin_AddEmployee.dart';


import '../shared/emp_info.dart';
import '../widgets/UpdateEmpAnim.dart';

class EditEmpProfile extends StatefulWidget {
  final Employees? employees;
  const EditEmpProfile({Key? key, this.employees,}) : super(key: key);

  @override
  State<EditEmpProfile> createState() => _EditEmpProfileState();
}

class _EditEmpProfileState extends State<EditEmpProfile> {
  var namecontroller=TextEditingController();
  var deptcontroller=TextEditingController();
  var mailcontroller=TextEditingController();
  var profilecontroller=TextEditingController();
  var agecontroller=TextEditingController();
  var addresscontroller=TextEditingController();
  var gendercontroller=TextEditingController();
  var mobilecontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var cpasscontroller=TextEditingController();
  var employeeidcontroller=TextEditingController();

  bool _validateName=false;
  bool _validateId=false;
  bool _validateDept=false;
  bool _validatemail=false;
  bool _validateProfile=false;
  bool _validateAddress=false;
  bool _validateAge=false;
  bool _validateGender=false;
  bool _validateMobile=false;
  bool _validatePassword=false;
  bool _validatecpassword=false;
  bool? passwordVisibility;


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      namecontroller.value=TextEditingValue(text: widget.employees!.emp_name.toString());
      employeeidcontroller.value=TextEditingValue(text: widget.employees!.employee_id.toString());
      deptcontroller.value=TextEditingValue(text: widget.employees!.emp_dept.toString());
      mailcontroller.value=TextEditingValue(text: widget.employees!.emp_mail.toString());
      profilecontroller.value=TextEditingValue(text: widget.employees!.emp_profile.toString());
      addresscontroller.value=TextEditingValue(text: widget.employees!.emp_address.toString());
      gendercontroller.value=TextEditingValue(text: widget.employees!.emp_gender.toString());
      agecontroller.value=TextEditingValue(text: widget.employees!.emp_age.toString());
      mobilecontroller.value=TextEditingValue(text: widget.employees!.emp_mobile.toString());
      passwordcontroller.value=TextEditingValue(text: widget.employees!.emp_password.toString());
      cpasscontroller.value=TextEditingValue(text: widget.employees!.emp_cpassword.toString());
      passwordVisibility = false;

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
        title: Text('Edit Profile',style: GoogleFonts.ubuntu(color: Colors.white,fontWeight: FontWeight.bold),),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child:SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Update Employee",style: GoogleFonts.ubuntu(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Text('Name',style: GoogleFonts.roboto(color: Colors.white),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 11, 0),
                      child: TextFormField(
                        controller:namecontroller,
                        style: TextStyle(color: Colors.white),
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter Name',
                          errorText: _validateName?'Value Can\'t Be Empty':null,
                          hintStyle: TextStyle(color: Colors.white30),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          contentPadding:
                          EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          suffixIcon: Icon(
                            Icons.perm_identity,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Employee ID',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                child: TextFormField(
                  controller:employeeidcontroller,
                  style: TextStyle(color: Colors.white),
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Employee ID',
                    errorText: _validateId?'Value Can\'t Be Empty':null,
                    hintStyle: TextStyle(color: Colors.white30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    suffixIcon: Icon(
                      Icons.perm_identity,
                      color: Color(0xFF757575),
                      size: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Deparment',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                    child: TextFormField(
                      controller: deptcontroller,
                      style: TextStyle(color: Colors.white),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Enter Department',
                        errorText: _validateDept?'Value Can\'t Be Empty':null,
                        hintStyle: TextStyle(color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        suffixIcon: Icon(
                          Icons.developer_board_sharp,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                        child: Text('Email',style: GoogleFonts.roboto(color: Colors.white),),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                        child: TextFormField(
                          controller: mailcontroller,
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            errorText: _validatemail?'Value Can\'t Be Empty':null,
                            hintStyle: TextStyle(color: Colors.white30),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding:
                            EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                            suffixIcon: Icon(
                              Icons.mail_outlined,
                              color: Color(0xFF757575),
                              size: 22,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Profile',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                    child: TextFormField(
                      controller: profilecontroller,
                      style: TextStyle(color: Colors.white),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Enter Image Url',
                        errorText: _validateProfile?'Value Can\'t Be Empty':null,
                        hintStyle: TextStyle(color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        suffixIcon: Icon(
                          Icons.person_pin,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Address',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                    child: TextFormField(
                      controller: addresscontroller,
                      style: TextStyle(color: Colors.white),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Enter Address here',
                        errorText: _validateAddress?'Value Can\'t Be Empty':null,
                        hintStyle: TextStyle(color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFECF6FC),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFECF6FC),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 25, 12, 0),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Age',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                child: TextFormField(
                  controller: agecontroller,
                  style: TextStyle(color: Colors.white),
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Age',
                    errorText: _validateAge?'Value Can\'t Be Empty':null,
                    hintStyle: TextStyle(color: Colors.white30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12,15, 0, 0),
                    child: Text('Gender',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        controller: gendercontroller,
                        style: TextStyle(color: Colors.white),
                        obscureText: false,
                        decoration: InputDecoration(
                          errorText: _validateGender?'Value Can\'t Be Empty':null,
                          hintStyle: TextStyle(color: Colors.white30),
                          hintText: 'Enter Gender',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          contentPadding:
                          EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          suffixIcon: Icon(
                            Icons.phone_android,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Mobile Number',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                    child: TextFormField(
                      controller: mobilecontroller,
                      style: TextStyle(color: Colors.white),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white30),
                        hintText: 'Enter Mobile Number',
                        errorText: _validateMobile?'Value Can\'t Be Empty':null,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        suffixIcon: Icon(
                          Icons.phone_android,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Password',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                    child: TextFormField(
                      controller: passwordcontroller,
                      style: TextStyle(color: Colors.white),
                      obscureText: !passwordVisibility!,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        errorText: _validatePassword?'Value Can\'t Be Empty':null,
                        hintStyle: TextStyle(color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility!,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility!
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20)
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 15, 0, 0),
                    child: Text('Confirm Password',style: GoogleFonts.roboto(color: Colors.white),),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                    child: TextFormField(
                      controller: cpasscontroller,
                      style: TextStyle(color: Colors.white),
                      obscureText: !passwordVisibility!,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        errorText: _validatePassword?'Value Can\'t Be Empty':null,
                        hintStyle: TextStyle(color: Colors.white30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x00000000),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility!,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility!
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20)
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        onPressed: ()async{
                          setState(() {
                            namecontroller.text.isEmpty? _validateName=true:_validateName=false;
                            mailcontroller.text.isEmpty? _validatemail=true:_validatemail=false;
                            deptcontroller.text.isEmpty? _validateDept=true:_validateDept=false;
                            profilecontroller.text.isEmpty? _validateProfile=true:_validateProfile=false;
                            addresscontroller.text.isEmpty? _validateAddress=true:_validateAddress=false;
                            gendercontroller.text.isEmpty? _validateGender=true:_validateGender=false;
                            mobilecontroller.text.isEmpty? _validateMobile=true:_validateMobile=false;
                            passwordcontroller.text.isEmpty? _validatePassword=true:_validatePassword=false;
                            cpasscontroller.text.isEmpty? _validatePassword=true:_validatePassword=false;
                            employeeidcontroller.text.isEmpty?_validateId=true:_validateId=false;

                          });
                          if(_validateName==false&&_validateId==false&&_validatemail==false&&_validateDept==false&&_validateProfile==false&&_validateAddress==false&&_validateAge==false&&_validateGender==false&&_validateMobile==false&&_validatecpassword==false){
                            await AdminAddEmp().updateemp(id:widget.employees!.id,employee_id:employeeidcontroller.text,emp_name: namecontroller.text, emp_mail: mailcontroller.text, emp_address: addresscontroller.text, emp_gender: gendercontroller.text, emp_profile: profilecontroller.text, emp_mobile: mobilecontroller.text, emp_pass: passwordcontroller.text, emp_cpass: cpasscontroller.text, emp_age: agecontroller.text, emp_dept: deptcontroller.text);
                            Navigator.push(context,MaterialPageRoute(builder: (conetext)=>UpdateEmpAnim()));
                          }
                        },
                        height: 50,
                        minWidth: 250,
                        child: Text('Update',style: GoogleFonts.ubuntu(color: Colors.white),),
                        color: Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
