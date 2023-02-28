import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Admin/shared/emp_info.dart';
import 'EditProfile.dart';

class ViewProfile extends StatefulWidget {
  String emp_id;
  ViewProfile({Key? key,required this.emp_id}) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late bool _isloading;
  var userData={};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isloading=true;
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        _isloading=false;
      });
    });
    getData();
  }
  getData() async{
    try{
      var snap = await FirebaseFirestore.instance.collection('employees').doc(widget.emp_id).get();
      userData=snap.data()!;
      setState(() {

      });
    }catch(e){
      print("something error");
    }
  }
  bool refresh=false;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Profile',style: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Colors.white),),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){Navigator.pop(context);},),
      ),
      body:_isloading?Center(child: CircularProgressIndicator(),):
      RefreshIndicator(
        onRefresh:()async{
          setState(() {
            refresh=true;
          });
          setState(() {
            refresh=false;
          });
        },
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("employees").snapshots(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child:Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:[
                        Container(
                          height: 300,
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
                                  backgroundImage: NetworkImage(userData['photourl']),
                                ),
                              ),
                              SizedBox(height: 14,),
                              Text(userData['empname'],style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold,fontSize: 20),),
                              SizedBox(height: 10,),
                              Text(userData['employee_id'],style: GoogleFonts.ubuntu(),)

                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:10),
                          child: Container(
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 10,),
                                Flexible(child: Text(userData['empname'],style: GoogleFonts.inder(color: Colors.orange,fontSize: 14),)),
                                SizedBox(height: 25,),
                                Text('Age',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 10,),
                                Flexible(child: Text(userData['age'],style: GoogleFonts.inder(color: Colors.orange,fontSize: 14),)),
                                SizedBox(height: 25,),
                                Text('Department',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 10,),
                                Flexible(child: Text(userData['department'],style: GoogleFonts.inder(color: Colors.orange,fontSize: 14),)),
                                SizedBox(height: 25,),
                                Text('Mobile number',style: GoogleFonts.inder(fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 10,),
                                Flexible(child: Text(userData['emp_mobile'],style: GoogleFonts.inder(color: Colors.orange,fontSize: 14),)),

                              ],
                            ),
                          ),
                        ),

                      ]
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('E-mail',style: GoogleFonts.inder(fontSize: 20,fontWeight: FontWeight.bold)),
                            SizedBox(height: 14,),
                            Padding(padding: EdgeInsets.only(left: 10),child: Text(userData['emp_mail'],style: GoogleFonts.inder(fontSize: 16,color: Colors.orange),),),
                            SizedBox(height:20),
                            Text('Address',style: GoogleFonts.inder(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 14,),
                            Padding(padding: EdgeInsets.only(left: 10),child: Text(userData['address'],style: GoogleFonts.inder(fontSize: 16,color: Colors.orange),),),
                            SizedBox(height:20),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    height: height*0.05,
                                    minWidth: width*0.9,
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(employees: Employees(
                                          id: widget.emp_id,
                                          emp_name: userData['empname'],
                                          employee_id: userData['employee_id'],
                                          emp_mail: userData['emp_mail'],
                                          emp_dept: userData['department'],
                                          emp_profile: userData['photourl'],
                                          emp_age: userData['age'],
                                          emp_address: userData['address'],
                                          emp_gender: userData['gender'],
                                          emp_mobile: userData['emp_mobile'],
                                          emp_password: userData['emp_pass'],
                                          emp_cpassword: userData['emp_cpass']),)));
                                    },
                                    color: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text("Edit profile",style: TextStyle(color: Colors.white),),
                                  )
                                ],
                              ),
                            )

                          ],
                        ),
                    )
                  ],
                ),
              )
            );
          }
        ),
      )
    );
  }
}
