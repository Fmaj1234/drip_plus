import 'package:flutter/material.dart';

class LowerPostSectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          // isScrollable: true,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black26,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          tabs: [
            Tab(
              icon: Icon(Icons.grid_view_rounded, size: 30),
            ),
            Tab(
              icon: Icon(Icons.shopping_bag, size: 30),
            ),
            Tab(
              icon: Icon(Icons.bookmark, size: 30),
            ),
            Tab(
              icon: Icon(Icons.groups_sharp, size: 30),
            ),
            Tab(
              icon: Icon(Icons.favorite, size: 30),
            ),
          ],
        ),
        Flexible(
          flex: 1,
          child: TabBarView(
            children: [
              // ProfilePostWidget(),
              // ProfilePostWidget(),
              // ProfilePostWidget(),
              // ProfilePostWidget(),
              // ProfilePostWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
