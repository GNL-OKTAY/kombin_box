import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reesponsive/mobile_screen_layout_ex.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/select_photo_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const SelectPhoto(),
  const NewWidget(clickedCentreFAB: false),
  //const Text('notifications'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
