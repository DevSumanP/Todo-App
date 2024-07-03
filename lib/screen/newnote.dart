import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:taskly/database/firebase_database.dart';
import 'package:taskly/utils/color_utlis.dart';
import 'package:taskly/widgets/editor.dart';

class NewNote extends StatefulWidget {
  final TextAlign textAlign;

  const NewNote({
    super.key,
    required this.textAlign,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_isKeyboardVisible) {
      // Dismiss the keyboard when tapping outside the TextField
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(EneftyIcons.arrow_left_4_outline),
              onPressed: () {
                (_titleController.text.isEmpty ||
                        _contentController.text.isEmpty)
                    ? Navigator.pop(context)
                    : {
                        FirebaseService().addItem(_titleController.text,
                            _contentController.text, GetColor.getRandomColor()),
                        Navigator.pop(context)
                      };
              },
            ),
            actions: const [
              Icon(EneftyIcons.clipboard_text_outline, size: 24),
              SizedBox(width: 20),
              Icon(EneftyIcons.heart_outline, size: 24),
              SizedBox(width: 20),
              Icon(EneftyIcons.document_download_outline, size: 24),
              SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                    ),
                    maxLines: null,
                    style: const TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 0),
                  TextField(
                    controller: _contentController,
                    textAlign: widget.textAlign,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Note',
                    ),
                    maxLines: null,
                    style: const TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Editor(
                    justify: () {
                      // Implement text alignment functionality if needed
                    },
                    center: () {
                      // Implement text alignment functionality if needed
                    },
                    left: () {
                      // Implement text alignment functionality if needed
                    },
                    right: () {
                      // Implement text alignment functionality if needed
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
