import 'package:movie1/Theme/dark_theme.dart';
import 'package:flutter/material.dart';

class GradientColor extends StatelessWidget {
  const GradientColor({
    super.key,
    required this.height,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(stops: const [
          0.1,
          0.3,
          0.5,
          0.7,
          0.9
        ], colors: [
          darkTheme.scaffoldBackgroundColor.withOpacity(0.01),
          darkTheme.scaffoldBackgroundColor.withOpacity(0.6),
          darkTheme.scaffoldBackgroundColor.withOpacity(0.9),
          darkTheme.scaffoldBackgroundColor.withOpacity(0.99),
          darkTheme.scaffoldBackgroundColor
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
    );
  }
}
