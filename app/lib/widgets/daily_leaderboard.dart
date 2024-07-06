import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:filter_profanity_flutter/filter_profanity_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paheli/models/leaderboard_entry.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paheli/models/user_properties.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/widgets/practice_leaderboard.dart';
import 'package:profanity_filter/profanity_filter.dart';

class DailyLeaderboard extends StatefulWidget {
  final int tries;
  final bool hasCompletedDailyGame;
  const DailyLeaderboard(
      {super.key, required this.tries, required this.hasCompletedDailyGame});
  @override
  State<DailyLeaderboard> createState() => _DailyLeaderboardState();
}

class _DailyLeaderboardState extends State<DailyLeaderboard> {
  List<DailyLeaderboardEntry>? entries;

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

  Stream<List<DailyLeaderboardEntry>> listen() {
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
            DailyLeaderboardEntry entry = DailyLeaderboardEntry.fromJson(val);
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
              children: [
                SizedBox(width: 276.0.w, height: 0.0.w),
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
              size: 80.sp,
              color: Color.fromARGB(255, 93, 67, 95),
            ),
            Text(
              LocaleKeys.leaderboard_title.tr(),
              style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 93, 67, 95),
              ),
            ),
            Text(
              WotD.getDayAndMonthForTitle(WotD.day)?.join(' ') ?? '',
              style: TextStyle(
                fontSize: 27.sp,
                color: Color.fromARGB(255, 93, 67, 95),
              ),
            ),
            SizedBox(height: 35.0.w),
            if (UserProperties.instance.name == '')
              Padding(
                padding: EdgeInsets.only(bottom: 6.0.w, top: 5.0.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.0.w, horizontal: 12.0.w),
                    backgroundColor: Color.fromARGB(255, 232, 168, 6),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String name = '';
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0.w),
                            side: BorderSide(
                              color: Color.fromARGB(255, 171, 121, 4),
                              width: 6.w,
                            ),
                          ),
                          backgroundColor: Color.fromARGB(255, 228, 182, 107),
                          title: Column(
                            children: [
                              // Text(LocaleKeys.leaderboard_alert_title.tr(),
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(
                              //       fontSize: 14.sp,
                              //       color: Color.fromARGB(255, 93, 67, 95),
                              //     )),
                              Text(LocaleKeys.leaderboard_alert_message.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Color.fromARGB(255, 93, 67, 95),
                                  )),
                            ],
                          ),
                          // message

                          content: TextField(
                            // a max of 20 characters
                            maxLength: 30,
                            // do not show the character counter
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (context,
                                    {required currentLength,
                                    required isFocused,
                                    required maxLength}) =>
                                null,

                            // reduce distance between text and line
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color.fromARGB(255, 93, 67, 95),
                            ),
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.center,

                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(22, 137, 106, 38),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.w, horizontal: 0.0.w),
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Color.fromARGB(146, 93, 67, 95),
                              ),
                              hintText: LocaleKeys.leaderboard_alert_title.tr(),
                            ),

                            onChanged: (value) {
                              name = value;
                            },
                            onSubmitted: (value) {
                              // make sure name isnt empty and isnt profane
                              if (name.trim().isNotEmpty &&
                                  !hasProfanity(name)) {
                                name = ProfanityFilter().censor(name);
                                UserProperties.instance.setName(name);
                                // add the user to the leaderboard
                                if (widget.hasCompletedDailyGame) {
                                  FirebaseDatabase.instance
                                      .ref(
                                          'leaderboard/${WotD.day}/${UserProperties.instance.uid}')
                                      .set({
                                    'name': name,
                                    'score': widget.tries,
                                    'UTC': ServerValue.timestamp,
                                    'local': DateTime.now().toString(),
                                  });
                                }
                                // also add to the practice leaderboard
                                if (UserProperties.instance.practiceGameIndex >
                                    minLevelForLeaderboard) {
                                  FirebaseDatabase.instance
                                      .ref(
                                          'leaderboard/practice/${UserProperties.instance.uid}')
                                      .set({
                                    'name': UserProperties.instance.name,
                                    'level': UserProperties
                                        .instance.practiceGameIndex
                                  });
                                }
                                setState(() {});
                                print(ServerValue.timestamp);
                                // check
                                print(
                                    "UserProperties.instance.name: ${UserProperties.instance.name}");
                                Navigator.pop(context);
                              }
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (name.trim().isNotEmpty &&
                                    !hasProfanity(name)) {
                                  name = ProfanityFilter().censor(name);
                                  UserProperties.instance.setName(name);
                                  // add the user to the leaderboard
                                  if (widget.hasCompletedDailyGame) {
                                    FirebaseDatabase.instance
                                        .ref(
                                            'leaderboard/${WotD.day}/${UserProperties.instance.uid}')
                                        .set({
                                      'name': name,
                                      'score': widget.tries,
                                      'UTC': ServerValue.timestamp,
                                      'local': DateTime.now().toString(),
                                    });
                                  }
                                  if (UserProperties
                                          .instance.practiceGameIndex >
                                      minLevelForLeaderboard) {
                                    FirebaseDatabase.instance
                                        .ref(
                                            'leaderboard/practice/${UserProperties.instance.uid}')
                                        .set({
                                      'name': UserProperties.instance.name,
                                      'level': UserProperties
                                          .instance.practiceGameIndex
                                    });
                                  }
                                  setState(() {});
                                  print(ServerValue.timestamp);
                                  // check
                                  print(
                                      "UserProperties.instance.name: ${UserProperties.instance.name}");
                                  Navigator.pop(context);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    LocaleKeys.leaderboard_alert_submit.tr(),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color.fromARGB(255, 93, 67, 95),
                                    )),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    LocaleKeys.leaderboard_name.tr(),
                    style: TextStyle(
                      fontSize: 19.sp,
                      color: Color.fromARGB(255, 93, 67, 95),
                    ),
                  ),
                ),
              ),
            entries == null
                ? LeaderboardLoading()
                : entries!.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 180.0),
                        child: Text(LocaleKeys.leaderboard_noScores.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Color.fromARGB(255, 93, 67, 95),
                            )),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entries!.length,
                        itemBuilder: (context, index) {
                          return DailyLeaderboardEntryWidget(
                              entry: entries![index], index: index);
                        },
                      )
          ]),
        ),
 
      ),
    );
  }
}

class DailyLeaderboardEntryWidget extends StatelessWidget {
  const DailyLeaderboardEntryWidget({
    super.key,
    required this.index,
    required this.entry,
  });

  final DailyLeaderboardEntry entry;
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
                  fontSize: 17.sp,
                  fontWeight:
                      (index + 1) <= 3 ? FontWeight.bold : FontWeight.normal,
                  color: Color.fromARGB(255, 93, 67, 95),
                ),
              ),
            ),
          ),
          title: Text(entry.name),
          trailing:
              Text(entry.score.toString() + LocaleKeys.leaderboard_tries.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color.fromARGB(255, 93, 67, 95),
                  )),
          subtitle: Text(
            Jiffy.parseFromDateTime(entry.local).fromNow(),
            // entries[index].date.toString(),
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: Color.fromARGB(255, 93, 67, 95),
          ),
          subtitleTextStyle: TextStyle(
            fontSize: 12.sp,
            color: Color.fromARGB(255, 93, 67, 95),
          ),
        ),
      );
    }
    return Container();
  }
}

class LeaderboardLoading extends StatefulWidget {
  @override
  State<LeaderboardLoading> createState() => _LeaderboardLoadingState();
}

class _LeaderboardLoadingState extends State<LeaderboardLoading> {
  bool showAdditionalMessage = false;

  @override
  void initState() {
    super.initState();
    // Start a timer after 10 seconds to show the additional message
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showAdditionalMessage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 120.0.w),
        if (!showAdditionalMessage)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(LocaleKeys.leaderboard_loading.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color.fromARGB(255, 93, 67, 95),
                )),
          ),
        if (showAdditionalMessage)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(LocaleKeys.leaderboard_noInternet.tr(),
                minFontSize: 14,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 93, 67, 95),
                )),
          ),
        const CircularProgressIndicator(),
      ],
    );
  }
}
