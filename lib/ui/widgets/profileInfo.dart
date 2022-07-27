import 'package:flutter/material.dart';

import '../../models/user.dart';

class ProfileInfo extends StatelessWidget {
  final UserProfile profile;

  const ProfileInfo({Key? key, required this.profile}) : super(key: key);

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
