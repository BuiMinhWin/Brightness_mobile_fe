class EventModel {
  final String id;
  final String title;
  final String dateTime;
  final String description;
  final String fullDescription;
  final String startDate;
  final String endDate;
  final int durationDays;
  final int dailyMinutes;

  const EventModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.description,
    required this.fullDescription,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.dailyMinutes,
  });
}