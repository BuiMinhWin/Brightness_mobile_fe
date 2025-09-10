import 'package:flutter/material.dart';

class WeeklyTrackingChart extends StatelessWidget {
  const WeeklyTrackingChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for weekly tracking
    final List<double> weeklyData = [2, 1, 5, 2, 3, 1, 4];
    final List<String> dayLabels = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'TRACKING',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF999999),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            child: Column(
              children: [
                // Y-axis labels
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Y-axis
                      Container(
                        width: 30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('6', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                            Text('4', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                            Text('2', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                            Text('0', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                          ],
                        ),
                      ),
                      // Bars
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(7, (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 24,
                                  height: weeklyData[index] * 30, // Scale factor
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: index == 6 
                                        ? const Color(0xFFFF9800) // Highlight today
                                        : const Color(0xFFE0E0E0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Text(
                                  dayLabels[index],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}