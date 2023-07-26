import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:drip_plus/features/shopping/screens/product_item_screen.dart';

class SpotlightsItemsWidget extends StatelessWidget {
  
  List movies = [
    "Thor Love And Thunder",
    "Shazam 2",
    "Dune",
    "Black Panther 2",
    "Black Adam",
    "bg",
    "Avatar 2",
    "GOTG Vol 3",
    "Aquaman 2",
    "Ant Man 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Spotlights",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
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
                child: const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 12, top: 8),
                height: 200,
                child: ListView.builder(
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductItemScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            // city1. jpg
                            image: AssetImage("images/${movies[index]}.jpg"),
                            fit: BoxFit.cover,
                            opacity: 0.7,
                          ),
                        ),
                        child: Column(
                          children: [
                           const Spacer(),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                movies[index],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "City Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
