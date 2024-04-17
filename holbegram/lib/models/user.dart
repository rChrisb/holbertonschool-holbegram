import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String email;
  String username;
  final String photoUrl;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  List<dynamic> saved;
  String searchKey;

  User({
    required this.uid,
    required this.email,
    required this.username,
    required this.followers,
    required this.following,
    required this.photoUrl,
    required this.posts,
    required this.saved,
    required this.searchKey,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'username': username,
    'followers': followers,
    'following': following,
    'photoUrl': photoUrl,
    'posts': posts,
    'saved': saved,
    'searchKey': searchKey,
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>?;

    if (snapshot == null) {
      throw const FormatException("Invalid snapshot data");
    }

    return User(
      uid: snapshot['uid'] ?? '',
      email: snapshot['email'] ?? '',
      username: snapshot['username'] ?? '',
      followers: snapshot['followers'] ?? [],
      following: snapshot['following'] ?? [],
      photoUrl: snapshot['photoUrl'] ?? '',
      posts: snapshot['posts'] ?? [],
      saved: snapshot['saved'] ?? [],
      searchKey: snapshot['searchKey'] ?? '',
    );
  }

}