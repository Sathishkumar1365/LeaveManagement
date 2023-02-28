
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../services/Admin_AddEmployee.dart';
import '../ui/AdminHome.dart';
import '../utils/PickImage.dart';
import 'AddUserAnim.dart';

class AddEmployee extends StatefulWidget {

  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController name=TextEditingController();
  TextEditingController employeeid=TextEditingController();
  TextEditingController department=TextEditingController();
  TextEditingController email=TextEditingController();
  Uint8List? profile_image;
  TextEditingController address=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController mobile=TextEditingController();
  TextEditingController gender=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmpassword=TextEditingController();
  bool _isloading=false;
  bool _validateName=false;
  bool _validateId=false;
  bool _validateDept=false;
  bool _validatemail=false;
  bool _validateAddress=false;
  bool _validateAge=false;
  bool _validateGender=false;
  bool _validateMobile=false;
  bool _validatePassword=false;
  bool _validateCpassword=false;
  late bool passwordVisibility;
  final _unfocusNode = FocusNode();
  void selectImage() async{
    Uint8List im=await pickImage(ImageSource.gallery);
    setState(() {
      profile_image=im;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisibility = false;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    employeeid.dispose();
    department.dispose();
    email.dispose();
    address.dispose();
    age.dispose();
    mobile.dispose();
    gender.dispose();
    password.dispose();
    confirmpassword.dispose();
    _unfocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text("Add Employee",style: GoogleFonts.ubuntu(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text('Name',style: GoogleFonts.roboto(color: Colors.white),),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 11, 0),
                    child: TextFormField(
                      controller:name,
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
                controller:employeeid,
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
                  child: Text('Department',style: GoogleFonts.roboto(color: Colors.white),),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 11, 0),
                  child: TextFormField(
                    controller: department,
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
                        controller: email,
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
                    controller: address,
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
                  padding: EdgeInsetsDirectional.fromSTEB(12,15, 0, 0),
                  child: Text('Gender',style: GoogleFonts.roboto(color: Colors.white),),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                  child: TextFormField(
                    controller: gender,
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
                        Icons.male,
                        color: Color(0xFF757575),
                        size: 22,
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
                  padding: EdgeInsetsDirectional.fromSTEB(12,15, 0, 0),
                  child: Text('Age',style: GoogleFonts.roboto(color: Colors.white),),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                  child: TextFormField(
                    controller: age,
                    style: TextStyle(color: Colors.white),
                    obscureText: false,
                    decoration: InputDecoration(
                      errorText: _validateGender?'Value Can\'t Be Empty':null,
                      hintStyle: TextStyle(color: Colors.white30),
                      hintText: 'Enter Age',
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
                        Icons.male,
                        color: Color(0xFF757575),
                        size: 22,
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
                    controller: mobile,
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
                    controller: password,
                    style: TextStyle(color: Colors.white),
                    obscureText: !passwordVisibility,
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
                      suffixIcon: InkWell(
                        onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
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
                    controller: confirmpassword,
                    style: TextStyle(color: Colors.white),
                    obscureText: !passwordVisibility,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      errorText: _validateCpassword?'Value Can\'t Be Empty':null,
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
                      suffixIcon: InkWell(
                        onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
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
                      child: Text('Profile',style: GoogleFonts.roboto(color: Colors.white),),
                    ),
                  ],
                ),
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        profile_image!=null?CircleAvatar(
                            radius: 54,
                            backgroundImage: MemoryImage(profile_image!)
                        ):CircleAvatar(radius: 54,backgroundImage:AssetImage('assets/prflebg.jpg'),),
                        Positioned(
                            bottom: -10,
                            left: 70,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: Icon(Icons.add_a_photo,),
                            ))
                      ],
                    ),
                  ],
                ),
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
                          name.text.isEmpty? _validateName=true:_validateName=false;
                          employeeid.text.isEmpty?_validateId=true:_validateId=false;
                          email.text.isEmpty? _validatemail=true:_validatemail=false;
                          department.text.isEmpty? _validateDept=true:_validateDept=false;
                          address.text.isEmpty? _validateAddress=true:_validateAddress=false;
                          age.text.isEmpty?_validateAge=true:_validateAge=false;
                          gender.text.isEmpty? _validateGender=true:_validateGender=false;
                          mobile.text.isEmpty? _validateMobile=true:_validateMobile=false;
                          password.text.isEmpty? _validatePassword=true:_validatePassword=false;
                          confirmpassword.text.isEmpty? _validateCpassword=true:_validateCpassword=false;
                        });
                        if(_validateName==false&&_validateId==false&&_validatemail==false&&_validateDept==false&&_validateAddress==false&&_validateAge==false&&_validateGender==false&&_validateMobile==false&&_validatePassword==false&&_validateCpassword==false){
                          setState(() {
                            _isloading=true;
                          });
                          String? res=await AdminAddEmp().AddUser(emp_name: name.text,employee_id:employeeid.text,emp_dept: department.text, emp_mail: email.text, emp_address: address.text, emp_gender: gender.text, emp_age: age.text, emp_mobile:mobile.text, emp_password: password.text, emp_cpass: confirmpassword.text, emp_profile: profile_image!);
                          if(res != null){
                            _isloading?Future.delayed(Duration(seconds: 3),(){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddUserAnim()));
                            }):Center(child: CircularProgressIndicator(),);
                          }else{
                            setState(() {
                              _isloading=false;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some Fields Are Incorrect')));
                            });
                          }
                        }
                      },
                      height: 50,
                      minWidth: 250,
                      child:_isloading?Center(child: CircularProgressIndicator(color: Colors.white,),): Text('Add',style: GoogleFonts.ubuntu(color: Colors.white),),
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

        );
  }



}
