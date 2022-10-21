import 'package:flutter/material.dart';

import 'main_theme.dart';

class StoryViewTheme extends StatelessWidget {
  final Widget child;

  const StoryViewTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const themeColor = ColorScheme.dark();
    final mainWhite = themeColor.onBackground;
    return Theme(
      data: mainDarkTheme().copyWith(
        iconTheme: IconThemeData(
          color: mainWhite,
          shadows: [
            Shadow(color: themeColor.shadow.withOpacity(0.5), blurRadius: 5),
          ],
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              mainWhite,
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                color: mainWhite,
                shadows: [
                  Shadow(
                      color: themeColor.shadow.withOpacity(0.5), blurRadius: 5),
                ],
              ),
            ),
          ),
        ),
        textTheme: mainDarkTheme().textTheme.copyWith(
              bodyText2: TextStyle(
                color: mainWhite,
                shadows: [
                  Shadow(
                      color: themeColor.shadow.withOpacity(0.5), blurRadius: 5),
                ],
              ),
            ),
      ),
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
