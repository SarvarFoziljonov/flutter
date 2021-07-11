import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/model/user_model.dart';
import 'package:flutter_instaclone/services/data_service.dart';
class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchcontroller = TextEditingController();
  List <User> items = new List();
  bool isLoading = false;

  void _apiSearchUsers(String keyword){
    setState(() {
      isLoading = true;
    });
    DataService.searchUsers(keyword).then((users) => {
      _respSearchUsers(users),
    });
  }
  void  _respSearchUsers(List<User> users){
    setState(() {
      items = users;
      isLoading = false;
    });
  }

  void _apiFollowUser(User someone) async{
    setState(() {
      isLoading = true;
    });
    await DataService.followUser(someone);
    setState(() {
      someone.followed = true;
      isLoading = false;
    });
    DataService.storePostsToMyFeed(someone);
  }

  void _apiUnfollowUser(User someone) async{
    setState(() {
      isLoading = true;
    });
    await DataService.unfollowUser(someone);
    setState(() {
      someone.followed = false;
      isLoading = false;
    });
    DataService.removePostsFromMyFeed(someone);
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiSearchUsers("");
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
      body: Stack(
        children: [
          Container(
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
                    onChanged: (input) {
                      print (input);
                      _apiSearchUsers (input);
                    },
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
          isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      )
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
              child: user.img_url.isEmpty
                ?Image(
                image: AssetImage("assets/images/ic_avatar.png"),
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ) : Image.network(user.img_url, width: 40, height: 40, fit: BoxFit.cover,),
            ),
          ),
          SizedBox(width: 10,),
          // name, email
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              Text(user.fullname, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
              Text(user.email, style: TextStyle(color: Colors.black54), ),
           ],
          ),
          SizedBox(width: 10,),
          // Follow
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    if(user.followed){
                      _apiUnfollowUser(user);
                    }else{
                      _apiFollowUser(user);
                    }
                  },

                  child: Container(
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
                )
              ],
            )
          ),

        ],
      ),
    );
  }
}
