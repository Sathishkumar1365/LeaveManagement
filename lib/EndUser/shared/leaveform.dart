
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Admin/shared/admin_info.dart';

class LeaveForm{
  LeaveForm({
    this.leave_id,
    this.emp_id,
    required this.employee_id,
    this.to_id,
    this.emp_profile,
    required this.name,
    required this.mail,
    required this.dept,
    required this.leavetype,
    required this.fromDate,
    required this.toDate,
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
  final dynamic leavetype;
  final String fromDate;
  final String toDate;
  final String reason;
  final Timestamp? timestamp;
  final String? status;
  final String? token;

  factory LeaveForm.fromJson(Map<String,dynamic>json)=>LeaveForm(
      leave_id: json['leave_id'],
      emp_id: json['emp_id'],
      employee_id: json['employee_id'],
      emp_profile: json['emp_profile'],
      leavetype: json['leavetype'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      name: json['name'],
      mail: json['mail'],
      dept: json['dept'],
      reason: json['reason'],
    timestamp: json['timestamp'],
    status: json['status'],
    token:json['token']
  );

  Map<String,dynamic>toJson()=>{
    'leave_id':leave_id,
    'emp_id':emp_id,
    'employe_id':employee_id,
    'emp_profile':emp_profile,
    'name':name,
    'mail':mail,
    'dept':dept,
    'leavetype':leavetype,
    'fromDate':fromDate,
    'toDate':toDate,
    'reason':reason,
    'timestamp':timestamp,
    'status':status,
    'token':token
  };


}
