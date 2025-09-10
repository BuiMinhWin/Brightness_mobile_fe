import 'package:flutter/material.dart';

class AiAvatar extends StatelessWidget {
  final double size;
  final bool isOnline;

  const AiAvatar({
    super.key,
    this.size = 32,
    this.isOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFF9800),
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              '🦊',
              style: TextStyle(fontSize: size * 0.6),
            ),
          ),
          if (isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size * 0.3,
                height: size * 0.3,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(size * 0.15),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
