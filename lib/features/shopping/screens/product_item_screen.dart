import 'package:badges/badges.dart';
import 'package:drip_plus/features/shopping/widgets/items_product_images_slider_widget.dart';
import 'package:drip_plus/features/shopping/widgets/more_from_this_shop_widget.dart';
import 'package:drip_plus/features/shopping/widgets/product_details_widget.dart';
import 'package:drip_plus/features/shopping/widgets/product_item_bottom_nav_bar.dart';
import 'package:drip_plus/features/shopping/widgets/similar_product_widget.dart';
import 'package:flutter/material.dart';

class ProductItemScreen extends StatelessWidget {
  const ProductItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Product Item",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  // add Badge to widget
                  child:  Icon(
                      Icons.shopping_bag_outlined,
                      size: 24,
                      color: Colors.black,
                    
                  ),
                ),
                SizedBox(width: 24),
                Icon(
                  Icons.more_vert,
                  size: 24,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ItemsProductImagesSliderWidgets(),
                    ProductDetailsWidget(),
                    SimilarProductWidget(),
                    const SizedBox(height: 12),
                    MoreFromThisShopWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductItemBottomNavBar(),
    );
  }
}
