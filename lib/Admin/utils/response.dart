import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:leavemanagement/Admin/shared/user_provider.dart';
import 'package:provider/provider.dart';

class Response{
  int? code;
  String? message;
  Response({this.code,this.message});

}