import 'package:drip_plus/features/shopping/screens/search_shopping_screen.dart';
import 'package:drip_plus/features/shopping/widgets/categories_widget.dart';
import 'package:drip_plus/features/shopping/widgets/general_items_widget.dart';
import 'package:drip_plus/features/shopping/widgets/product_image_slider_widget.dart';
import 'package:drip_plus/features/shopping/widgets/single_slide_widget.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatelessWidget {
  static const routeName = '/lshopping-screen';
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchShoppingScreen(),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
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
      ),
      body: SafeArea(
        child: Material(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 4),
                    ProductImagesSliderWidget(),
                    const SizedBox(height: 8),
                    CategoriesWidget(),
                    const SizedBox(height: 15),
                    SingleSlideWidget(),
                    const SizedBox(height: 16),
                    GeneralItemsWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
