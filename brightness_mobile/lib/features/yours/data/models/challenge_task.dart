class ChallengeTaskModel {
  final String id;
  final String challengeId;
  final String name;
  final String description;
  final String type;
  final String frequencyRule;
  final int point;
  final bool isRequired;
  final String? validation;
  final DateTime startDate;
  final DateTime endDate;

  const ChallengeTaskModel({
    required this.id,
    required this.challengeId,
    required this.name,
    required this.description,
    required this.type,
    required this.frequencyRule,
    required this.point,
    required this.isRequired,
    this.validation,
    required this.startDate,
    required this.endDate,
  });
}
