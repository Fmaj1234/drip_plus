import 'package:drip_plus/core/core.dart';
import 'package:drip_plus/features/home/widgets/comment_home_feed_bottom_sheet.dart';
import 'package:drip_plus/features/post/widgets/custom_post_bottom_sheet.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bottomSheetPostScreen(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const CustomPostBottomSheet();
      },
    );
  }

  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          if (idx == 2) {
            bottomSheetPostScreen(context);
          } else {
            setState(() {
              pageIdx = idx;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: pageIdx == 0 ? Pallete.blackColor : Pallete.whiteColor,
        selectedItemColor:
            pageIdx == 0 ? Pallete.whiteColor : Pallete.blueColor,
        unselectedItemColor:
            pageIdx == 0 ? Pallete.greyColor : Pallete.blackColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: '',
          ),
        ],
      ),
      body: pages[pageIdx],
    );
  }
}
