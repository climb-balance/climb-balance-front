import 'package:flutter/material.dart';

import '../../common/components/logo.dart';

class AuthLogos extends StatelessWidget {
  const AuthLogos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          SizedBox(
            height: 50,
          ),
          Logo(),
          SizedBox(
            height: 10,
          ),
          LogoText(),
        ],
      ),
    );
  }
}
