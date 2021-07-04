import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/model/post_model.dart';
import 'package:flutter_instaclone/services/data_service.dart';
class MyFeedPage extends StatefulWidget {
  PageController pageController;
  MyFeedPage ({this.pageController});

  @override
  _MyFeedPageState createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  bool isLoading = false;
  List <Post> items = new List ();

  void _apiLoadFeeds() {
    setState(() {
      isLoading = true;
    });
    DataService.loadFeeds().then((value) => {
      _resLoadFeeds(value),
    });
  }

  void _resLoadFeeds(List<Post> posts) {
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadFeeds();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Instagram Clone", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 30),),
        actions: [
          IconButton(
            onPressed: () {
              widget.pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            },
            icon: Icon(Icons.camera_alt_rounded, color: Color.fromRGBO(252, 175, 69, 1),),
          ),
        ],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          return _itemsOfPost(items [index]);
        },
      ),
    );
  }
  Widget _itemsOfPost (Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),
          //user info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300.0),
                      child: Image(
                        image: AssetImage("assets/images/ic_avatar.png"),
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.fullname, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black ),),
                        Text(post.date, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),)
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(SimpleLineIcons.options),
                  onPressed: (){},
                ),

              ],
            ),
          ),
          //post image
          //Image.network(post.postImage, fit: BoxFit.cover,),
          CachedNetworkImage(
            imageUrl: post.img_post,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          // like/share
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(FontAwesome.heart_o),
                      onPressed: (){}
                  ),
                  IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: (){}
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: RichText(
              softWrap: true,
              overflow: TextOverflow.visible,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${post.caption}",
                    style: TextStyle(color: Colors.black),
                  )
                ]
              ),
            ),
          ),
        ],
      ),


    );
  }
}
