import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMeth{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future<String> uploadImageToStorage(String childname,Uint8List file,bool isAdmin) async{
    Reference ref=_storage.ref().child(childname).child(_auth.currentUser!.uid);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snap=await uploadTask;
    String downloadUrl=await snap.ref.getDownloadURL();
    return downloadUrl;
  }
  Future<String> uploadAnnouncementToStorage(String childname,Uint8List file,bool isAdmin,String documentID) async{
    Reference ref=_storage.ref().child(childname).child(documentID);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snap=await uploadTask;
    String downloadUrl=await snap.ref.getDownloadURL();
    return downloadUrl;
  }

}