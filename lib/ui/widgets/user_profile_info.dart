import 'dart:ui';

import 'package:flutter/material.dart';

import '../../models/user.dart';

class TopProfileInfo extends StatelessWidget {
  final UserProfile profile;

  const TopProfileInfo({Key? key, required this.profile}) : super(key: key);

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
                  image: NetworkImage(profile.profileImagePath),
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
                      '${profile.nickName}#${profile.uniqueCode}',
                      style: theme.textTheme.headline5,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '계정 등급 : 1',
                      style: theme.textTheme.subtitle1,
                    ),
                  ],
                ),
                Text('${profile.introduce}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomUserProfile extends StatelessWidget {
  final UserProfile userProfile;
  final String description;

  const BottomUserProfile(
      {Key? key, required this.userProfile, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(userProfile.profileImagePath).image,
          radius: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(userProfile.nickName),
                Text('#${userProfile.uniqueCode.toString()}'),
              ],
            ),
            Text(
              '${userProfile.height}cm/${userProfile.weight}kg',
              style: theme.textTheme.bodyText2?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
