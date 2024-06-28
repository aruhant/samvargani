class LeaderboardEntry {
  final String name;
  final int score;
  final DateTime UTC;
  final DateTime local;
  LeaderboardEntry({
    required this.name,
    required this.score,
    required this.UTC,
    required this.local,
  });

  static LeaderboardEntry fromJson(Map val) {
    return LeaderboardEntry(
        name: val['name'],
        score: val['score'],
        // date might be stored as int or string
        UTC: val['UTC'] is int
            ? DateTime.fromMillisecondsSinceEpoch(val['UTC'])
            : DateTime.parse(val['UTC']),
        local: DateTime.parse(val['local']));
  }

  Map toJson() {
    return {
      'name': name,
      'score': score,
      'UTC': UTC.toIso8601String(),
      'local': local.toIso8601String(),
    };
  }
}
