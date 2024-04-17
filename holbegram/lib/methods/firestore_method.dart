import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:holbegram/methods/user_storage.dart';
import 'package:uuid/uuid.dart';
import '../models/posts.dart';

class FirestoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //upload post image to firebase storage

Future<List<Post>> getPosts() async {
    List<Post> posts = [];
    QuerySnapshot snap = await _fireStore.collection("posts").get();
    snap.docs.forEach((element) {
      posts.add(Post.fromSnap(element));
    });
    return posts;
  }

  Future<List<Post>> getPostsByUser(String uid) async {
    List<Post> posts = [];
    QuerySnapshot snap = await _fireStore.collection("posts").where("uid", isEqualTo: uid).get();
    snap.docs.forEach((element) {
      posts.add(Post.fromSnap(element));
    });
    return posts;
  }

  Future<List> deletePost(String postId, String postUrl) async {
    List res = [];
    try {
      await FirebaseStorage.instance.refFromURL(postUrl).delete();
      await _fireStore.collection("posts").doc(postId).delete();
      res.add("success");
    } catch (e) {
      res.add(e.toString());
    }
    return res;
  }

  Future<String> uploadPost(
      String description,
      Uint8List file,
      String uid,
      String username,
      String profileImage,
      ) async {
    String res = "Some Error occured";
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        uid: uid,
        description: description,
        username: "username",
        postId: postId,
        datePublished: DateTime.now().toString(),
        postUrl: photoUrl,
        profileImage: profileImage,
        likes: [],
      );

      _fireStore.collection("posts").doc(postId).set(post.toJson(),);
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}