import 'package:brightness_mobile/features/yours/presentation/widgets/event_description_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/event_duration_card.dart' hide EventDurationCard;
import 'package:brightness_mobile/features/yours/presentation/widgets/how_to_participate_card.dart';
import 'package:flutter/material.dart';

import '../../data/models/event.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              _buildHeader(context),
              Expanded(
                child: _buildContent(),
              ),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Navigate back to event list
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              '${event.title} - Detail',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          EventDescriptionCard(event: event),
          const SizedBox(height: 16),
          const HowToParticipateCard(),
          const SizedBox(height: 16),
          EventDurationCard(event: event),
          const SizedBox(height: 16),
          const RewardsAndPrizesCard(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Ready to start your ${event.title.toLowerCase()} journey?',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  onPressed: () {
                    // Handle join event
                    _showJoinDialog(context);
                  },
                  icon: Icons.check,
                  color: const Color(0xFF4CAF50),
                  tooltip: 'Join Event',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionButton(
                  onPressed: () {
                    // Go back to events list
                    Navigator.pop(context);
                  },
                  icon: Icons.close,
                  color: const Color(0xFFE53E3E),
                  tooltip: 'Go Back',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 2),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Join ${event.title}?'),
          content: Text('Are you ready to commit to this ${event.durationDays}-day challenge?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to events list
                // Here you would typically handle the join logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Successfully joined ${event.title}!'),
                    backgroundColor: const Color(0xFF4CAF50),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
              ),
              child: const Text('Join Now'),
            ),
          ],
        );
      },
    );
  }
}