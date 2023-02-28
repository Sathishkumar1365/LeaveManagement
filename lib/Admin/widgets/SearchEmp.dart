import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../shared/emp_info.dart';
import '../ui/editprofile.dart';
import '../ui/empprofile.dart';

class SearchEmp extends StatefulWidget {
  static const String id="searchEmp";
  const SearchEmp({Key? key}) : super(key: key);

  @override
  State<SearchEmp> createState() => _SearchEmpState();
}

class _SearchEmpState extends State<SearchEmp> {
  TextEditingController search_emp=new TextEditingController();
  late String name;
  String usersearch="";
  bool doItjustOnce=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    search_emp.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Padding(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            onFieldSubmitted: (String _){
              setState(() {
                doItjustOnce=true;
              });
            },
            controller: search_emp,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                hintText: "Search Employees by ID",
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: Icon(Icons.search,color: Colors.white,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color:Colors.white24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white24,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white24,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              )
          ),
        ),
      ),
      body: doItjustOnce?FutureBuilder(
          future: FirebaseFirestore.instance.collection("employees")
              .where('employee_id',isGreaterThanOrEqualTo: search_emp.text)
              .get(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context,index){
                  DocumentSnapshot documentSnapshot=snapshot.data!.docs[index];
                  return ListTile(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmpProfile(
                        employees: Employees(
                            id:documentSnapshot.id,
                            emp_name: documentSnapshot["empname"],
                            employee_id: documentSnapshot["employee_id"],
                            emp_mail: documentSnapshot["emp_mail"],
                            emp_dept: documentSnapshot["department"],
                            emp_profile: documentSnapshot["photourl"],
                            emp_age: documentSnapshot["age"],
                            emp_address: documentSnapshot["address"] ,
                            emp_gender: documentSnapshot["gender"],
                            emp_mobile: documentSnapshot["emp_mobile"],
                            emp_password: documentSnapshot["emp_pass"],
                            emp_cpassword: documentSnapshot["emp_cpass"]),)));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(documentSnapshot['photourl']),//snapshot.data! as dynamic).docs[index]['photourl']
                    ),
                    title: Text(documentSnapshot['empname'],style: TextStyle(color: Colors.white),),//(snapshot.data! as dynamic).docs[index]['empname']
                    subtitle: Text(documentSnapshot['department'],style: TextStyle(color: Colors.white)),//(snapshot.data! as dynamic).docs[index]['department']
                  );
                }
            );
          }
      ):Center(child: Text("no records found"),)
    );
  }
}
