
import 'package:flutter/foundation.dart';
import 'package:leavemanagement/Admin/services/Admin_AddEmployee.dart';
import 'package:leavemanagement/Admin/shared/emp_info.dart';

class UserProvider with ChangeNotifier{
  Employees? _employees;
  final AdminAddEmp authmeth=AdminAddEmp();

  dynamic get getEmp => _employees ?? '';
  Future<void>init()async{
    Employees employees=await authmeth.getEmpDetails();
    _employees=employees;
  }
  Future<void>refreshEmp()async{
    Employees employees=await authmeth.getEmpDetails();
    _employees!=employees;
    notifyListeners();
  }
}