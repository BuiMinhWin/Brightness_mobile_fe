// lib/features/gamification/presentation/pages/leaderboard_page_content.dart
import 'package:flutter/material.dart';
import '../widgets/leaderboard_item.dart';
import '../../data/models/leaderboard_user.dart';

class LeaderboardPageContent extends StatefulWidget {
  const LeaderboardPageContent({Key? key}) : super(key: key);

  @override
  State<LeaderboardPageContent> createState() => _LeaderboardPageContentState();
}

class _LeaderboardPageContentState extends State<LeaderboardPageContent> {
  final List<LeaderboardUser> _topUsers = const [
    LeaderboardUser(
      id: '2',
      name: 'Maxwell',
      points: 7120,
      rank: 1,
      avatarUrl: 'assets/images/avatars/maxwell.jpg',
    ),
    LeaderboardUser(
      id: '1',
      name: 'Camelia',
      points: 6500,
      rank: 2,
      avatarUrl: 'assets/images/avatars/camelia.jpg',
    ),
    LeaderboardUser(
      id: '3',
      name: 'Wilson',
      points: 4800,
      rank: 3,
      avatarUrl: 'assets/images/avatars/wilson.jpg',
    ),
  ];

  final List<LeaderboardUser> _otherUsers = const [
    LeaderboardUser(
      id: '4',
      name: 'Jessica Anderson',
      points: 992,
      rank: 4,
      avatarUrl: 'assets/images/avatars/jessica.jpg',
    ),
    LeaderboardUser(
      id: '5',
      name: 'Sophia Anderson',
      points: 584,
      rank: 5,
      avatarUrl: 'assets/images/avatars/sophia.jpg',
    ),
    LeaderboardUser(
      id: '6',
      name: 'Ethan Carter',
      points: 448,
      rank: 6,
      avatarUrl: 'assets/images/avatars/ethan.jpg',
    ),
    LeaderboardUser(
      id: '7',
      name: 'Liam Johnson',
      points: 580,
      rank: 7,
      avatarUrl: 'assets/images/avatars/liam.jpg',
    ),
    LeaderboardUser(
      id: '8',
      name: 'Oliver Smith',
      points: 580,
      rank: 8,
      avatarUrl: 'assets/images/avatars/oliver.jpg',
    ),
  ];

  String _selectedPeriod = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2E7D32), // Dark green
            Color(0xFF4CAF50), // Medium green
            Color(0xFF8BC34A), // Light green
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPeriodSelector(),
            _buildTopThree(),
            Expanded(
              child: _buildLeaderboardList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'Leaderboard',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildPeriodButton('Today'),
          _buildPeriodButton('This week'),
          _buildPeriodButton('All time'),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String period) {
    final isSelected = _selectedPeriod == period;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPeriod = period;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            period,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopThree() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          const Text(
            'TOP 8',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          // Podium Layout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildPodiumPosition(_topUsers[1], 2, 80), // 2nd place (left)
              _buildPodiumPosition(_topUsers[0], 1, 100), // 1st place (center)
              _buildPodiumPosition(_topUsers[2], 3, 60), // 3rd place (right)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPosition(LeaderboardUser user, int position, double height) {
    Color podiumColor;
    Color numberColor;
    
    switch (position) {
      case 1:
        podiumColor = const Color(0xFFFF6B35); // Orange for 1st
        numberColor = Colors.white;
        break;
      case 2:
        podiumColor = const Color(0xFF4CAF50); // Green for 2nd
        numberColor = Colors.white;
        break;
      case 3:
        podiumColor = const Color(0xFF8BC34A); // Light green for 3rd
        numberColor = Colors.white;
        break;
      default:
        podiumColor = Colors.grey;
        numberColor = Colors.white;
    }

    return Column(
      children: [
        // Points
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${user.points}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Avatar
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: podiumColor,
              width: 3,
            ),
          ),
          child: CircleAvatar(
            radius: 27,
            backgroundColor: Colors.grey.shade300,
            child: Text(
              user.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Podium
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: podiumColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                position.toString(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: numberColor,
                ),
              ),
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: numberColor,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardList() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _otherUsers.length,
          itemBuilder: (context, index) {
            return LeaderboardItem(
              user: _otherUsers[index],
              rank: _otherUsers[index].rank,
            );
          },
        ),
      ),
    );
  }
}