import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/model/post_model.dart';
import 'package:flutter_instaclone/model/user_model.dart';
import 'package:flutter_instaclone/services/auth_service.dart';
import 'package:flutter_instaclone/services/data_service.dart';
import 'package:flutter_instaclone/services/file_service.dart';
import 'package:flutter_instaclone/services/utils_service.dart';
import 'package:image_picker/image_picker.dart';
class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  List <Post> items = new List();
  int axisCount = 1;
  String fullname = "", email = "", img_url;
  bool isLoading = false;
  int count_posts = 0, count_followers = 0, count_following = 0;
//  Beginning functions of choose photo from gallery // camera
  File _image;

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
    _apiChangPhoto ();
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
    _apiChangPhoto ();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(

              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Pick Photo'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Take Photo'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  //  ^^^ Ending functions of choose photo from gallery // camera ^^^

  void _apiLoadUser () {
    setState(() {
      isLoading = true;
    });
   DataService.loadUser().then((value) => {
     _showUserInfo (value),
   });
  }

  _showUserInfo (User user) {
    setState(() {
    isLoading = false;
    this.fullname = user.fullname;
    this.email = user.email;
    this.img_url = user.img_url;
    this.count_followers = user.followers_count;
    this.count_following = user.following_count;
    });
  }

  _apiChangPhoto () {
    if (_image == null) return;
    setState(() {
      isLoading = true;
    });
    FileService.uploadUserImage(_image).then((downloadUrl) => {
      _apiUpdateUser(downloadUrl),
    });
  }
  void _apiUpdateUser(String downloadUrl) async {
    User user = await DataService.loadUser();
    user.img_url = downloadUrl;
    await DataService.updateUser(user);
    _apiLoadUser();
  }
  void _apiLoadPosts() {
    DataService.loadPosts().then((value) => {
      _resLoadPosts(value),
    });
  }

  void _resLoadPosts(List<Post> posts) {
    setState(() {
      items = posts;
      count_posts = items.length;
    });
  }

  _actionLogout() async{

    var result = await Utils.dialogCommon(context, "Insta Clone", "Do you want to logout?", false);
    if(result != null && result){
      AuthService.signOutUser(context);
    }
  }

  _actionRemovePost(Post post) async{
    var result = await Utils.dialogCommon(context, "Insta Clone", "Do you want to remove this post?", false);
    if(result != null && result){
      setState(() {
        isLoading = true;
      });
      DataService.removePost(post).then((value) => {
        _apiLoadPosts(),
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadPosts();
    _apiLoadUser();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
       title: Text("My Profile", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 30),),
       elevation: 0,
       actions: [
         IconButton(
           onPressed: (){
             _actionLogout();
           },
           icon: Icon(Icons.exit_to_app_outlined, color: Color.fromRGBO(252, 175, 69, 1),),
         ),
       ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                // user photo
                GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(252, 175, 69, 1),
                            )
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300.0),
                          child: img_url == null || img_url.isEmpty
                              ? Image(
                            image: AssetImage("assets/images/ic_avatar.png"),
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          )
                              : Image.network(img_url, width: 70, height: 70, fit: BoxFit.cover,),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.add_circle, color: Colors.redAccent),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                // name, email
                Column(
                  children: [
                    Text(fullname.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                    Text(email, style: TextStyle(color: Colors.black54, fontSize: 16),),
                  ],
                ),
                SizedBox(height: 15,),
                // counts
                Container(
                    height: 80,
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(count_posts.toString(), style: TextStyle(color: Colors.black, fontSize: 16),),
                                    Text("POST", style: TextStyle(color: Colors.grey, fontSize: 16)),
                                  ],
                                ),
                              )
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: Colors.grey.withOpacity(0.5),

                          ),
                          Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(count_followers.toString(), style: TextStyle(color: Colors.black, fontSize: 16),),
                                    Text("FOLLOWERS", style: TextStyle(color: Colors.grey, fontSize: 16)),
                                  ],
                                ),
                              )
                          ),
                          Container(
                            width: 1,
                            height: 20,
                            color: Colors.grey.withOpacity(0.5),

                          ),
                          Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(count_following.toString(), style: TextStyle(color: Colors.black, fontSize: 16),),
                                    Text("FOLLOWING", style: TextStyle(color: Colors.grey, fontSize: 16)),
                                  ],
                                ),
                              )
                          ),
                        ],
                      ),
                    )
                ),
                SizedBox(height: 15,),
                // view buttons
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              axisCount = 1;
                            });
                          },
                          icon: Icon(Icons.list_alt),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              axisCount = 2;
                            });
                          },
                          icon: Icon(Icons.grid_view),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                // post photo and caption
                Expanded(
                  child: GridView.builder(
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: axisCount),
                      itemBuilder: (ctx, index) {
                        return _listOfPost (items[index]);
                      }
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
  Widget _listOfPost (Post post) {
    return GestureDetector(
      onLongPress: (){
        _actionRemovePost(post);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        // post photo and caption
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: post.img_post,
                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 3,),
            Text(post.caption, style: TextStyle(color: Colors.black87.withOpacity(0.5)), maxLines: 2),

          ],
        ),
      ),
    );

  }
}
