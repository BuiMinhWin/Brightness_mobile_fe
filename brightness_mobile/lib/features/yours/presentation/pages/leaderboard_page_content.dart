// lib/features/gamification/presentation/pages/leaderboard_page_content.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/leaderboard_item.dart';
import '../../data/models/leaderboard_user.dart';

class LeaderboardPageContent extends StatefulWidget {
  const LeaderboardPageContent({super.key});

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
        gradient: AppColors.customGradientVertical, // ✅ dùng gradient system
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
    return  Padding(
      padding: EdgeInsets.all(AppTheme.spacingXL),
      child: Text(
        'Leaderboard',
        style: AppTextStyles.h1.copyWith(color: AppColors.white), // ✅
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXL,
        vertical: AppTheme.spacingS,
      ),
      padding: const EdgeInsets.all(AppTheme.spacingXS),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
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
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          ),
          child: Text(
            period,
            textAlign: TextAlign.center,
            style: AppTextStyles.button.copyWith(
              color: isSelected ? AppColors.customGradientStart : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopThree() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingXL,
        vertical: AppTheme.spacingL,
      ),
      child: Column(
        children: [
           Text(
            'TOP 8',
            style: AppTextStyles.h2.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: AppTheme.spacingL),
          // Podium Layout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildPodiumPosition(_topUsers[1], 2, 80), // 2nd
              _buildPodiumPosition(_topUsers[0], 1, 100), // 1st
              _buildPodiumPosition(_topUsers[2], 3, 60), // 3rd
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPosition(
      LeaderboardUser user, int position, double height) {
    Color podiumColor;
    Color numberColor;

    switch (position) {
      case 1:
        podiumColor = AppColors.warning; // vàng cam cho 1st
        numberColor = AppColors.white;
      case 2:
        podiumColor = AppColors.success; // xanh lá cho 2nd
        numberColor = AppColors.white;
      case 3:
        podiumColor = AppColors.successLight; // xanh lá nhạt cho 3rd
        numberColor = AppColors.white;
      default:
        podiumColor = AppColors.border;
        numberColor = AppColors.white;
    }

    return Column(
      children: [
        // Points
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingS,
            vertical: AppTheme.spacingXS,
          ),
          decoration: BoxDecoration(
            color: AppColors.white.withAlpha(230),
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          child: Text(
            '${user.points}',
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(height: AppTheme.spacingS),
        // Avatar
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
            border: Border.all(
              color: podiumColor,
              width: 3,
            ),
          ),
          child: CircleAvatar(
            radius: 27,
            backgroundColor: AppColors.backgroundLight,
            child: Text(
              user.name.substring(0, 1).toUpperCase(),
              style: AppTextStyles.h2.copyWith(color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacingS),
        // Podium
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: podiumColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusM),
              topRight: Radius.circular(AppTheme.radiusM),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                position.toString(),
                style: AppTextStyles.h1.copyWith(color: numberColor),
              ),
              Text(
                user.name,
                style: AppTextStyles.caption.copyWith(color: numberColor),
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
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppTheme.radiusXL),
          topRight: Radius.circular(AppTheme.radiusXL),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
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
