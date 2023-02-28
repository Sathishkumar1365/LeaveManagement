import 'package:flutter/material.dart';
import 'AdminHome.dart';
import 'package:leavemanagement/Admin/services/Admin_AddEmployee.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController adminname=TextEditingController();
  TextEditingController adminpass=TextEditingController();
  bool _isloading=false;
  late bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    TextEditingController adminname=TextEditingController();
    TextEditingController adminpass=TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    adminname.dispose();
    adminpass.dispose();
    super.dispose();
  }
  void loginAdmin()async{
    setState(() {
      _isloading=true;
    });
    String res=await AdminAddEmp().loginAdmin(admin_mail: adminname.text, admin_pass:adminpass.text);
    if(res=="success"){
      _isloading?Future.delayed(Duration(seconds: 3),()
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      }):Center(child:CircularProgressIndicator());
    }else{
      setState(() {
        _isloading=false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter valid details')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 400.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(70),
                      child: Image.asset(
                            'assets/adminlog.png',
                            width: double.infinity,
                            height: 400.3,
                            fit: BoxFit.cover,
                        ),
                    ),
                    SafeArea(
                      child:Padding(
                        padding:EdgeInsets.all(10),
                        child:IconButton(
                            onPressed:(){
                              Navigator.pop(context);
                            },
                            icon:Icon(Icons.arrow_back_ios_new,size: 20,))
                      )
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 495.1,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffDDDDDD),
                            blurRadius: 6,
                            spreadRadius: 2,
                            offset: Offset(0, 0)
                          )
                        ],
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),

                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 26, 0, 0),
                              child: Text(
                                'Admin Login',
                                style:
                                TextStyle(
                                  fontSize: 29,fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(28, 45, 0, 0),
                                  child: Text(
                                    'Admin Mail',
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(22, 12, 22, 0),
                              child: TextFormField(
                                controller: adminname,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter AdminMail',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFD4E157),
                                ),
                                style:
                                TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(28, 10, 0, 0),
                                  child: Text(
                                    'Password',
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(22, 14, 22, 0),
                              child: TextFormField(
                                controller: adminpass,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFD4E157),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                          () =>
                                      passwordVisibility = !passwordVisibility,
                                    ),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF29B6F6),
                                      size: 22,
                                    ),
                                  ),
                                ),
                                style:
                                TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                           SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: 360,height: 47,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    loginAdmin();
                                  },
                                  color: Colors.black45,elevation: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: _isloading?Center(child: CircularProgressIndicator(color: Colors.white,),):Text('Login',style: TextStyle(color: Colors.white,fontSize: 18),)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
