import 'package:flutter/material.dart';
import 'package:taskly/screen/newnote.dart';
import 'package:taskly/screen/notelist.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const NoteList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewNote(
                  textAlign: TextAlign.left,
                  initialTextAlign: TextAlign.left,
                ),
              )),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
