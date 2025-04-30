import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
          'assets/images/bg.svg',
        ),
        SafeArea(child: child),
      ],
    );
  }
}
