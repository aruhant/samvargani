import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paheli/models/leaderboard_entry.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paheli/models/user_properties.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/widgets/loading.dart';

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
  List<LeaderboardEntry>? entries;

  @override
  void initState() {
    super.initState();
    listen().listen((g) => mounted
        ? setState(() {
            entries = g;
            entries!.sort((a, b) => a.local.compareTo(b.local));
          })
        : null);
  }

  Stream<List<LeaderboardEntry>> listen() {
    return FirebaseDatabase.instance
        .ref('leaderboard/${WotD.day}')
        .onValue
        .map((event) {
      entries = [];
      if (event.snapshot.value == null) {
        return entries!;
      }
      Map list = event.snapshot.value as Map;
      print(
          "list: $list"); // "list: [{name: test, score: 0, date: 2021-09-01 00:00:00}]"
      for (var val in list.values) {
        print(
            "val: $val"); // "val: {name: test, score: 0, date: 2021-09-01 00:00:00}

        if (val != null) {
          try {
            LeaderboardEntry entry = LeaderboardEntry.fromJson(val);
            entries!.add(entry);
          } on Exception catch (e) {
            print("Error: $e");
          }
        }
        print("Exitted");
      }
      return entries!;
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
            border:
                Border.all(color: Color.fromARGB(255, 171, 121, 4), width: 5.w),
            // purplish gold
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(229, 190, 146, 1),
              Color.fromRGBO(250, 229, 161, 1),

              //    Color.fromRGBO(239, 192, 120, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: EdgeInsets.only(top: 8.0.w),
        margin: EdgeInsets.all(10.0.w),
        child: SingleChildScrollView(
          child: entries == null
              ? Loading()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Row(
                        children: [
                          SizedBox(width: 286.0.w, height: 0.0.w),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),

                      // crown icon
                      LineIcon(
                        LineIcons.crown,
                        size: 65.sp,
                        color: Color.fromARGB(255, 93, 67, 95),
                      ),
                      Text(
                        'Leaderboard',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 93, 67, 95),
                        ),
                      ),
                      Text(
                        WotD.getDayAndMonthForTitle(WotD.day)?.join(' ') ?? '',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Color.fromARGB(255, 93, 67, 95),
                        ),
                      ),
                      if (UserProperties.instance.name == '')
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0.w),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.0.w, horizontal: 16.0.w),
                              backgroundColor: Color.fromARGB(255, 232, 168, 6),
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
                                            UserProperties.instance
                                                .setName(name);
                                            // add the user to the leaderboard
                                            if (widget
                                                .hasCompletedDailyChallenge) {
                                              FirebaseDatabase.instance
                                                  .ref(
                                                      'leaderboard/${WotD.day}')
                                                  .push()
                                                  .set({
                                                'name': name,
                                                'score': widget.tries,
                                                'UTC': ServerValue.timestamp,
                                                'local':
                                                    DateTime.now().toString(),
                                              });
                                            }
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
                            child: Text(
                              "Add your name to the leaderboard",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color.fromARGB(255, 93, 67, 95),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 20.0.w),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entries!.length,
                        itemBuilder: (context, index) {
                          return LeaderboardEntryWidget(
                              entry: entries![index], index: index);
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
    required this.index,
    required this.entry,
  });

  final LeaderboardEntry entry;
  final int index;
  @override
  Widget build(BuildContext context) {
    // only if entry is not in future due to timezone difference
    if (entry.local.isBefore(DateTime.now())) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 2.0.w, horizontal: 6.0.w),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: Color.fromARGB(255, 91, 84, 73), width: 1.w),
          color: Color.fromARGB(255, 215, 163, 78),
        ),
        child: ListTile(
          minTileHeight: 0.0.w,
          // decrease padding
          dense: false,
          // add a list number
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  color: Color.fromARGB(255, 93, 67, 95), width: 0.w),
              color: Color.fromARGB(136, 238, 182, 91),
            ),
            width: 20.0.w,
            height: 20.0.w,
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 93, 67, 95),
                ),
              ),
            ),
          ),
          title: Text(entry.name),
          trailing: Text(entry.score.toString() + " tries",
              style: TextStyle(
                fontSize: 12.sp,
                color: Color.fromARGB(255, 93, 67, 95),
              )),
          subtitle: Text(
            Jiffy.parseFromDateTime(entry.local).fromNow(),
            // entries[index].date.toString(),
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Color.fromARGB(255, 93, 67, 95),
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 10.sp,
            color: Color.fromARGB(255, 93, 67, 95),
          ),
        ),
      );
    }
    return Container();
  }
}
