import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/model/user_model.dart';
class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchcontroller = TextEditingController();
  List <User> items = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(User(name: "Sarvarbek", email: "sarvarbek@gmail.com"));
    items.add(User(name: "Sarvarbek", email: "sarvarbek@gmail.com"));
    items.add(User(name: "Sarvarbek", email: "sarvarbek@gmail.com"));
    items.add(User(name: "Sarvarbek", email: "sarvarbek@gmail.com"));
    items.add(User(name: "Sarvarbek", email: "sarvarbek@gmail.com"));
    items.add(User(name: "Sarvarbek", email: "sarvarbek@gmail.com"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Search", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 30),),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10 ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey, width: 1,
                ),
              ),
              height: 40,
              child: TextField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.grey,)
                ),
              ),
            ),
            Expanded(
             child: ListView.builder(
               itemCount: items.length,
               itemBuilder: (ctx, index){
                 return _itemOfUsers(items [index]);
               },
             )
            ),
          ],
        ),
      ),
    );
  }
  Widget _itemOfUsers (User user) {
    return Container(
      height: 90,
      margin: EdgeInsets.only(bottom: 1),
      child: Row(
        children: [
          // userphoto
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            border: Border.all(
              width: 1.5,
              color: Color.fromRGBO(252, 175, 69, 1),
            ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300.0),
              child: Image(
                image: AssetImage("assets/images/ic_avatar.png"),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10,),
          // name, email
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Text(user.name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
              Text(user.email, style: TextStyle(color: Colors.black54), ),
           ],
          ),
          SizedBox(width: 10,),
          // Follow
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )
                  ),
                  width: 100,
                  height: 30,
                  child: Center(
                    child: Text("Follow"),
                  ),
                ),
              ],
            )
          ),

        ],
      ),
    );
  }
}
