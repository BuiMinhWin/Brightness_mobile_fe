import 'package:brightness_mobile/features/pricing/presentation/pages/pricing_page.dart';
import 'package:brightness_mobile/features/yours/data/models/yours.dart';
import 'package:flutter/material.dart';
import '../widgets/diet_plan_card.dart';
import 'event_tracking_page.dart';
 // Add this import for the pricing page

class YoursPageContent extends StatelessWidget {
  const YoursPageContent({Key? key}) : super(key: key);

  static const List<DietPlanModel> dietPlans = [
    DietPlanModel(
      id: '1',
      title: 'HEALTHY DIET',
      progress: 0.45,
    ),
    DietPlanModel(
      id: '2',
      title: 'MORNING YOGA',
      progress: 0.65,
    ),
    DietPlanModel(
      id: '3',
      title: 'CARDIO BLAST',
      progress: 0.20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2E7D32),
            Color(0xFF4CAF50),
            Color(0xFF8BC34A),
            Color(0xFFCDDC39),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            buildHeader(context), // Pass context to header
            Expanded(
              key: const Key('diet_plans_expanded'),
              child: buildDietPlansList(context),
            ),
            buildPricingButton(context), // Add pricing button at bottom
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Yours',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          // Alternative: Add pricing button in header
          IconButton(
            onPressed: () => navigateToPricing(context),
            icon: const Icon(
              Icons.attach_money,
              color: Colors.white,
              size: 28,
            ),
            tooltip: 'View Pricing',
          ),
        ],
      ),
    );
  }

  Widget buildDietPlansList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
        itemCount: dietPlans.length,
        itemBuilder: (context, index) {
          return DietPlanCard(
            dietPlan: dietPlans[index],
            onTap: () => navigateToEventTracking(context, dietPlans[index]),
          );
        },
      ),
    );
  }

  Widget buildPricingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () => navigateToPricing(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF2E7D32),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 24),
              SizedBox(width: 8),
              Text('View Pricing Plans'),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToEventTracking(BuildContext context, DietPlanModel dietPlan) {
    print('Navigating to event tracking for: ${dietPlan.title}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventTrackingPage(dietPlan: dietPlan),
        settings: RouteSettings(name: '/event-tracking/${dietPlan.id}'),
      ),
    );
  }

  void navigateToPricing(BuildContext context) {
    Navigator.pushNamed(context, '/pricing');
  }
}