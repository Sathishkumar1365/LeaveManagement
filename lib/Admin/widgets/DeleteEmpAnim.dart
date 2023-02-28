import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../ui/AdminHome.dart';
import '../ui/ManageEmployees.dart';

class DeleteEmpAnim extends StatelessWidget {
  const DeleteEmpAnim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Lottie.network('https://assets10.lottiefiles.com/packages/lf20_tqsLQJ3Q73.json',height:200,repeat:false),
              Text("Employee Deleted",style: GoogleFonts.kanit(fontSize: 20,color: Colors.white)),
              SizedBox(height: 20,),
              OutlinedButton(
                  style: ButtonStyle(
                      side:MaterialStateProperty.all(BorderSide(color: Colors.indigo))
                  ),
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminHome()), (route) => false);
                  },
                  child: Text('Go to home',style: TextStyle(color: Colors.indigo),))

            ]
        ),
      ),
    );
  }
}
