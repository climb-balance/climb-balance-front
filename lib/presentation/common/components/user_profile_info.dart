import 'package:flutter/material.dart';

import '../../../domain/model/user.dart';
import 'avatar_picker.dart';

class TopProfileInfo extends StatelessWidget {
  final User user;

  const TopProfileInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        FlexAvatar(imagePath: user.profileImage),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.nickname,
              style: theme.textTheme.headline5,
            ),
            Text(user.description),
            Text('${user.height}cm | ${user.weight}kg'),
          ],
        ),
      ],
    );
  }
}

class BottomUserProfile extends StatelessWidget {
  final User user;
  final String description;

  const BottomUserProfile(
      {Key? key, required this.user, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(user.profileImage).image,
          radius: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.nickname,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              '${user.height}cm | ${user.weight}kg',
            ),
            SizedBox(
              height: 4,
            ),
            Text(description),
          ],
        ),
      ],
    );
  }
}
