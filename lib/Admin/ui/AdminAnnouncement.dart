import 'dart:typed_data';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leavemanagement/Admin/utils/PickImage.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../../EndUser/services/PushNotification.dart';
import '../services/Admin_AddEmployee.dart';
import '../widgets/AnnounceAnim.dart';

class AdminAnnouncement extends StatefulWidget {
  const AdminAnnouncement({Key? key}) : super(key: key);

  @override
  State<AdminAnnouncement> createState() => _AdminAnnouncementState();
}

class _AdminAnnouncementState extends State<AdminAnnouncement> {
  TextEditingController title=TextEditingController();
  TextEditingController desc=TextEditingController();
  bool _isloading=false;
  PushNotification pushNotification=PushNotification();
  Uint8List? announment_img;
  void selectImage() async{
    Uint8List im=await pickImage(ImageSource.gallery);
    setState(() {
      announment_img=im;
    });
  }
  sendNotifictaion(String title)async{
    final data={
      'click_action':'FLUTTER_NOTIFICATION_CLICK',
      'id':'1',
      'status':'done',
      'message':title,
    };
    try{
      final employeesCollection = FirebaseFirestore.instance.collection('employees');
      final employeeDocs = await employeesCollection.get();
      for(final employeeDoc in employeeDocs.docs){
        final employeeData=employeeDoc.data();
        if(employeeData['token']!=null){
          http.Response response= await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),headers: <String,String>{
            'Content-Type':'application/json',
            'Authorization':'key=AAAAC5PfqaE:APA91bGCpRRsGzTcx1ev6LvAOZ0IJAY5JdXNNMsJ2V3j5LPK7XfpF7feE4RSgbeMSDr-Hz2FhZ9ynnHQt3BTArSqp184UpDTKyOdAesPLX-bbqyR5FgJBCO2n9eEff7NFKYKIjMyn6-O'
          },
              body: jsonEncode(<String,dynamic>{
                'notification':<String,dynamic>{'title':title,'body':'You have Announcement from Admin'},
                'priority':'high',
                'data':data,
                'to':employeeData['token']
              })
          );
          if(response.statusCode==200){

            print("yeah notification sended");

          }else{
            print("error");
          }
        }
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    desc.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text('Announcement',style: GoogleFonts.inder(color: Colors.white),)
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: title,
                obscureText: false,
          style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  prefixIcon: Icon(Icons.cabin,color: Colors.white,),
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter title',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: desc,
                maxLines: 8,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      announment_img!=null?CircleAvatar(
                          radius: 54,
                          backgroundImage: MemoryImage(announment_img!)
                      ):CircleAvatar(radius: 54,backgroundImage:AssetImage('assets/prflebg.jpg'),),
                      Positioned(
                          bottom: -10,
                          left: 70,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: Icon(Icons.add_a_photo,color: Colors.red,),
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              MaterialButton(
                  color: Colors.blueAccent,
                  child:_isloading?Center(child: CircularProgressIndicator(color: Colors.white,),):Text('Announce',style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    setState(() {
                      _isloading=true;
                    });
                    String postId=Uuid().v1();
                    String? res=await AdminAddEmp().announcement(id:postId,title: title.text, desc: desc.text,timestamp: Timestamp.now(),image: announment_img);
                    sendNotifictaion("Announcement");
                    if(res==null){
                     _isloading? Navigator.push(context, MaterialPageRoute(builder: (context)=>AnnounceAnim())):Center(child:CircularProgressIndicator());
                    }else{
                      setState(() {
                        _isloading=false;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some Fields Are Incorrect')));
                      });

                    }
                  }
              )
            ],
          )
          ,),
      ),
    );
  }
}
