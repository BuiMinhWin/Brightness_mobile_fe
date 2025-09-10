import 'package:flutter/material.dart';
import 'fox_mascot.dart';

class FoxMascotBox extends StatelessWidget {
  final double size;
  final double right;
  final double bottom;

  const FoxMascotBox({
    super.key,
    required this.size,
    this.right = 0,
    this.bottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: right, bottom: bottom),
        child: SizedBox(
          width: size,
          height: size,
          child: FoxMascot(width: size, height: size),
        ),
      ),
    );
  }
}