import '../../screens/Pages/add_image.dart';
import '../../screens/Pages/favorite.dart';
import '../../screens/Pages/feed.dart';
import '../../screens/Pages/profile_screen.dart';
import '../../screens/Pages/search.dart';
import 'package:flutter/material.dart';

const webScreenWidth = 600;

const HomeScreenItem = [
  FeedScreen(),
  Search(),
  AddImage(),
  Favorite(),
  Profile(),
];

const primaryColor = Color.fromARGB(218, 226, 37, 24);
const secondaryColor = Color.fromARGB(255, 255, 255, 255);
const backgroundColor = Color.fromARGB(255, 18, 18, 18);
const mobileSearchColor = Color.fromARGB(255, 38, 38, 38);
const blueColor = Color.fromARGB(255, 0, 149, 246);
const mobileBackgroundColor = Color.fromARGB(255, 0, 0, 0);