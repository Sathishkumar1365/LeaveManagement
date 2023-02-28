import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../shared/leaveform.dart';

class LeaveApply{
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<String?>applyleave({
    required String emp_id,
    String? emp_profile,
    String? leave_id,
    required String employee_id,
    required String emp_name,
    required String emp_mail,
    required String emp_dept,
    required dynamic leavetype,
    required String fromDate,
    required String toDate,
    required String reason,
    Timestamp? timestamp,
    String?status,
    String? token
   })async{
    LeaveForm leaveForm=LeaveForm(emp_id:emp_id,emp_profile:emp_profile,employee_id:employee_id,name: emp_name, mail: emp_mail, dept: emp_dept, leavetype: leavetype, fromDate: fromDate, toDate: toDate, reason:reason,timestamp: timestamp,status:status,token: token);
    _firestore.collection('leave').doc(leave_id).set(leaveForm.toJson());
  }
}