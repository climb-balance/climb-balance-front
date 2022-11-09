import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  const GradientIcon(
      {required this.icon,
      required this.size,
      required this.gradient,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}

class ToggleIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final bool isEnable;
  final String detail;

  const ToggleIcon({
    Key? key,
    required this.icon,
    this.iconSize = 35,
    required this.isEnable,
    this.detail = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      children: [
        Stack(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: isEnable ? color.primary : color.onBackground,
            ),
          ],
        ),
        Text(detail),
      ],
    );
  }
}

class ColIconDetail extends StatelessWidget {
  final IconData icon;
  final String detail;
  final double iconSize;

  const ColIconDetail({
    Key? key,
    required this.icon,
    this.detail = '',
    this.iconSize = 35.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: iconSize,
        ),
        Text(detail),
      ],
    );
  }
}

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/back.svg',
    );
  }
}
