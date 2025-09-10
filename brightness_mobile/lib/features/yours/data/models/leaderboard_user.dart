class LeaderboardUser {
  final String id;
  final String name;
  final int points;
  final int rank;
  final String? avatarUrl;

  const LeaderboardUser({
    required this.id,
    required this.name,
    required this.points,
    required this.rank,
    this.avatarUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LeaderboardUser &&
        other.id == id &&
        other.name == name &&
        other.points == points &&
        other.rank == rank &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        points.hashCode ^
        rank.hashCode ^
        avatarUrl.hashCode;
  }

  @override
  String toString() {
    return 'LeaderboardUser(id: $id, name: $name, points: $points, rank: $rank, avatarUrl: $avatarUrl)';
  }
}