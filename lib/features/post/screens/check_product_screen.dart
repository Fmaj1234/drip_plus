import 'package:drip_plus/features/post/productWidgets/existing_products_items.dart';
import 'package:drip_plus/features/post/widgets/general_post_products_item.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CheckProductScreen extends ConsumerStatefulWidget {
  const CheckProductScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckProductScreenState();
}

class _CheckProductScreenState extends ConsumerState<CheckProductScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        Text(
                          "Add Products",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ExistingProductsItems(),
                  const SizedBox(height: 12),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8, right: 12, bottom: 12),
                    child: Container(
                      height: 40,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Pallete.anotherGreyColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 40,
                            width: 200,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Search the music",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const TabBar(
                    isScrollable: true,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black87,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    tabs: [
                      Tab(text: "Musics"),
                      Tab(text: "Playlists"),
                      Tab(text: "Favourite"),
                      Tab(text: "New"),
                      Tab(text: "Collections"),
                      Tab(text: "Trending"),
                    ],
                  ),
                  Flexible(
                    flex: 1,
                    child: TabBarView(
                      children: [
                        GeneralPostProductsItem(),
                        GeneralPostProductsItem(),
                        GeneralPostProductsItem(),
                        GeneralPostProductsItem(),
                        GeneralPostProductsItem(),
                        GeneralPostProductsItem(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
