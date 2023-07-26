import 'package:drip_plus/features/home/screens/feed_video_screen.dart';
import 'package:drip_plus/features/notification/screens/notification_screen.dart';
import 'package:drip_plus/features/post/screens/add_post_screen.dart';
import 'package:drip_plus/features/profile/screens/profile_screen.dart';
import 'package:drip_plus/features/search/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AssetsConstants {
  static const String _svgsPath = 'assets/svgs';
  static const String twitterLogo = '$_svgsPath/twitter_logo.svg';
  static const String homeFilledIcon = '$_svgsPath/home_filled.svg';
  static const String homeOutlinedIcon = '$_svgsPath/home_outlined.svg';
  static const String notifFilledIcon = '$_svgsPath/notif_filled.svg';
  static const String notifOutlinedIcon = '$_svgsPath/notif_outlined.svg';
  static const String searchIcon = '$_svgsPath/search.svg';
  static const String gifIcon = '$_svgsPath/gif.svg';
  static const String emojiIcon = '$_svgsPath/emoji.svg';
  static const String galleryIcon = '$_svgsPath/gallery.svg';
  static const String commentIcon = '$_svgsPath/comment.svg';
  static const String retweetIcon = '$_svgsPath/retweet.svg';
  static const String likeOutlinedIcon = '$_svgsPath/like_outlined.svg';
  static const String likeFilledIcon = '$_svgsPath/like_filled.svg';
  static const String viewsIcon = '$_svgsPath/views.svg';
  static const String verifiedIcon = '$_svgsPath/verified.svg';

  static const logoPath = 'assets/images/logo.png';
  static const loginEmotePath = 'assets/images/loginEmote.png';
  static const googlePath = 'assets/images/google.png';
  static const facebookPath = 'assets/images/facebook.png';
  static const twitterPath = 'assets/images/twitter.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';


  static const List<Widget> bottomTabBarPages = [
    FeedVideoScreen(),
    SearchScreen(),
    AddPostScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  static const IconData up =
      IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData down =
      IconData(0xe801, fontFamily: 'MyFlutterApp', fontPackage: null);

  static const awardsPath = 'assets/images/awards';

  static const awards = {
    'awesomeAns': '${AssetsConstants.awardsPath}/awesomeanswer.png',
    'gold': '${AssetsConstants.awardsPath}/gold.png',
    'platinum': '${AssetsConstants.awardsPath}/platinum.png',
    'helpful': '${AssetsConstants.awardsPath}/helpful.png',
    'plusone': '${AssetsConstants.awardsPath}/plusone.png',
    'rocket': '${AssetsConstants.awardsPath}/rocket.png',
    'thankyou': '${AssetsConstants.awardsPath}/thankyou.png',
    'til': '${AssetsConstants.awardsPath}/til.png',
  };
}
