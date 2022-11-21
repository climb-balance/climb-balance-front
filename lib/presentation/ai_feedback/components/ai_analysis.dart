import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'bad_analysis.dart';

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({
    Key? key,
    required this.storyId,
    required this.badPoints,
  }) : super(key: key);

  final int storyId;
  final List<double> badPoints;

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  CarouselController carouselController = CarouselController();
  int curPage = 0;

  void _nextPage() {
    if (curPage < widget.badPoints.length - 1) {
      curPage += 1;
      carouselController.nextPage();
      setState(() {});
    }
  }

  void _prevPage() {
    if (curPage > 0) {
      curPage -= 1;
      carouselController.previousPage();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canNext = curPage < widget.badPoints.length - 1;
    final bool canPrev = curPage > 0;
    final color = Theme.of(context).colorScheme;

    if (widget.badPoints.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('잘못된 구간이 없습니다.'),
            Text('완벽하시네요!!'),
          ],
        ),
      );
    }
    return Row(
      children: [
        IconButton(
          onPressed: _prevPage,
          color: canPrev ? color.onSurface : Colors.transparent,
          icon: const Icon(Icons.navigate_before_rounded),
        ),
        Expanded(
          child: CarouselSlider(
            items: [
              for (int i = 0; i < widget.badPoints.length; i++)
                BadAnalysis(
                  storyId: widget.storyId,
                  badPoint: widget.badPoints[i],
                  num: i + 1,
                ),
            ],
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 9 / 16,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              scrollPhysics: const NeverScrollableScrollPhysics(),
            ),
            carouselController: carouselController,
          ),
        ),
        IconButton(
          color: canNext ? color.onSurface : Colors.transparent,
          onPressed: _nextPage,
          icon: const Icon(Icons.navigate_next_rounded),
        ),
      ],
    );
  }
}
