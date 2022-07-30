import 'package:carousel_slider/carousel_slider.dart';
import 'package:climb_balance/ui/widgets/safearea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Icon(Icons.balance), Text('클라임밸런스')],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [ImageBanner()],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 0),
    );
  }
}

class ImageBanner extends StatefulWidget {
  const ImageBanner({Key? key}) : super(key: key);

  @override
  State<ImageBanner> createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  static const double _height = 200;
  final List<String> images = [
    'https://www.navercorp.com/navercorp_/promotion/tvAds/2021/20210803115600_1.png',
    'https://www.navercorp.com/navercorp_/promotion/tvAds/2021/20210803115600_1.png',
    'https://www.navercorp.com/navercorp_/promotion/tvAds/2021/20210803115600_1.png'
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            viewportFraction: 1,
            onPageChanged: (index, _) {
              setState(() {
                current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.map(
            (image) {
              int index = images.indexOf(image);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
