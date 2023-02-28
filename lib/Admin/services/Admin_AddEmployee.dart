import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:leavemanagement/Admin/shared/emp_info.dart';
import 'package:leavemanagement/EndUser/shared/AnnouncedItems.dart';
import 'package:uuid/uuid.dart';
import '../utils/ProfilePic.dart';
import '../utils/response.dart';

class AdminAddEmp{
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<Employees>getEmpDetails()async{
    User current_emp=auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('employees').doc(current_emp.uid).get();
    return Employees.fromSnap(snap);
  }

  Future<String?>AddUser({
  required String emp_name,
    required String employee_id,
  required String emp_dept,
  required String emp_mail,
  required String emp_address,
  required String emp_gender,
  required String emp_age,
  required String emp_mobile,
  required String emp_password,
  required String emp_cpass,
  required Uint8List emp_profile,
})async{
    String res="some error occured";
    try{
      if(emp_name.isNotEmpty||emp_mail.isNotEmpty||emp_gender.isNotEmpty||emp_address.isNotEmpty||emp_dept.isNotEmpty||emp_age.isNotEmpty||emp_mobile.isNotEmpty||emp_password.isNotEmpty||emp_cpass.isNotEmpty){
        UserCredential emp_unique=await auth.createUserWithEmailAndPassword(email: emp_mail, password: emp_password);
        String photourl=await StorageMeth().uploadImageToStorage('profilePics', emp_profile, false);
        Employees employees=Employees(id: emp_unique.user!.uid,emp_name: emp_name,employee_id:employee_id, emp_mail: emp_mail, emp_dept: emp_dept, emp_profile: photourl, emp_age: emp_age, emp_address: emp_address, emp_gender: emp_gender, emp_mobile: emp_mobile, emp_password: emp_password, emp_cpassword: emp_cpass, );
        _firestore.collection('employees').doc(emp_unique.user!.uid).set(employees.toJson());
      }
    }catch(e){
      res=e.toString();
    }
    return res;
  }
  Future<String>loginUser({required String email,required String password})async{
    String res="some error occured";
    try{
      if(email.isNotEmpty||password.isNotEmpty){
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res="success";
      }else{
        res='failed';
      }
    }catch(err){
      res=err.toString();
    }
    return res;
  }
  Future<String>loginAdmin({required String admin_mail,required String admin_pass})async{
    String res="some error occured";
    try{
      if(admin_mail.isNotEmpty||admin_pass.isNotEmpty){
        await auth.signInWithEmailAndPassword(email: admin_mail, password: admin_pass);
        res="success";
      }else{
        res="failed";
      }
    }catch(err){
      res=err.toString();
    }
    return res;
  }
  static Stream<QuerySnapshot>reademployee(){
    final CollectionReference _employees =
    FirebaseFirestore.instance.collection('employees');
    return _employees.snapshots();
  }
  Future<String?>updateemp({String? id,required String emp_name,required employee_id,required String emp_mail,required String emp_dept,required String emp_address,required String emp_gender,required String emp_age,required String emp_profile,required String emp_mobile,required String emp_pass,required String emp_cpass})async{
    final Response response=new Response();
    final CollectionReference _Collection = _firestore.collection('employees');
    Employees employees=Employees(id: id!, emp_name: emp_name,employee_id: employee_id, emp_mail: emp_mail, emp_dept: emp_dept, emp_profile: emp_profile, emp_age: emp_age, emp_address: emp_address, emp_gender: emp_gender, emp_mobile: emp_mobile, emp_password: emp_pass, emp_cpassword: emp_cpass);
    DocumentReference documentReferencer = _Collection.doc(id);
    await documentReferencer.update(employees.toJson()).whenComplete((){
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e){
      print('error');
    });
  }

  Future<String?>announcement({String? id,required String title,required String desc,Timestamp? timestamp,Uint8List? image})async{
    String postId=Uuid().v1();
    String anuncement_img=await StorageMeth().uploadAnnouncementToStorage('announcement', image!, false,postId);
    AnnouncedItems announcedItems=AnnouncedItems(postId, title, desc,timestamp,anuncement_img);
    _firestore.collection('announcement').doc().set(announcedItems.toJson());
  }

}