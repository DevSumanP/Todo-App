import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskly/database/firebase_database.dart';
import 'package:taskly/modals/note.dart';
import 'package:taskly/utils/color_utlis.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isLoading = true;

  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              print(GetColor.getRandomColor());
            },
            child: const Text(
              'AstroNote',
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 20),
            lastDay: DateTime.utc(2040, 10, 20),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            headerStyle: const HeaderStyle(
              titleTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w800,
              ),
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color(0xD41A1A1A),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  label: const Text('All'),
                  onSelected: (_) {},
                  selected: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                FilterChip(
                  label: const Text('Important'),
                  onSelected: (_) {},
                  selected: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                FilterChip(
                  label: const Text('Lecture notes'),
                  onSelected: (_) {},
                  selected: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                FilterChip(
                  label: const Text('To-do lists'),
                  onSelected: (_) {},
                  selected: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                FilterChip(
                  label: const Text('Shopping'),
                  onSelected: (_) {},
                  selected: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: StreamBuilder(
              stream: _firebaseService.getItems(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            SizedBox(
                              height: 180,
                              width: 180,
                              child: Lottie.asset(
                                'assets/images/astronaut.json',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Empty List!",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "You have no tasks at the moment.",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 0,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      Color color = Color(documentSnapshot['color']);
                      return NotesCard(
                        id: documentSnapshot.id,
                        title: documentSnapshot['title'],
                        items: documentSnapshot['items'],
                        color: documentSnapshot['color'],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
