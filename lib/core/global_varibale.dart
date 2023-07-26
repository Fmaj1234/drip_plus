import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/features/profile/screens/general_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:drip_plus/features/post/screens/add_post_screen.dart';
import 'package:drip_plus/features/home/screens/feed_video_screen.dart';
import 'package:drip_plus/features/profile/screens/profile_screen.dart';
import 'package:drip_plus/features/search/screens/search_screen.dart';
import 'package:drip_plus/features/notification/screens/notification_screen.dart';

List pages = [
  const FeedVideoScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const NotificationScreen(),
  const ProfileScreen(),
];

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
