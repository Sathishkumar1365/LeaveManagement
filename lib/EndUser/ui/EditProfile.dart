import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../Admin/shared/emp_info.dart';
import '../widgets/UpdateAnim.dart';
import 'UserHome.dart';

class EditProfile extends StatefulWidget {
  final Employees? employees;
  const EditProfile({Key? key, this.employees}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  TextEditingController uname=TextEditingController();
  TextEditingController umail=TextEditingController();
  TextEditingController udept=TextEditingController();
  TextEditingController umobile=TextEditingController();
  TextEditingController uaddress=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController employeeid=TextEditingController();
  var userData={};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uname.value=TextEditingValue(text: widget.employees!.emp_name.toString());
    umail.value=TextEditingValue(text: widget.employees!.emp_mail.toString());
    udept.value=TextEditingValue(text: widget.employees!.emp_dept.toString());
    umobile.value=TextEditingValue(text: widget.employees!.emp_mobile.toString());
    uaddress.value=TextEditingValue(text: widget.employees!.emp_address.toString());
    age.value=TextEditingValue(text: widget.employees!.emp_age.toString());
    employeeid.value=TextEditingValue(text: widget.employees!.employee_id.toString());
    getData();
  }
  getData() async{
    try{
      var snap = await FirebaseFirestore.instance.collection('employees').doc(widget.employees!.id).get();
      userData=snap.data()!;
      setState(() {

      });
    }catch(e){
      print("something error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final User? user =  FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
          elevation: 0,
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text('Edit Profile',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){Navigator.pop(context);},),
        ),
        body:SingleChildScrollView(
            child:Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      children:[
                        Container(
                          height: 330,
                          width: 210,
                          color: Colors.pink.shade50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 46,
                                  backgroundImage: NetworkImage(widget.employees!.emp_profile),
                                ),
                              ),
                              SizedBox(height: 14,),
                              Text(widget.employees!.emp_name,style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 20),),
                              SizedBox(height: 10,),
                              Text(widget.employees!.employee_id,style: GoogleFonts.ubuntu(),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: Container(
                            height: 330,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 4,),
                                SizedBox(height: 30,width: 180,child: TextFormField(
                                  readOnly: true,
                                  controller: uname,
                                  decoration: InputDecoration(
                                    fillColor: Colors.red,
                                      enabledBorder: InputBorder.none
                                  ),
                                ),),

                                SizedBox(height: 20,),
                                Text('Email',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 4,),
                                Flexible(
                                  child: SizedBox(height: 47,width: 170,child: TextFormField(
                                    readOnly: true,
                                    controller: umail,
                                    decoration: InputDecoration(
                                        fillColor: Colors.red,
                                        enabledBorder: InputBorder.none
                                    ),
                                  ),),
                                ),
                                SizedBox(height: 20,),
                                Text('Department',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 4,),
                                SizedBox(height: 30,width: 180,child: TextFormField(
                                  readOnly: true,
                                  controller: udept,
                                  decoration: InputDecoration(
                                      fillColor: Colors.red,
                                      enabledBorder: InputBorder.none
                                  ),
                                ),),
                                SizedBox(height: 20,),
                                Text('Mobile number',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 4,),
                                SizedBox(height: 30,width: 180,child: TextFormField(
                                  controller: umobile,
                                  decoration: InputDecoration(
                                      fillColor: Colors.red,
                                      enabledBorder: InputBorder.none
                                  ),
                                ),),
                              ],
                            ),
                          ),
                        )
                      ]
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Age',style: GoogleFonts.inder(fontSize: 20,fontWeight: FontWeight.bold)),
                          SizedBox(height: 70,width: 500,child: TextFormField(
                            controller: age,
                            decoration: InputDecoration(
                                fillColor: Colors.red,
                                enabledBorder: InputBorder.none
                            ),
                          ),),
                          Text('Address',style: GoogleFonts.inder(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          SizedBox(height: 70,width: 500,child: TextFormField(

                            controller: uaddress,
                            decoration: InputDecoration(
                                fillColor: Colors.red,
                                enabledBorder: InputBorder.none
                            ),
                          ),),
                          SizedBox(height:20),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  height: height*0.05,
                                  minWidth: width*0.9,
                                  onPressed: ()async{
                                    Employees employee=Employees(id: uid, emp_name: uname.text,employee_id: userData['employee_id'], emp_mail: umail.text, emp_dept: udept.text, emp_profile: userData['photourl'], emp_age: age.text, emp_address: uaddress.text, emp_gender: userData['gender'],emp_mobile: umobile.text, emp_password: userData['emp_pass'], emp_cpassword: userData['emp_cpass'],);
                                    await _firestore.collection('employees').doc(user.uid).update(employee.toJson()).
                                    whenComplete(() =>
                                        showModalBottomSheet(
                                            isDismissible: false,
                                            enableDrag: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                  height: 400,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(height: 10,),
                                                      Lottie.network('https://assets10.lottiefiles.com/packages/lf20_mkaua5rx.json',height:200,repeat:false),
                                                      Text("Updated Successfully ",textAlign: TextAlign.center,style: GoogleFonts.kanit(fontSize: 20,color: Colors.black)),
                                                      SizedBox(height: 20,),
                                                      OutlinedButton(
                                                          style: ButtonStyle(
                                                              side:MaterialStateProperty.all(BorderSide(color: Colors.indigo))

                                                          ),
                                                          onPressed: (){
                                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserHome()), (route) => false);
                                                          },
                                                          child: Text('Back to home',style: TextStyle(color: Colors.indigo),))
                                                    ],
                                                  )
                                              );
                                            }
                                        )
                                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateAnim()))
                                    );},
                                  color: Colors.pink,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text("save",style: TextStyle(color: Colors.white),),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}