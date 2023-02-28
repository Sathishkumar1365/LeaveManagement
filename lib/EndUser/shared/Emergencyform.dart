import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyForm {
  EmergencyForm({
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
    this.token,
    this.status

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
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;
  final Timestamp? timestamp;
  final String? status;
  final String? token;

  factory EmergencyForm.fromJson(Map<String, dynamic>json)=>
      EmergencyForm(
          leave_id: json['leave_id'],
          emp_id: json['emp_id'],
          employee_id: json['employee_id'],
          emp_profile: json['emp_profile'],
          leavetype: json['leavetype'],
          fromDate:(json['fromDate']as Timestamp).toDate(),
          toDate: (json['toDate'] as Timestamp).toDate(),
          name: json['name'],
          mail: json['mail'],
          dept: json['dept'],
          reason: json['reason'],
        timestamp: json['timestamp'],
          status: json['status'],
          token:json['token']
      );

  Map<String, dynamic> toJson() =>
      {
        'leave_id': leave_id,
        'emp_id': emp_id,
        'employee_id':employee_id,
        'emp_profile':emp_profile,
        'name': name,
        'mail': mail,
        'dept': dept,
        'leavetype': leavetype,
        'fromDate': Timestamp.fromDate(fromDate),
        'toDate':Timestamp.fromDate(toDate),
        'reason': reason,
        'timestamp':timestamp,
        'status':status,
        'token':token
      };


}