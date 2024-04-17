import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String uid;
  final String description;
  final String username;
  final String postId;
  final String datePublished;
  final String profileImage;
  final String postUrl;
  final likes;

  const Post({
    required this.uid,
    required this.description,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.profileImage,
    required this.postUrl,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'description': description,
    'username': username,
    'postId': postId,
    'publishedAt': datePublished,
    'profileImage': profileImage,
    'postUrl': postUrl,
    'postUrl': postUrl,
    'likes': likes,
  };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['publishedAt'],
      profileImage: snapshot['profileImage'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
    );
  }
}