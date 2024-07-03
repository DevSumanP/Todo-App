import 'package:flutter/material.dart';
import 'package:taskly/database/firebase_database.dart';
import 'package:taskly/screen/noteview.dart';

class NotesCard extends StatelessWidget {
  final String id;
  final String title;
  final String items;
  final Color color;

  const NotesCard({
    super.key,
    required this.id,
    required this.title,
    required this.items,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        FirebaseService().deleteItem(id);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteView(
              id: id,
              items: items,
              title: title,
              textAlign: TextAlign.left,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 4.0, right: 4.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
