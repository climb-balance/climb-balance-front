import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageBanner extends StatefulWidget {
  const ImageBanner({Key? key}) : super(key: key);

  @override
  State<ImageBanner> createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  static const double _height = 200;
  final List<String> images = [
    'https://www.navercorp.com/navercorp_/promotion/tvAds/2021/20210803115600_1.png',
    'https://img.freepik.com/free-vector/abstract-website-banner-with-modern-shapes_1361-1738.jpg?w=2000',
    'https://img.freepik.com/free-vector/modern-website-banner-template-with-abstract-shapes_1361-3311.jpg?w=2000'
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        CarouselSlider(
          items: images
              .map(
                (image) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: _height,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(image),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: _height,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, _) {
              setState(() {
                current = index;
              });
            },
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: images.map(
                (image) {
                  int index = images.indexOf(image);
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.surface,
                      ),
                      shape: BoxShape.circle,
                      color: current == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
