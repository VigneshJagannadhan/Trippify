import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBody extends StatefulWidget {
  ChatBody({super.key, this.userId, required this.stream});

  Stream<QuerySnapshot<Object?>>? stream;
  final String? userId;

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
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(snapshot.data?.docs[index]['trip_name']),
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
