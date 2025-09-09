import 'package:flutter/material.dart';

class FoxMascot extends StatelessWidget {
  final double width;
  final double height;

  const FoxMascot({super.key, this.width = 210, this.height = 210});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/home_fox.png',
        fit: BoxFit.contain,
      ),
    );
  }
}

