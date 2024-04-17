import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/posts.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Holbegram',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: 'Billabong',
              ),
            ),
            Image.asset(
              'assets/images/logo.jpg',
              height: 32,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {},
          ),

          IconButton(
            icon: const Icon(
              Icons.message_outlined,
              color: Colors.black45,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Posts(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          }
      ), // Posts() Later
    );
  }
}
