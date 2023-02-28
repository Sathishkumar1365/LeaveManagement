import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


Employees employeesfromjson(String str)=>Employees.fromJson(json.decode(str));

String employeestojson(Employees data)=>json.encode(data.toJson());

class Employees{
  Employees({
    required this.id,
    required this.emp_name,
    required this.employee_id,
    required this.emp_mail,
    required this.emp_dept,
    required this.emp_profile,
    required this.emp_age,
    required this.emp_address,
    required this.emp_gender,
    required this.emp_mobile,
    required this.emp_password,
    required this.emp_cpassword,
    this.pushToken

});
  final String id;
  final String employee_id;
  String emp_name;
  final String emp_mail;
  final String emp_dept;
  String emp_profile;
  String emp_age;
  String emp_address;
  String emp_gender;
  String emp_mobile;
  String emp_password;
  String emp_cpassword;
  String? pushToken;

  factory Employees.fromJson(Map<String,dynamic>json)=>Employees(
      id: json['emp_id'],
      emp_name: json['empname'],
      employee_id: json['employee_id'],
      emp_mail: json['emp_mail'],
      emp_dept: json['department'],
      emp_profile: json['photourl'],
      emp_age: json['age'],
      emp_address: json['address'],
      emp_gender: json['gender'],
      emp_mobile: json['emp_mobile'],
      emp_password: json['emp_pass'],
      emp_cpassword: json['emp_cpass'],
    pushToken: json['pushToken']
  );

  Map<String,dynamic>toJson()=>{
    'emp_id':id,
    'empname':emp_name,
    'employee_id':employee_id,
    'emp_mail':emp_mail,
    'department':emp_dept,
    'photourl':emp_profile,
    'age':emp_age,
    'address':emp_address,
    'gender':emp_gender,
    'emp_mobile':emp_mobile,
    'emp_pass':emp_password,
    'emp_cpass':emp_cpassword,
    'pushToken':pushToken
  };

  static Employees fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String,dynamic>;
    return Employees(
        id: snapshot['emp_id'],
        emp_name: snapshot['empname'],
        employee_id: snapshot['employee_id'],
        emp_mail: snapshot['emp_mail'],
        emp_dept: snapshot['department'],
        emp_profile: snapshot['photourl'],
        emp_age: snapshot['age'],
        emp_address: snapshot['address'],
        emp_gender: snapshot['gender'],
        emp_mobile: snapshot['emp_mobile'],
        emp_password: snapshot['emp_pass'],
        emp_cpassword: snapshot['emp_cpass'],
      pushToken: snapshot['pushToken']
    );
  }


}

