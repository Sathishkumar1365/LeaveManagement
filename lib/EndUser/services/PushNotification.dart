import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:leavemanagement/Admin/shared/admin_info.dart';
import 'package:leavemanagement/Admin/shared/emp_info.dart';
import 'package:leavemanagement/EndUser/shared/leaveform.dart';

class PushNotification{
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  static void initialiseNotifications()async{
    InitializationSettings initializationSettings =InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (int id,String? title,String? body,String? payload)async {}
      )
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
   static void display(RemoteMessage message)async{
    try{
      Random random=new Random();
      int id=random.nextInt(1000);
      final NotificationDetails notificationDetails=NotificationDetails(
          android: AndroidNotificationDetails(
              "mychannel",
              "my channel",
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
              largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
              styleInformation: BigTextStyleInformation(''),
              showWhen: true
          )
      );
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    }catch(e){
      print("something went wrong");
    }
  }
}
