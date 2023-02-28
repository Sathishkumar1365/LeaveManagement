import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../ui/UserHome.dart';
import '../ui/applyleave.dart';
class LeaveSent extends StatefulWidget {
  const LeaveSent({Key? key}) : super(key: key);

  @override
  State<LeaveSent> createState() => _LeaveSentState();
}

class _LeaveSentState extends State<LeaveSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Lottie.network('https://assets10.lottiefiles.com/private_files/lf30_uifl1mmi.json',height:200,repeat:false),
            Text("Leave Applied Successfully",style: GoogleFonts.kanit(fontSize: 20,color: Colors.black)),
            SizedBox(height: 20,),
            OutlinedButton(
              style: ButtonStyle(
                side:MaterialStateProperty.all(BorderSide(color: Colors.indigo))

              ),
                onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserHome()), (route) => false);
                },
                child: Text('Go to home',style: TextStyle(color: Colors.indigo),))

          ]
        ),
      ),
    );
  }
}
