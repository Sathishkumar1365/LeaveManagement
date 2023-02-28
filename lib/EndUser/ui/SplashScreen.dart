import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leavemanagement/EndUser/ui/userlogin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserLogin()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark,statusBarBrightness: Brightness.light),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body:Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Image.asset('assets/izonepnglogo.png',height:300,width:800),
              Image.asset('assets/ems.png',height:330,width:540),

              CircularProgressIndicator(
                color: Colors.black,
              ),
            ],
          ),
        ),
      )
    );
  }
}

