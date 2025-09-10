import 'package:brightness_mobile/core/navigation/main_navigation_controller.dart';
import 'package:flutter/material.dart';

class PricingPage extends StatelessWidget {
  const PricingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A9B8E), // Green background
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A9B8E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const MainNavigationController(),
    ),
    (route) => false,
  );
}
        ),
        title: const Text(
          'Pricing',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Free Plan Card
            _buildPlanCard(
              context: context,
              title: 'Free',
              price: null,
              isCurrentPlan: true,
              features: [
                'First aid for gym accident, emergency info',
                'Gamification',
                'Community blog access',
                'Chatbot AI (Limited)',
              ],
              buttonText: 'Your Current Plan',
              buttonColor: const Color(0xFFFF9F7A),
              onPressed: null, // Disabled since it's current plan
            ),
            
            const SizedBox(height: 20),
            
            // Premium Plan 1
            _buildPlanCard(
              context: context,
              title: '79.000',
              subtitle: '/month',
              price: 79000,
              isCurrentPlan: false,
              features: [
                'AI workout personalization (73.8% demand)',
                'Full tracking & exclusive programs',
                'Enhanced chatbot, no ads',
                'Expert content access',
                'Included all feature from free tier',
                'Long-term savings',
              ],
              buttonText: 'Order Now',
              buttonColor: const Color(0xFFFF9F7A),
              onPressed: () => _handlePurchase(context, 'premium1'),
            ),
            
            const SizedBox(height: 20),
            
            // Premium Plan 2
            _buildPlanCard(
              context: context,
              title: '599.000',
              subtitle: '/month',
              price: 599000,
              isCurrentPlan: false,
              features: [
                'AI workout personalization (73.8% demand)',
                'Full tracking & exclusive programs',
                'Enhanced chatbot, no ads',
                'Expert content access',
                'Included all feature from free tier',
                'Long-term savings',
              ],
              buttonText: 'Order Now',
              buttonColor: const Color(0xFFFF9F7A),
              onPressed: () => _handlePurchase(context, 'premium2'),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required String title,
    String? subtitle,
    int? price,
    required bool isCurrentPlan,
    required List<String> features,
    required String buttonText,
    required Color buttonColor,
    VoidCallback? onPressed,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
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
                    subtitle,
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

  void _handlePurchase(BuildContext context, String planType) {
    // Show purchase dialog or navigate to payment
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Purchase Plan'),
          content: Text('You selected the $planType plan. This would normally integrate with your payment system.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment integration would be implemented here'),
                    backgroundColor: Color(0xFF4A9B8E),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A9B8E),
              ),
              child: const Text('Proceed'),
            ),
          ],
        );
      },
    );
  }
}