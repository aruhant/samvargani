class DailyLeaderboardEntry {
  final String name;
  final int score;
  final DateTime UTC;
  final DateTime local;
  DailyLeaderboardEntry({
    required this.name,
    required this.score,
    required this.UTC,
    required this.local,
  });

  static DailyLeaderboardEntry fromJson(Map val) {
    return DailyLeaderboardEntry(
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

class PracticeLeaderboardEntry {
  final String name;
  final int level;
  PracticeLeaderboardEntry({
    required this.name,
    required this.level,
  });

  static PracticeLeaderboardEntry fromJson(Map val) {
    return PracticeLeaderboardEntry(
      name: val['name'],
      level: val['level'],
    );
  }

  Map toJson() {
    return {
      'name': name,
      'level': level,
    };
  }
}
