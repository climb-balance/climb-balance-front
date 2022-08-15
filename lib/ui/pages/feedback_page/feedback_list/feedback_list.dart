import 'package:carousel_slider/carousel_slider.dart';
import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';

class FeedbackList extends StatelessWidget {
  const FeedbackList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                FeedbackCard(
                  story: getRandomStory(),
                ),
              ],
              options: CarouselOptions(
                viewportFraction: 1.0,
                aspectRatio: 9 / 16,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BotNavigationBar(
        currentIdx: 3,
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final Story story;

  const FeedbackCard({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(
          children: [
            Image.network(story.thumbnailUrl),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(),
            )
          ],
        ),
      ),
    );
  }
}
