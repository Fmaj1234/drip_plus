import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImagesSliderWidget extends StatelessWidget {
  List movies = [
    "Ant Man 3",
    "Aquaman 2",
    "GOTG Vol 3",
    "Shazam 2",
  ];
  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Colors.redAccent,
      indicatorBackgroundColor: Colors.white,
      width: double.infinity,
      height: 180,
      autoPlayInterval: 3000,
      indicatorRadius: 3,
      isLoop: true,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming1.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming2.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming3.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming4.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming1.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming2.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming3.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage(
                "images/upcoming4.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
