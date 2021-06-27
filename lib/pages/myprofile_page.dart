import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/model/post_model.dart';
import 'package:flutter_instaclone/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  List <Post> items = new List();
  String post_image1 = "https://i.postimg.cc/Nf5CG97m/photo-1.jpg";
  String post_image2 = "https://i.postimg.cc/tJSX3ZYF/2.jpg";
  String post_image3 = "https://i.postimg.cc/K8NyB3wj/3.jpg";
  String post_image4 = "https://i.postimg.cc/SKJtRXpw/4.jpg";


  int axisCount = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items.add(Post(postImage: post_image1, caption: "Discover more useful informations "));
    items.add(Post(postImage: post_image2, caption: "Macbook the best laptop"));
    items.add(Post(postImage: post_image3, caption: "Work hard, rich big results"));
    items.add(Post(postImage: post_image4, caption: "High technology our future"));

  }

//  Beginning functions of choose photo from gallery // camera
  File _image;

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
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
             AuthService.signOutUser(context);
           },
           icon: Icon(Icons.exit_to_app_outlined, color: Colors.black),
         ),
       ],
      ),
      body: Container(
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
                      child: _image == null
                          ? Image(
                        image: AssetImage("assets/images/ic_avatar.png"),
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      )
                          : Image.file(_image, width: 70, height: 70, fit: BoxFit.cover,),
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
               Text("Sarvarbek".toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
               Text("sarvarbek@gmail.com", style: TextStyle(color: Colors.black54, fontSize: 16),),
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
                           Text("675", style: TextStyle(color: Colors.black, fontSize: 16),),
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
                             Text("4256", style: TextStyle(color: Colors.black, fontSize: 16),),
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
                             Text("850", style: TextStyle(color: Colors.black, fontSize: 16),),
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
      )
    );
  }
  Widget _listOfPost (Post post) {
    return Container(
      padding: EdgeInsets.all(10),
      // post photo and caption
      child: Column(
        children: [
         Expanded(
           child: CachedNetworkImage(
             width: double.infinity,
             imageUrl: post.postImage,
             placeholder: (context, url) => CircularProgressIndicator(),
             errorWidget: (context, url, error) => Icon(Icons.error),
             fit: BoxFit.cover, 
           ),
         ),
         SizedBox(height: 3,),
         Text(post.caption, style: TextStyle(color: Colors.black87.withOpacity(0.5)), maxLines: 2),

        ],
      ),
    );

  }
}
