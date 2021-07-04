import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instaclone/model/post_model.dart';
import 'package:flutter_instaclone/model/user_model.dart';
import 'package:flutter_instaclone/services/prefs_service.dart';
import 'package:flutter_instaclone/services/utils_service.dart';

class DataService{
 static final _firestore = Firestore.instance;
 static String folder_users = "users";
 static String folder_posts = "posts";
 static String folder_feeds = "feeds";
 static String folder_following = "following";
 static String folder_followers = "followers";

 static Future storeUser (User user) async {
 user.uid = await Prefs.loadUserId();
 return _firestore.collection(folder_users).document(user.uid).setData(user.toJson());
 }
  static Future <User> loadUser () async {
   String uid = await Prefs.loadUserId();
   var value = await _firestore.collection("users").document(uid).get();
   User user = User.fromJson(value.data);
   return user;
  }

  static Future updateUser (User user) async {
    String uid = await Prefs.loadUserId();
    return _firestore.collection(folder_users).document(uid).updateData(user.toJson());

  }

 static Future<List<User>> searchUsers(String keyword) async {
   List<User> users = new List();
   String uid = await Prefs.loadUserId();

   var querySnapshot = await _firestore.collection(folder_users).orderBy(
       "email").startAt([keyword]).getDocuments();
   print(querySnapshot.documents.length);

   querySnapshot.documents.forEach((result) {
     User newUser = User.fromJson(result.data);
     if (newUser.uid != uid) {
       users.add(newUser);
     }
   });
   return users;
 }

 static Future<Post> storePost(Post post) async {
   User me = await loadUser();
   post.uid = me.uid;
   post.fullname = me.fullname;
   post.img_user = me.img_url;
   post.date = Utils.currentDate();

   String postId = _firestore.collection(folder_users).document(me.uid).collection(folder_posts).document().documentID;
   post.id = postId;

   await _firestore.collection(folder_users).document(me.uid).collection(folder_posts).document(postId).setData(post.toJson());
   return post;
 }

 static Future<Post> storeFeed(Post post) async {
   String uid = await Prefs.loadUserId();

   await _firestore.collection(folder_users).document(uid).collection(folder_feeds).document(post.id).setData(post.toJson());
   return post;
 }

 static Future<List<Post>> loadFeeds() async {
   List<Post> posts = new List();
   String uid = await Prefs.loadUserId();
   var querySnapshot = await _firestore.collection(folder_users).document(uid).collection(folder_feeds).getDocuments();

   querySnapshot.documents.forEach((result) {
     Post post = Post.fromJson(result.data);
     if(post.uid == uid) post.mine = true;
     posts.add(post);
   });
   return posts;
 }

 static Future<List<Post>> loadPosts() async {
   List<Post> posts = new List();
   String uid = await Prefs.loadUserId();

   var querySnapshot = await _firestore.collection(folder_users).document(uid).collection(folder_posts).getDocuments();

   querySnapshot.documents.forEach((result) {
     posts.add(Post.fromJson(result.data));
   });
   return posts;
 }



}