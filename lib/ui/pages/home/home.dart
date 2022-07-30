import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/ui/widgets/story.dart';
import 'package:flutter/material.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:flutter/physics.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Icon(Icons.balance), Text('클라임밸런스')],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Card(child: ImageBanner()),
            MainStatistics(),
            // TODO stack으로 옮겨야함.
            StoryViewDrag(),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 0),
    );
  }
}

class StoryViewDrag extends StatefulWidget {
  const StoryViewDrag({Key? key}) : super(key: key);

  @override
  State<StoryViewDrag> createState() => _StoryViewDragState();
}

class _StoryViewDragState extends State<StoryViewDrag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.bottomCenter;
  late Animation<Alignment> _animation;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.bottomCenter,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(0, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Align(
        alignment: _dragAlignment,
        child: GestureDetector(
          onVerticalDragDown: (details) {
            _controller.stop();
          },
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 0 && _dragAlignment.y >= 1.0) {
              return;
            } else if (_dragAlignment.y < 0.3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryView(
                    story: getRandomStory(),
                  ),
                ),
              );
            }
            setState(() {
              _dragAlignment += Alignment(
                0,
                details.delta.dy / (size.height / 2),
              );
            });
          },
          onVerticalDragEnd: (details) {
            _runAnimation(details.velocity.pixelsPerSecond, size);
          },
          child: const Icon(
            Icons.keyboard_double_arrow_up,
            size: 50,
          ),
        ),
      ),
    );
  }
}

class MainStatistics extends StatelessWidget {
  const MainStatistics({Key? key}) : super(key: key);

  List<int> loadDatas() {
    Random random = Random();
    List<int> result = [];
    for (int i = 0; i < 30; i++) {
      result.add(random.nextInt(10));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2 - 30,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: HeatMap(
              datas: loadDatas(),
            ),
          ),
          Expanded(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('현재까지'),
                  Text(
                    '50일',
                    style: theme.textTheme.headline2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeatMap extends StatelessWidget {
  final List<int> datas;

  const HeatMap({Key? key, required this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridView.count(
        padding: const EdgeInsets.all(5),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 6,
        children: datas.map((data) => HeatMapSquare(data: data)).toList(),
      ),
    );
  }
}

class HeatMapSquare extends StatefulWidget {
  final int data;
  static const maxValue = 11;

  const HeatMapSquare({Key? key, required this.data}) : super(key: key);

  @override
  State<HeatMapSquare> createState() => _HeatMapSquareState();
}

class _HeatMapSquareState extends State<HeatMapSquare> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _show = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: theme.colorScheme.primary.withOpacity(
            min((widget.data / HeatMapSquare.maxValue), 1),
          ),
        ),
        child: AnimatedOpacity(
          opacity: _show ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          child: Center(
            child: Text(
              widget.data.toString(),
            ),
          ),
          onEnd: () {
            setState(() {
              _show = false;
            });
          },
        ),
      ),
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
