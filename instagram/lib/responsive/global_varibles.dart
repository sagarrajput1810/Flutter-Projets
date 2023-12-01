import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post_screen.dart';
import 'package:instagram/screens/feed_screen.dart';
const webScreensize = 600;

const homeScreenItems = [
  FeedScreen(),
  Center(child: Text("search")),
  AddPostScreen(),
  Center(child: Text("favrouite")),
  Center(child: Text("person"))
];