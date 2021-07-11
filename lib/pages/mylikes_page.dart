import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instaclone/model/post_model.dart';
import 'package:flutter_instaclone/services/data_service.dart';
class MyLikesPage extends StatefulWidget {
  @override
  _MyLikesPageState createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  bool isLoading = false;
  List <Post> items = new List ();

  void _apiLoadLikes() {
    setState(() {
      isLoading = true;
    });
    DataService.loadLikes().then((value) => {
      _resLoadLikes(value),
    });
  }

  void _resLoadLikes(List<Post> posts) {
    setState(() {
      items = posts;
      isLoading = false;
    });
  }

  void _apiPostUnLike(Post post) {
    setState(() {
      isLoading = true;
      post.liked = false;
    });
    DataService.likePost(post, false).then((value) => {
      _apiLoadLikes(),
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiLoadLikes();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Likes", style: TextStyle(color: Colors.black, fontFamily: 'Billabong', fontSize: 30),),
        elevation: 0,
      ),
      body: Stack(
        children: [
          items.length > 0?
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index){
              return _itemsOfPost(items[index]);
            },
          ): Center(
            child: Text("No liked posts"),
          ),

          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink(),

        ],
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
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          // like/share
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (post.liked) {
                        _apiPostUnLike(post);
                      }
                    },
                    icon: post.liked
                        ? Icon(
                      FontAwesome.heart,
                      color: Colors.red,
                    )
                        : Icon(FontAwesome.heart_o),
                  ),

                  IconButton(
                      icon: Icon(FontAwesome.send),
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
