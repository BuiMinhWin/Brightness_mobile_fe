import 'package:flutter/material.dart';

class PricingCardWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int? price;
  final List<String> features;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? onPressed;
  final bool isPopular;

  const PricingCardWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.price,
    required this.features,
    required this.buttonText,
    required this.buttonColor,
    this.onPressed,
    this.isPopular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isPopular 
            ? Border.all(color: const Color(0xFF4A9B8E), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              top: -1,
              left: 20,
              right: 20,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A9B8E),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Most Popular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(isPopular ? 28 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price
                if (price == null)
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                
                const SizedBox(height: 24),
                
                // Features List
                ...features.map((feature) => _buildFeatureItem(feature)),
                
                const SizedBox(height: 24),
                
                // Action Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      disabledBackgroundColor: buttonColor.withOpacity(0.7),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: const BoxDecoration(
              color: Color(0xFFB794F6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 12,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4A5568),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}