import 'package:flutter/material.dart';

class FoxMascot extends StatelessWidget {
  final double width;
  final double height;

  // Tăng kích thước mặc định từ 100x110 lên 150x165
  const FoxMascot({super.key, this.width = 100, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(
        'assets/images/home_fox.png',
        fit: BoxFit.contain, // Đảm bảo hình ảnh được scale đúng tỷ lệ
      ),
    );
  }
}
