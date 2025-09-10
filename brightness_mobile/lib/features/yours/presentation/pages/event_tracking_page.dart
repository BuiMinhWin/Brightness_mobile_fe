import 'package:brightness_mobile/features/yours/data/models/task.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/additional_tasks_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/completed_challenges_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/event_tracking_description_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/ongoing_challenges_card.dart';
import 'package:brightness_mobile/features/yours/presentation/widgets/weekly_tracking_chart.dart';
import 'package:flutter/material.dart';

import '../../data/models/yours.dart';



class EventTrackingPage extends StatelessWidget {
  final DietPlanModel dietPlan;

  const EventTrackingPage({
    Key? key,
    required this.dietPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample task data based on your database schema
    final List<TaskModel> ongoingTasks = [
      TaskModel(
        id: '1',
        participantId: 'user123',
        taskId: '001',
        targetDate: DateTime.now().add(const Duration(days: 2)),
        status: 'ongoing',
        point: 10,
      ),
      TaskModel(
        id: '2',
        participantId: 'user123',
        taskId: '002',
        targetDate: DateTime.now().add(const Duration(days: 1)),
        status: 'in_progress',
        point: 15,
      ),
    ];

    final List<TaskModel> completedTasks = List.generate(20, (index) {
      return TaskModel(
        id: 'completed_${index + 1}',
        participantId: 'user123',
        taskId: '${100 + index}',
        targetDate: DateTime.now().subtract(Duration(days: index + 1)),
        status: 'completed',
        point: 10 + (index % 3) * 5,
        completedAt: DateTime.now().subtract(Duration(days: index)),
      );
    });

    final List<TaskModel> additionalTasks = List.generate(5, (index) {
      return TaskModel(
        id: 'additional_${index + 1}',
        participantId: 'user123',
        taskId: '${200 + index}',
        targetDate: DateTime.now().add(Duration(days: index + 3)),
        status: 'pending',
        point: 5,
      );
    });

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
                child: _buildContent(ongoingTasks, completedTasks, additionalTasks),
              ),
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Expanded(
            child: Text(
              'Tracking Event',
              style: TextStyle(
                fontSize: 20,
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

  Widget _buildContent(List<TaskModel> ongoingTasks, List<TaskModel> completedTasks, List<TaskModel> additionalTasks) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          EventTrackingDescriptionCard(dietPlan: dietPlan),
          const SizedBox(height: 16),
          const WeeklyTrackingChart(),
          const SizedBox(height: 16),
          OngoingChallengesCard(ongoingTasks: ongoingTasks),
          const SizedBox(height: 16),
          CompletedChallengesCard(completedTasks: completedTasks),
          const SizedBox(height: 16),
          AdditionalTasksCard(additionalTasks: additionalTasks),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

