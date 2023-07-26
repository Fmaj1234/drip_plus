import 'package:flutter/material.dart';
import 'package:drip_plus/theme/theme.dart';

class CategoriesWidget extends StatelessWidget {
  List formats = [
    "Branded",
    "Photography",
    "Movies",
    "Tech",
    "Branded",
    "Photography",
    "Movies",
    "Tech",
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 4),
        child: Row(
          children: [
            for (int i = 0; i < 6; i++)
              Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Pallete.anotherGreyColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Text(
                  formats[i],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
