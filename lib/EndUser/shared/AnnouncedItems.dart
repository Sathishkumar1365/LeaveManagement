

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncedItems{
  String id;
  String announcement_title;
  String description;
  String announcement_image;
  Timestamp? timestamp;

  AnnouncedItems(this.id,this.announcement_title,this.description,this.timestamp,this.announcement_image);

  Map<String,dynamic>toJson()=>{
    'id':id,
    'title':announcement_title,
    'description':description,
    'announcement_image':announcement_image,
    'timestamp':timestamp
  };
}