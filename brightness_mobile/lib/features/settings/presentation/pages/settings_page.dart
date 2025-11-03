import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/controllers/login_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = context.read<LoginController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                  ),
                  const Spacer(),
                  const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),

              // Account
              const Text('Account', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              const _SettingsCard(children: [
                _RowItem(icon: Icons.person_outline, label: 'Profile'),
                _Divider(),
                _RowItem(icon: Icons.shield_outlined, label: 'Security'),
                _Divider(),
                _RowItem(icon: Icons.notifications_none, label: 'Notifications'),
                _Divider(),
                _RowItem(icon: Icons.lock_outline, label: 'Privacy'),
              ]),

              const SizedBox(height: 20),

              // Support & About
              const Text('Support & About', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              const _SettingsCard(children: [
                _RowItem(icon: Icons.subscriptions_outlined, label: 'My Subscription'),
                _Divider(),
                _RowItem(icon: Icons.help_outline, label: 'Help & Support'),
                _Divider(),
                _RowItem(icon: Icons.info_outline, label: 'Terms and Policies'),
              ]),

              const SizedBox(height: 20),

              // Actions
              const Text('Actions', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              _SettingsCard(children: [
                const _RowItem(icon: Icons.flag_outlined, label: 'Report a problem'),
                const _Divider(),
                _RowItem(
                  icon: Icons.logout,
                  label: 'Log out',
                  onTap: () => loginController.logout(context),
                ),
              ]),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: children),
    );
  }
}

class _RowItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _RowItem({required this.icon, required this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade700),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: AppColors.border.withAlpha(178));
  }
}

