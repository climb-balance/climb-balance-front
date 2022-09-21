import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final int numOfStar;

  const Stars({Key? key, this.numOfStar = 2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: numOfStar / 2,
      itemBuilder: (context, index) => StarIcon(),
      itemCount: 5,
      itemSize: 20,
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star,
      color: Colors.amber,
    );
  }
}

class StarsPicker extends StatelessWidget {
  const StarsPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 0.5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => StarIcon(),
      onRatingUpdate: (rating) {},
      itemSize: 30,
    );
  }
}
