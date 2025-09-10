class TaskModel {
  final String id;
  final String participantId;
  final String taskId;
  final DateTime targetDate;
  final String status;
  final String? validationData;
  final int point;
  final DateTime? completedAt;

  const TaskModel({
    required this.id,
    required this.participantId,
    required this.taskId,
    required this.targetDate,
    required this.status,
    this.validationData,
    required this.point,
    this.completedAt,
  });

  bool get isCompleted => status == 'completed';
  bool get isOngoing => status == 'ongoing' || status == 'in_progress';
  bool get isPending => status == 'pending';
}
