import 'package:brightness_mobile/core/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/bottom_navbar.dart';


class YoursPage extends StatefulWidget {
  const YoursPage({Key? key}) : super(key: key);

  @override
  State<YoursPage> createState() => _YoursPageState();
}

class _YoursPageState extends State<YoursPage> {
  int _currentNavIndex = 2; // Yours tab is active

  final List<DietPlan> _dietPlans = [
    DietPlan(id: '1', progress: 0.45),
    DietPlan(id: '2', progress: 0.65),
    DietPlan(id: '3', progress: 0.20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4CAF50), // Dark green
              Color(0xFF8BC34A), // Medium green
              Color(0xFFCDDC39), // Yellow green
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Yours',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
        itemCount: _dietPlans.length,
        itemBuilder: (context, index) {
          return _buildDietCard(_dietPlans[index]);
        },
      ),
    );
  }

  Widget _buildDietCard(DietPlan dietPlan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _onDietCardTap(dietPlan),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            // Diet Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F8E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.restaurant_menu,
                color: Color(0xFF4CAF50),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HEALTHY DIET',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Progress Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: dietPlan.progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(dietPlan.progress * 100).round()}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
    
    // Handle navigation to different pages
    switch (index) {
      case 0:
        // Navigate to Home
        break;
      case 1:
        // Navigate to Event
        break;
      case 2:
        // Already on Yours page
        break;
      case 3:
        // Navigate to Video
        break;
      case 4:
        // Navigate to Leaderboard
        break;
    }
  }

  void _onDietCardTap(DietPlan dietPlan) {
    // Handle diet card tap
    print('Tapped on diet plan: ${dietPlan.id}');
      // Navigate to diet plan details
      // Navigator.push(context, MaterialPageRoute(
      //   builder: (_) => DietPlanDetailPage(dietPlan: dietPlan),
      // ));
  }
}

// Data Model
class DietPlan {
  final String id;
  final double progress; // 0.0 to 1.0

  const DietPlan({
    required this.id,
    required this.progress,
  });
}

// Example of how to use the navbar in other pages
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNavIndex = 0; // Home tab is active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home Page Content'),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          // Handle navigation
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const YoursPage()),
            );
          }
        },
      ),
    );
  }
}