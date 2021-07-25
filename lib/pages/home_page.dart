import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/myfeed_page.dart';
import 'package:flutter_instaclone/pages/mylikes_page.dart';
import 'package:flutter_instaclone/pages/myprofile_page.dart';
import 'package:flutter_instaclone/pages/mysearch_page.dart';
import 'package:flutter_instaclone/pages/myupload_page.dart';
import 'package:flutter_instaclone/services/utils_service.dart';
class HomePage extends StatefulWidget {
  static final String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  PageController _pageController;
  int _currentTap = 0;

  _initNotification() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Utils.showLocalNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        //print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        //print("onResume: $message");
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initNotification();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          MyFeedPage(pageController: _pageController),
          MySearchPage(),
          MyUploadPage (pageController2: _pageController),
          MyLikesPage(),
          MyProfilePage(),

        ],
        onPageChanged: (int index){
          setState(() {
           _currentTap = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (int index){
          setState(() {
            _currentTap = index;
            _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
          });
        },
        currentIndex: _currentTap,
        activeColor: Color.fromRGBO(252, 175, 69, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 32,)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 32,)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, size: 32,)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 32,)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded, size: 32,)
          ),
        ],
      ),
    );
  }
}
