import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Approved extends StatefulWidget {
  const Approved({Key? key}) : super(key: key);

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.green,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
        backgroundColor: Colors.green,
        elevation: 10,
        title: Text('Approved History'),
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
        ),
        leadingWidth: 37,
      ),
    );
  }
}
