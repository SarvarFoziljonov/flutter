import 'package:flutter/material.dart';
import 'package:flutter_instaclone/model/post_model.dart';
import 'package:flutter_instaclone/model/user_model.dart';
import 'package:flutter_instaclone/pages/users_profile_page.dart';
import 'package:flutter_instaclone/services/data_service.dart';
class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchcontroller = TextEditingController();
  List <User> items = new List();
  List<User> item=List();
  List<Post> things=List();

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

  void _apiLoader()async{
    List<User> data = await DataService.loadUserOthers();

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiSearchUsers("");
    _apiLoader();
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
                        return makeOfItem(items [index]);
                      },
                    ),
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
  Widget makeOfItem(User item) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(ctx)=>UserProfilePage(data:item,need:things)));
      },
      child: Container(
        height: 90,
        child: Row(
          children: [
            Container(
                padding:EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(width: 1.5,color: Color.fromRGBO(193, 53, 132, 1))

                ),
                child:item.img_url.isEmpty?ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image(
                    image: AssetImage("asset/instagramPicture.png"),
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ):ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(item.img_url,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,)
                )
            ),
            SizedBox(width: 15,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.fullname,style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3,),
                Text(item.email,style: TextStyle(color: Colors.black54),)

              ],),
            Expanded(child:Row(
              mainAxisAlignment:MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    if(item.followed){
                      _apiUnfollowUser(item);
                    }else{
                      _apiFollowUser(item);
                    }
                  }
                  ,
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1,color: Color.fromRGBO(193, 53, 132, 1))
                    ),
                    child: Center(
                      child: item.followed ? Text("Following") : Text("Follow"),
                    ),
                  ),
                ),
              ],),)
          ],),
      ),
    );
  }




}
