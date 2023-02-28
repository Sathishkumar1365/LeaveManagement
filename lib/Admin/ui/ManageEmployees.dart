import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../services/Admin_AddEmployee.dart';
import '../shared/emp_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/DeleteEmpAnim.dart';
import 'editprofile.dart';
import 'empprofile.dart';

class ManageEmployees extends StatefulWidget {
  const ManageEmployees({Key? key}) : super(key: key);

  @override
  State<ManageEmployees> createState() => _ManageEmployeesState();
}

class _ManageEmployeesState extends State<ManageEmployees> {
  final Stream<QuerySnapshot> collectionReference = AdminAddEmp.reademployee();
  late AdminAddEmp db;
  initialize(){
    db=AdminAddEmp();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _deleteformdialog() {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text('Are you sure to Delete'),
            actions: [
              TextButton(
                  onPressed: () {

                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted successfully')));
                  },
                  style: ButtonStyle(),
                  child: Text('Delete', style: TextStyle(color: Colors.red),)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close', style: TextStyle(color: Colors.blueAccent),))
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text('Manage Employees', style: GoogleFonts.inder(),),


        ),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("employees").snapshots(),
            builder: (BuildContext context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Card(
                          color: Colors.black26,
                          child: ListTile(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EmpProfile(employees:
                              Employees(
                                  id: documentSnapshot.id,
                                  emp_name: documentSnapshot["empname"],
                                  employee_id: documentSnapshot["employee_id"],
                                  emp_mail: documentSnapshot["emp_mail"],
                                  emp_dept: documentSnapshot["department"],
                                  emp_profile: documentSnapshot["photourl"],
                                  emp_age: documentSnapshot["age"],
                                  emp_address:documentSnapshot["address"] ,
                                  emp_gender: documentSnapshot["gender"],
                                  emp_mobile: documentSnapshot["emp_mobile"],
                                  emp_password: documentSnapshot["emp_pass"],
                                  emp_cpassword: documentSnapshot["emp_cpass"]),)));
                            },
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(documentSnapshot["photourl"]),
                            ),
                            title: Text(documentSnapshot["empname"],style: GoogleFonts.roboto(color: Colors.white),),
                            subtitle: Text(documentSnapshot["department"],style: GoogleFonts.roboto(color: Colors.white)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    child: Icon(Icons.edit_calendar,color: Colors.white,),
                                    onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context)=>EditEmpProfile(employees:Employees(
                                                  id: documentSnapshot.id,
                                                  emp_name: documentSnapshot["empname"],
                                                  employee_id: documentSnapshot["employee_id"],
                                                  emp_mail: documentSnapshot["emp_mail"],
                                                  emp_dept: documentSnapshot["department"],
                                                  emp_profile:documentSnapshot["photourl"] ,
                                                  emp_age: documentSnapshot["age"],
                                                  emp_address: documentSnapshot["address"],
                                                  emp_gender: documentSnapshot["gender"],
                                                  emp_mobile: documentSnapshot["emp_mobile"],
                                                  emp_password: documentSnapshot["emp_pass"],
                                                  emp_cpassword: documentSnapshot["emp_cpass"]))));
                                    }
                                ),
                                SizedBox(width: 10,),
                                IconButton(
                                    onPressed: (){
                                      showDialog(
                                          context: context,
                                          builder: (param) {
                                            return AlertDialog(
                                              title: Text('Are you sure to Delete'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance.collection("employees").doc(documentSnapshot.id).delete();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteEmpAnim()));
                                                    },
                                                    style: ButtonStyle(),
                                                    child: Text('Delete', style: TextStyle(color: Colors.red),)),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Close', style: TextStyle(color: Colors.blueAccent),))
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.delete,color: Colors.red,))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }

              );
            }
            return Center(child: CircularProgressIndicator(),);
            }
        )
    );
  }
}
