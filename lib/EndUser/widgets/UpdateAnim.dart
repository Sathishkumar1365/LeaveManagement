import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../ui/UserHome.dart';

class UpdateAnim extends StatelessWidget {
  const UpdateAnim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Lottie.network('https://assets10.lottiefiles.com/packages/lf20_mkaua5rx.json',height:300,repeat:false),
              Text("Updated Successfully",style: GoogleFonts.kanit(fontSize: 20,color: Colors.black)),
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
