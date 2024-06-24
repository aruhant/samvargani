import 'package:flutter/material.dart';
import 'package:paheli/models/learboard_entry.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<LeaderboardEntry> entries = [];

  @override
  void initState() {
    super.initState();
    entries = [
      LeaderboardEntry(name: 'John Doe', score: 100, date: DateTime.now()),
      LeaderboardEntry(name: 'Jane Doe', score: 200, date: DateTime.now()),
      LeaderboardEntry(name: 'Alice', score: 300, date: DateTime.now()),
      LeaderboardEntry(name: 'Bob', score: 400, date: DateTime.now()),
      LeaderboardEntry(name: 'Charlie', score: 500, date: DateTime.now()),
      LeaderboardEntry(name: 'David', score: 600, date: DateTime.now()),
      LeaderboardEntry(name: 'Eve', score: 700, date: DateTime.now()),
      LeaderboardEntry(name: 'Frank', score: 800, date: DateTime.now()),
      LeaderboardEntry(name: 'Grace', score: 900, date: DateTime.now()),
      LeaderboardEntry(name: 'Hank', score: 1000, date: DateTime.now()),
    ];
    entries.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(entries[index].name),
            trailing: Text(entries[index].score.toString()),
            subtitle: Text(entries[index].date.toString()),
          );
        },
      ),
    );
  }
}
