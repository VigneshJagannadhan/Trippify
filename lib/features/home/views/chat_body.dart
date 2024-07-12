import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trippify/utils/colors.dart';
import 'package:trippify/utils/spacing.dart';
import 'package:trippify/utils/styles.dart';

class ChatBody extends StatefulWidget {
  ChatBody({super.key, required this.stream});

  Stream<QuerySnapshot<Object?>>? stream;

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  // final DateTime _selectedDay = DateTime.now();

  final Map<DateTime, List<dynamic>> _events = {};

  List<Map> testList = [
    {
      "date": "2024-07-03 00:00:00.000Z",
      "color": "red",
    },
    {
      "date": "2024-07-08 00:00:00.000Z",
      "color": "blue",
    },
    {
      "date": "2024-07-04 00:00:00.000Z",
      "color": "green",
    },
    {
      "date": "2024-07-07 00:00:00.000Z",
      "color": "red",
    },
    {
      "date": "2024-07-05 00:00:00.000Z",
      "color": "orange",
    },
    {
      "date": "2024-07-06 00:00:00.000Z",
      "color": "red",
    },
  ];

  void _loadEvents() {
    // Process API data to populate _events map
    for (var event in testList) {
      DateTime date = DateTime.parse(event['date']);
      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.add(event['color']);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadEvents(); // Load events initially
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gv70,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'My Chats',
                  style: AppStyles.tsFS24C00W400,
                ),
              ),
              gv20,
              Column(
                children:
                    List.generate(snapshot.data?.docs.length ?? 0, (index) {
                  final tripName = snapshot.data?.docs[index]['trip_name'];
                  final lastMessage =
                      snapshot.data?.docs[index]['messages'][0]['message'];
                  final lastMessageTime = DateTime.parse(snapshot
                          .data?.docs[index]['messages'][0]['created_time'])
                      .toLocal();
                  final time = DateFormat('hh:mm').format(lastMessageTime);
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 05.h),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        snapshot.data?.docs[index]['image_url'],
                      ),
                    ),
                    title: Text(tripName, style: AppStyles.tsFS15C00W500),
                    subtitle: Text(
                      lastMessage,
                      style: AppStyles.tsFS12CGreyW400,
                    ),
                    trailing: Column(
                      children: [
                        Text(time, style: AppStyles.tsFS10CGreyW500),
                        gv05,
                        CircleAvatar(
                            radius: 10,
                            backgroundColor: primaryColor,
                            child: Text('1', style: AppStyles.tsFS12CFFW600)),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        );

        // return Column(
        //   children: [
        //     TableCalendar(
        //       firstDay: DateTime.utc(2010, 10, 16),
        //       lastDay: DateTime.utc(2030, 3, 14),
        //       focusedDay: DateTime.now(),
        //       selectedDayPredicate: (day) {
        //         return isSameDay(_selectedDay, day);
        //       },
        //       onDaySelected: (selectedDay, focusedDay) {
        //         setState(() {
        //           _selectedDay = selectedDay;
        //         });
        //       },
        //       calendarStyle: CalendarStyle(
        //         todayDecoration: BoxDecoration(color: colorFFFFFFFF),
        //         selectedDecoration: ShapeDecoration(
        //           shape: CircleBorder(
        //             side: BorderSide(color: color00000000, width: 10),
        //           ),
        //         ),
        //       ),
        //       calendarBuilders: CalendarBuilders(
        //         markerBuilder: (context, day, events) {
        //           Color findColor(color) {
        //             if (color == "red") {
        //               return Colors.red;
        //             } else if (color == "blue") {
        //               return Colors.blue;
        //             } else if (color == "orange") {
        //               return Colors.orange;
        //             } else if (color == "green") {
        //               return Colors.green;
        //             } else {
        //               return colorFFFFFFFF;
        //             }
        //           }

        //           for (var i = 0; i < testList.length; i++) {
        //             DateTime dateFromList = DateTime.parse(testList[i]["date"]);
        //             int dayFromList = dateFromList.day;
        //             int monthFromList = dateFromList.month;
        //             if (day.day == dayFromList && day.month == monthFromList) {
        //               return Positioned(
        //                 top: 10,
        //                 child: CircleAvatar(
        //                   radius: 16,
        //                   backgroundColor: findColor(testList[i]["color"]),
        //                   child: Text(
        //                     dayFromList.toString(),
        //                     style: AppStyles.tsFS12CFFW600,
        //                   ),
        //                 ),
        //               );
        //             }
        //           }
        //           return null;
        //         },
        //       ),
        //     ),
        //     gv50,
        //     Text(_selectedDay.toString()),
        //   ],
        // );
      },
    );
  }
}
