import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../shared/PermissionForm.dart';


class PermissionApply{
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<String?>applypermission({
    required String emp_id,
    String? leave_id,
    String? emp_profile,
    required String employee_id,
    required String emp_name,
    required String emp_mail,
    required String emp_dept,
    required String date,
    required String fromtime,
    required String totime,
    required String reason,
    Timestamp? timestamp,
    String? status,
    String? token

  })async{
    PermissionForm leaveForm=PermissionForm(emp_id:emp_id,employee_id: employee_id,emp_profile:emp_profile,name: emp_name, mail: emp_mail, dept: emp_dept,reason:reason, Date:date, fromtime: fromtime, totime: totime,timestamp: timestamp,status:status,token: token );
    _firestore.collection('permission').doc().set(leaveForm.toJson());
  }
}