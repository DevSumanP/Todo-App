import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:taskly/database/firebase_database.dart';
import 'package:taskly/utils/color_utlis.dart';
import 'package:taskly/widgets/editor.dart';

class NewNote extends StatefulWidget {
  final TextAlign
      initialTextAlign; // Renamed to clarify it's the initial alignment

  const NewNote({
    super.key,
    required this.initialTextAlign,
    required TextAlign textAlign,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isKeyboardVisible = false;
  late TextAlign _currentTextAlign; // New variable for current alignment

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _currentTextAlign =
        widget.initialTextAlign; // Initialize the current alignment
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

  void _updateTextAlign(TextAlign align) {
    setState(() {
      _currentTextAlign = align; // Update the current text alignment
    });
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
                        FirebaseService().addItem(
                          _titleController.text,
                          _contentController.text,
                          GetColor.getRandomColor(),
                        ),
                        Navigator.pop(context),
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
                    textAlign: _currentTextAlign, // Use the current alignment
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
                    onTap: () {
                      setState(() {
                        _isKeyboardVisible = true;
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        _isKeyboardVisible = false;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Editor(
                    justify: () => _updateTextAlign(TextAlign.justify),
                    center: () => _updateTextAlign(TextAlign.center),
                    left: () => _updateTextAlign(TextAlign.left),
                    right: () => _updateTextAlign(TextAlign.right),
                    controller:
                        _contentController, // Pass the content controller here
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
