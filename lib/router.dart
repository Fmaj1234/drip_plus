// loggedOut
// loggedIn

import 'package:drip_plus/features/auth/screens/login_screen.dart';
import 'package:drip_plus/features/auth/screens/signup_screen.dart';
import 'package:drip_plus/features/auth/screens/welcome_first_user_screen.dart';
import 'package:drip_plus/features/auth/screens/welcome_screen.dart';
import 'package:drip_plus/features/chat/screens/chat_screen.dart';
import 'package:drip_plus/features/chat/screens/create_group_screen.dart';
import 'package:drip_plus/features/chat/screens/mobile_chat_screen.dart';
import 'package:drip_plus/features/discover/screens/discover_screen.dart';
import 'package:drip_plus/features/home/screens/feed_value_display_screen.dart';
import 'package:drip_plus/features/home/screens/feed_video_screen.dart';
import 'package:drip_plus/features/home/screens/followers_screen.dart';
import 'package:drip_plus/features/home/screens/post_video_screen.dart';
import 'package:drip_plus/features/notification/screens/notification_screen.dart';
import 'package:drip_plus/features/options/screens/options_screen.dart';
import 'package:drip_plus/features/post/screens/add_post_screen.dart';
import 'package:drip_plus/features/post/screens/check_product_screen.dart';
import 'package:drip_plus/features/profile/screens/edit_profile_screen.dart';
import 'package:drip_plus/features/profile/screens/general_profile_screen.dart';
import 'package:drip_plus/features/profile/screens/profile_screen.dart';
import 'package:drip_plus/features/search/screens/search_screen.dart';
import 'package:drip_plus/features/shopping/screens/shopping_screen.dart';
import 'package:drip_plus/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: WelcomeFirstUserScreen()),
});

final loggedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: HomeScreen()),
    '/profile': (routeData) => const MaterialPage(
          child: ProfileScreen(),
        ),
    '/general-profile/:uid': (routeData) => MaterialPage(
          child: GeneralProfileScreen(
            uid: routeData.pathParameters['uid']!,
          ),
        ),
    '/add-post': (routeData) => const MaterialPage(
          child: AddPostScreen(),
        ),
    '/login': (_) => const MaterialPage(
          child: LoginScreen(),
        ),
    '/signup': (routeData) => const MaterialPage(
          child: SignupScreen(),
        ),
    '/search': (routeData) => const MaterialPage(
          child: SearchScreen(),
        ),
    '/notification': (routeData) => const MaterialPage(
          child: NotificationScreen(),
        ),
    '/chat': (routeData) => const MaterialPage(
          child: ChatScreen(),
        ),
    '/discover': (routeData) => const MaterialPage(
          child: DiscoverScreen(),
        ),
    '/followers': (routeData) => const MaterialPage(
          child: FollowersScreen(),
        ),
    '/shopping': (routeData) => const MaterialPage(
          child: ShoppingScreen(),
        ),
    '/feed-video': (routeData) => const MaterialPage(
          child: FeedVideoScreen(),
        ),
    '/edit-profile/:uid': (routeData) => MaterialPage(
          child: EditProfileScreen(
            uid: routeData.pathParameters['uid']!,
          ),
        ),
    '/option-screen/:uid': (routeData) => MaterialPage(
          child: OptionsScreen(
            uid: routeData.pathParameters['uid']!,
          ),
        ),
    '/feed-value-display/:postId': (routeData) => MaterialPage(
          child: FeedValueDisplayScreen(
            postId: routeData.pathParameters['postId']!,
          ),
        ),
    '/post-video/:postId': (routeData) => MaterialPage(
          child: PostVideoScreen(
            postId: routeData.pathParameters['postId']!,
          ),
        ),
    '/createGroup': (routeData) => const MaterialPage(
          child: CreateGroupScreen(),
        ),
    '/check-product': (routeData) => const MaterialPage(
          child: CheckProductScreen(),
        ),
  },
);
