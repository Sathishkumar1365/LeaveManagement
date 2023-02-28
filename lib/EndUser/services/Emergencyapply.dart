import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../shared/Emergencyform.dart';
import '../shared/leaveform.dart';

class EmergencyApply {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> applyemergencyleave({
    required String emp_id,
    required String employee_id,
    String? leave_id,
    String? emp_profile,
    required String emp_name,
    required String emp_mail,
    required String emp_dept,
    required dynamic leavetype,
    required DateTime fromDate,
    required DateTime toDate,
    required String reason,
    Timestamp? timestamp,
    String? token

  }) async {
    EmergencyForm emergencyForm = EmergencyForm(emp_id: emp_id,
        employee_id: employee_id,
        emp_profile: emp_profile,
        name: emp_name,
        mail: emp_mail,
        dept: emp_dept,
        leavetype: leavetype,
        fromDate: fromDate,
        toDate: toDate,
        reason: reason,
      timestamp: timestamp,
        token: token
    );
    _firestore.collection('emergencyleave').doc().set(emergencyForm.toJson());
  }
}