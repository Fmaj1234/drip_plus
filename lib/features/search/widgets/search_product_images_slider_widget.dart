import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/search/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchProductImagesSliderWidget extends ConsumerStatefulWidget {
  const SearchProductImagesSliderWidget({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchProductImagesSliderWidgetState();
}

class _SearchProductImagesSliderWidgetState
    extends ConsumerState<SearchProductImagesSliderWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return ref.watch(productImagesSliderListsListsProvider).when(
          data: (data) {
            return CarouselSlider.builder(
              itemCount: data.length,
              // scrollDirection: Axis.horizontal,
              options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              itemBuilder: (ctx, index, realIdx) {
                final fetchPosts = data[index];
                return GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                            image: NetworkImage(fetchPosts.thumbnail),
                            fit: BoxFit.cover,
                            opacity: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Column(
                          children: [
                            Text(
                              '#${data.indexOf(fetchPosts) + 1} Image',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: data.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () =>
                                      _controller.animateToPage(entry.key),
                                  child: Container(
                                    width: 6.0,
                                    height: 6.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(_current == entry.key
                                                ? 0.9
                                                : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
