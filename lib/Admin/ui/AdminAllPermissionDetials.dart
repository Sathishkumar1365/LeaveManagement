import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leavemanagement/EndUser/shared/PermissionForm.dart';

class AdminAllPermissionDetials extends StatefulWidget {
  final PermissionForm permissionForm;
  const AdminAllPermissionDetials({Key? key, required this.permissionForm}) : super(key: key);

  @override
  State<AdminAllPermissionDetials> createState() => _AdminAllPermissionDetialsState();
}

class _AdminAllPermissionDetialsState extends State<AdminAllPermissionDetials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading:  InkWell(
            onTap:(){
              Navigator.pop(context);
            },
            child:Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
        title: Text('Details',style: GoogleFonts.ubuntu(color: Colors.black,fontWeight:FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        systemOverlayStyle:SystemUiOverlayStyle(statusBarColor:Colors.black,
            statusBarIconBrightness:Brightness.light,
            statusBarBrightness:Brightness.dark),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.permissionForm.emp_profile!),
            ),
            Text(widget.permissionForm.name,style: GoogleFonts.ubuntu(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Emp ID:',
                        style: GoogleFonts.ubuntu(color: Colors.black),
                        children: [
                          TextSpan(
                              text:widget.permissionForm.employee_id,
                              style: GoogleFonts.ubuntu(color:Colors.black)
                          )
                        ]
                    )
                )
              ],
            ),
            SizedBox(height: 5,),

            Text(widget.permissionForm.dept,style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.grey),
            ),
            SizedBox(height: 10,),
            Container(
                width: 100,
                padding: EdgeInsets.all(10),
                decoration:BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                    child: Text(widget.permissionForm.status!,style: GoogleFonts.ubuntu(color: widget.permissionForm.status == "Approved" ? Colors.green : Colors.red)))),
            SizedBox(height: 20,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height:MediaQuery.of(context).size.height*0.08,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300, //New
                      blurRadius: 14.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('From Time',style: GoogleFonts.poppins(color: Colors.black,
                              fontWeight: FontWeight.bold,fontSize: 15),),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(widget.permissionForm.fromtime,style: GoogleFonts.poppins(
                              fontSize: 12,color: Colors.black,
                            ),),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height:MediaQuery.of(context).size.height*0.08,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, //New
                    blurRadius: 14.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('To Time',style: GoogleFonts.poppins(color: Colors.black,
                            fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(widget.permissionForm.totime,style: GoogleFonts.poppins(
                            fontSize: 12,color: Colors.black,
                          ),),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height:MediaQuery.of(context).size.height*0.08,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, //New
                    blurRadius: 14.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Permission Date',style: GoogleFonts.poppins(color: Colors.black,
                            fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(widget.permissionForm.Date,style: GoogleFonts.poppins(
                            fontSize: 12,color: Colors.black,
                          ),),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height:MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, //New
                    blurRadius: 14.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Reason',style: GoogleFonts.poppins(color: Colors.black,
                            fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(widget.permissionForm.reason,style: GoogleFonts.poppins(
                              fontSize: 12,color: Colors.black,
                            ),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
