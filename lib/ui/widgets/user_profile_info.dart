import 'package:flutter/material.dart';

import '../../models/user.dart';

class TopProfileInfo extends StatelessWidget {
  final UserProfile profile;

  const TopProfileInfo({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            foregroundImage: NetworkImage(profile.profileImagePath),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${profile.nickName}#${profile.uniqueCode}',
                style: theme.textTheme.headline6,
              ),
              const Text('계정 등급 : 1')
            ],
          )
        ],
      ),
    );
  }
}

class BottomUserProfile extends StatefulWidget {
  final UserProfile userProfile;
  final String description;

  const BottomUserProfile(
      {Key? key, required this.userProfile, required this.description})
      : super(key: key);

  @override
  State<BottomUserProfile> createState() => _BottomUserProfileState();
}

class _BottomUserProfileState extends State<BottomUserProfile> {
  bool openFeedBack = false;

  void toggleOpenFeedBack() {
    setState(() {
      openFeedBack = !openFeedBack;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
                  Image.network(widget.userProfile.profileImagePath).image,
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
                    Text(widget.userProfile.nickName),
                    Text('#${widget.userProfile.uniqueCode.toString()}'),
                  ],
                ),
                Text(
                  '${widget.userProfile.height}cm/${widget.userProfile.weight}kg',
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: toggleOpenFeedBack,
              child: openFeedBack
                  ? Icon(Icons.arrow_left)
                  : Icon(Icons.arrow_right),
            ),
            if (openFeedBack)
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.adb),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.emoji_people),
                    onPressed: () {},
                  ),
                ],
              ),
          ],
        )
      ],
    );
  }
}