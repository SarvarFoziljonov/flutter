import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
import 'package:flutter_instaclone/services/prefs_service.dart';

import 'home_page.dart';
class SplashPage extends StatefulWidget {
  static final String id = "splash_page";
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _initTimer () {
    Timer(Duration (seconds: 2), () {
      _callHomePage ();
      });
  }
  _callHomePage () {
  Navigator.pushReplacementNamed(context, HomePage.id);
  }

  _initNotification() {
    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
      Prefs.saveFCM(token);
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
    _initNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(252, 175, 69, 1),
            Color.fromRGBO(245, 96, 64, 1),
          ]
        ),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text("Instagram Clone", style: TextStyle(color: Colors.white, fontSize:45, fontFamily: 'Billabong'), ),
              ),
            ),
            Text("All rights reserved", style: TextStyle(color: Colors.white, fontSize: 18),),
            SizedBox(height: 10,),
          ],
        ),

      ),
    );
  }
}
