import 'package:drip_plus/features/discover/screens/search_discover_screen.dart';
import 'package:drip_plus/features/discover/widgets/discover_item_categories_widget.dart';
import 'package:drip_plus/features/discover/widgets/notable_items_widget.dart';
import 'package:drip_plus/features/discover/widgets/spotlights_items_widget.dart';
import 'package:drip_plus/features/discover/widgets/valued_items_widget.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  static const routeName = '/discover-screen';
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchDiscoverScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Pallete.anotherGreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.search,
                            size: 24,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Search here...",
                            style: TextStyle(color: Colors.black54, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DiscoverItemCategoriesWidget(),
                  const SizedBox(height: 8),
                  SpotlightsItemsWidget(),
                  const SizedBox(height: 16),
                  NotableItemsWidget(),
                  const SizedBox(height: 16),
                  ValuedItemsWidget(),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
