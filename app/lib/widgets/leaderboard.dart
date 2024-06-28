import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paheli/models/leaderboard_entry.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paheli/models/user_properties.dart';
import 'package:paheli/models/wotd.dart';

class Leaderboard extends StatefulWidget {
  final int tries;
  final bool hasCompletedDailyChallenge;
  const Leaderboard(
      {super.key,
      required this.tries,
      required this.hasCompletedDailyChallenge});
  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<LeaderboardEntry> entries = [];

  @override
  void initState() {
    super.initState();
    listen().listen((g) => mounted
        ? setState(() {
            entries = g;
            entries.sort((a, b) => b.local.compareTo(a.local));
          })
        : null);
  }

  static Stream<List<LeaderboardEntry>> listen() {
    return FirebaseDatabase.instance
        .ref('leaderboard/${WotD.day}')
        .onValue
        .map((event) {
      List<LeaderboardEntry> entries = [];
      Map list = event.snapshot.value as Map;
      print(
          "list: $list"); // "list: [{name: test, score: 0, date: 2021-09-01 00:00:00}]"
      for (var val in list.values) {
        print(
            "val: $val"); // "val: {name: test, score: 0, date: 2021-09-01 00:00:00}

        if (val != null) {
          try {
            LeaderboardEntry entry = LeaderboardEntry.fromJson(val);
            entries.add(entry);
          } on Exception catch (e) {
            print("Error: $e");
          }
        }
        print("Exitted");
      }
      return entries;
    });
  }

  // return LeaderboardEntry._internal(entries);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0.w),
            border: Border.all(
                color: const Color.fromRGBO(255, 181, 70, 1), width: 5.w),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(162, 79, 1, 1),
              Color.fromRGBO(230, 154, 39, 1),
              Color.fromRGBO(229, 130, 0, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: EdgeInsets.only(top: 18.0.w),
        margin: EdgeInsets.all(18.0.w),
        child: SingleChildScrollView(
          child: Column(children: [
            // crown icon
            LineIcon(
              LineIcons.crown,
              size: 48.sp,
              color: Colors.white,
            ),
            Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              WotD.getDayAndMonthForTitle(WotD.day)?.join(' ') ?? '',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            //if (UserProperties.instance.name == '' && widget.hasCompletedDailyChallenge)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.w),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    // input name using keyboard
                    showDialog(
                      context: context,
                      builder: (context) {
                        String name = '';
                        return AlertDialog(
                          title: Text('Enter your name'),
                          content: TextField(
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (name.trim().isNotEmpty) {
                                  UserProperties.instance.setName(name);
                                  // add the user to the leaderboard
                                  FirebaseDatabase.instance
                                      .ref('leaderboard/${WotD.day}')
                                      .push()
                                      .set({
                                    'name': name,
                                    'score': widget.tries,
                                    'UTC': ServerValue.timestamp,
                                    'local': DateTime.now().toString(),
                                  });
                                  print(ServerValue.timestamp);
                                  // check
                                  print(
                                      "UserProperties.instance.name: ${UserProperties.instance.name}");
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Add your name to the leaderboard")),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return LeaderboardEntryWidget(entry: entries[index]);
              },
            )
          ]),
        ),
        //   bottomNavigationBar: TextField(
        //     decoration: InputDecoration(
        //       hintText: 'Enter your name',
        //     ),
        //     onSubmitted: (name) {
        //       // add the user to the leaderboard
        //       FirebaseDatabase.instance.ref('leaderboard').push().set({
        //         'name': name,
        //         'score': 0,
        //         'date': ServerValue.timestamp,
        //       });
        //     },
        //   ),
      ),
    );
  }
}

class LeaderboardEntryWidget extends StatelessWidget {
  const LeaderboardEntryWidget({
    super.key,
    required this.entry,
  });

  final LeaderboardEntry entry;

  @override
  Widget build(BuildContext context) {
    // only if local is not in future
    if (entry.local.isBefore(DateTime.now())) {
      return Container(
        margin: const EdgeInsets.all(8).w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border:
              Border.all(color: Color.fromARGB(255, 91, 84, 73), width: 5.w),
          color: Color.fromARGB(255, 91, 84, 73),
        ),
        child: ListTile(
          title: Text(entry.name),
          trailing: Text(entry.score.toString() + " tries"),
          subtitle: Text(
            Jiffy.parseFromDateTime(entry.local).fromNow(),
            // entries[index].date.toString(),
          ),
          textColor: Colors.white,
        ),
      );
    }
    return Container();
  }
}
