import 'package:flutter/material.dart';
import '../../data/models/event.dart';
import '../widgets/event_card.dart';
import 'event_detail_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class EventPageContent extends StatelessWidget {
  const EventPageContent({Key? key}) : super(key: key);

  // Make this static const to allow const constructor
  static const List<EventModel> _events = [
    EventModel(
      id: '1',
      title: 'HEALTHY DIET',
      dateTime: '10:00 AM, 15/03/2024',
      description: 'Nutrition challenge',
      fullDescription: 'Join thousands of fitness enthusiasts in our most exciting 30-day healthy diet challenge! This comprehensive program focuses on nutrition education, meal planning, and sustainable eating habits to help you achieve your health goals.',
      startDate: 'March 15, 2024',
      endDate: 'April 14, 2024',
      durationDays: 30,
      dailyMinutes: 45,
    ),
    EventModel(
      id: '2', 
      title: 'MORNING YOGA',
      dateTime: '07:00 AM, 20/03/2024',
      description: 'Mindfulness practice',
      fullDescription: 'Start your day with peaceful morning yoga sessions designed to improve flexibility, reduce stress, and enhance mental clarity. Perfect for all skill levels.',
      startDate: 'March 20, 2024',
      endDate: 'April 19, 2024',
      durationDays: 30,
      dailyMinutes: 30,
    ),
    EventModel(
      id: '3',
      title: 'CARDIO BLAST',
      dateTime: '06:00 PM, 25/03/2024',
      description: 'High intensity workout',
      fullDescription: 'High-intensity cardio workouts that will boost your metabolism, improve cardiovascular health, and help you burn calories effectively.',
      startDate: 'March 25, 2024',
      endDate: 'April 24, 2024',
      durationDays: 30,
      dailyMinutes: 60,
    ),
    EventModel(
      id: '4',
      title: 'STRENGTH TRAINING',
      dateTime: '05:30 PM, 01/04/2024',
      description: 'Muscle building program',
      fullDescription: 'Build lean muscle mass and increase your overall strength with our progressive strength training program designed for all fitness levels.',
      startDate: 'April 1, 2024',
      endDate: 'April 30, 2024',
      durationDays: 30,
      dailyMinutes: 50,
    ),
    EventModel(
      id: '5',
      title: 'MEDITATION SERIES',
      dateTime: '08:00 PM, 05/04/2024',
      description: 'Mental wellness journey',
      fullDescription: 'Discover inner peace and mental clarity through guided meditation sessions that will help reduce stress and improve overall well-being.',
      startDate: 'April 5, 2024',
      endDate: 'May 4, 2024',
      durationDays: 30,
      dailyMinutes: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.customGradient,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildEventsList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        'Event',
        style: AppTextStyles.h1.copyWith(fontSize: 36),
      ),
    );
  }

  Widget _buildEventsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return EventCard(
            event: _events[index],
            onTap: () => _navigateToEventDetail(context, _events[index]),
          );
        },
      ),
    );
  }

  // Navigation method - this is where the magic happens!
  void _navigateToEventDetail(BuildContext context, EventModel event) {
    print('Navigating to event detail for: ${event.title}');
    
    // Push the event detail page onto the navigation stack
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailPage(event: event),
        // Optional: Add custom page transition
        settings: RouteSettings(name: '/event-detail/${event.id}'),
      ),
    );
  }
}