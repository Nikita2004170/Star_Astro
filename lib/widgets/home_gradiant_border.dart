import 'package:flutter/material.dart';

class HomeGradiantBorder extends StatelessWidget {
  const HomeGradiantBorder({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
  });

  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(51, 206, 255, 0.85),
            Color.fromRGBO(214, 51, 255, 0),
          ],
          stops: [0.0, 0.5628],
        ),
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.15),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: child,
      ),
    );
  }
}
