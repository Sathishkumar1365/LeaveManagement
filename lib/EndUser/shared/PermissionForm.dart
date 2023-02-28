import 'package:cloud_firestore/cloud_firestore.dart';

class PermissionForm{
  PermissionForm({
    this.leave_id,
    this.emp_id,
    required this.employee_id,
    this.to_id,
    this.emp_profile,
    required this.name,
    required this.mail,
    required this.dept,
    required this.Date,
    required this.fromtime,
    required this.totime,
    required this.reason,
    this.timestamp,
    this.status,
    this.token
  });

  final String? leave_id;
  final String? emp_id;
  final String employee_id;
  final String? to_id;
  final String? emp_profile;
  final String name;
  final String mail;
  final String dept;
  final String type="permission";
  final String Date;
  final String fromtime;
  final String totime;
  final String reason;
  final Timestamp? timestamp;
  final String? status;
  final String? token;

  factory PermissionForm.fromJson(Map<String,dynamic>json)=>PermissionForm(
      leave_id: json['leave_id'],
      emp_id: json['emp_id'],
      employee_id: json['employee_id'],
      emp_profile: json['emp_profile'],
      name: json['name'],
      mail: json['mail'],
      dept: json['dept'],
      reason: json['reason'],
      Date: json['date'],
      fromtime: json['fromtime'],
    totime: json['toTime'],
    timestamp: json['timestamp'],
      status: json['status'],
      token:json['token']
  );

  Map<String,dynamic>toJson()=>{
    'leave_id':leave_id,
    'emp_id':emp_id,
    'employee_id':employee_id,
    'emp_profile':emp_profile,
    'name':name,
    'mail':mail,
    'dept':dept,
    'reason':reason,
    'date':Date,
    'fromtime':fromtime,
    'toTime':totime,
    'timestamp':timestamp,
    'status':status,
    'token':token
  };


}