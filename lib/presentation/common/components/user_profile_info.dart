import 'package:flutter/material.dart';

import '../../../domain/model/user.dart';

class TopProfileInfo extends StatelessWidget {
  final User user;

  const TopProfileInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: theme.cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                  image: NetworkImage(user.profileImage),
                  fit: BoxFit.cover,
                ),
                boxShadow: kElevationToShadow[4],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.nickname,
                      style: theme.textTheme.headline5,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Text(user.description),
              ],
            ),
          ],
        ),
      ),
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
