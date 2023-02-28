import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../ui/AdminHome.dart';

class AddUserAnim extends StatelessWidget {
  const AddUserAnim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Lottie.network('https://assets8.lottiefiles.com/packages/lf20_kyoca9ep.json',height:300,width: 300,repeat:true),
              Text("User Added Successfully",style: GoogleFonts.kanit(fontSize: 20,color: Colors.white)),
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
