import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holbegram/methods/user_storage.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> singUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || file.isNotEmpty) {
        //register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods().uploadImageToStorage("profilePics", file, false);

        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
          username: username,
          followers: [],
          following: [],
          photoUrl: photoUrl,
          posts: [],
          saved: [],
          searchKey:
          username.substring(0, 1),
        );

        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson(),);
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        //register User
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }


  Future<String> SingUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || file.isNotEmpty) {
        //register User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods().uploadImageToStorage("profilePics", file, false);

        model.User user = model.User(
          uid: cred.user!.uid,
          email: email,
          username: username,
          followers: [],
          following: [],
          photoUrl: photoUrl,
          posts: [],
          saved: [],
          searchKey: username.substring(0, 1),
        );



        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson(),);

        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

}
