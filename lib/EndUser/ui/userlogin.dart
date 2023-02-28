import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leavemanagement/EndUser/ui/UserHome.dart';
import '../../Admin/services/Admin_AddEmployee.dart';
import '../../Admin/ui/AdminLogin.dart';


class UserLogin extends StatefulWidget {
  const UserLogin({Key? key,}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController employee_id=TextEditingController();
  TextEditingController emppass=TextEditingController();
  bool _isloading=false;

  late bool passwordVisibility;//this is for password visible unvisible

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employee_id = TextEditingController();
    emppass = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    employee_id.dispose();
    emppass.dispose();
  }

  //this is a function for user login
  void loginUser()async{
    setState(() {
      _isloading=true;
    });
    String res=await AdminAddEmp().loginUser(email: employee_id.text, password: emppass.text);
    if(res=='success'){
      _isloading?Future.delayed(Duration(seconds: 3),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserHome()));
      }):Center(child:CircularProgressIndicator());
    }
    else{
      setState(() {
        _isloading=false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter valid details')));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 430,
                child: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      height: 400,
                      width: width,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/loginback.png'),//image
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                    Positioned(
                      height: 400,
                      width: width+20,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/loginbackground.png'),//image
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),),
                    SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.grey.shade200
                                ))
                            ),
                            child:
                                //employee mail field
                            TextField(
                              controller: employee_id,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon:Icon(Icons.mail,color: Colors.grey.shade500,
                                    size: 22,),
                                  hintText: "Email ID",
                                  hintStyle: TextStyle(color: Colors.grey,)
                              ),
                            ),
                          ),
                          //employee password field
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: emppass,
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: InkWell(
                                  onTap: () => setState(
                                        () =>
                                    passwordVisibility = !passwordVisibility,
                                  ),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey.shade500,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          height: 50,
                          color: Color.fromRGBO(49, 39, 79, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          ),
                          //enduser home
                          onPressed: (){
                            loginUser();
                          },
                          child: _isloading?Center(child: CircularProgressIndicator(color: Colors.white,),):Text("Let\'s Login",style: GoogleFonts.roboto(fontWeight: FontWeight.normal,color:Colors.white),),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Center(child: TextButton(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6),fontSize: 16),
                        text: 'Go to Admin Login',
                        children:[
                          TextSpan(
                              style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                          )
                        ]
                      )),
                      //admin pannel
                      onPressed: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => AdminLogin()));
                      },)),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}