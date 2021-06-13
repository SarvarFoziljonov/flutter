import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
class SplashPage extends StatefulWidget {
  static final String id = "splash_page";
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _initTimer () {
    Timer(Duration (seconds: 2), () {
      _callSignInPage ();
      });
  }
  _callSignInPage () {
  Navigator.pushReplacementNamed(context, SigninPage.id);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
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
            Color.fromRGBO(193, 53, 132, 1),
            Color.fromRGBO(131, 58, 180, 1),
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
