import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:taskly/database/firebase_database.dart';
import 'package:taskly/widgets/editor.dart';

// ignore: must_be_immutable
class NoteView extends StatefulWidget {
  final String title;
  TextAlign textAlign;
  final String items;
  final String id;

  NoteView({
    super.key,
    required this.title,
    required this.items,
    required this.textAlign,
    required this.id,
  });

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  late TextEditingController _controller;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    String combinedItems = widget.items;
    _controller = TextEditingController(text: combinedItems);
  }

  @override
  void dispose() {
    _controller.dispose();
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
      // Update the text alignment
      widget.textAlign = align;
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
                Navigator.pop(context);
              },
            ),
            actions: [
              const Icon(EneftyIcons.clipboard_text_outline, size: 24),
              const SizedBox(width: 20),
              const Icon(EneftyIcons.heart_outline, size: 24),
              const SizedBox(width: 20),
              GestureDetector(
                  onTap: () {},
                  child: const Icon(EneftyIcons.document_download_outline,
                      size: 24)),
              const SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      textAlign: widget.textAlign,
                      controller: _controller,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      style: const TextStyle(
                        fontFamily: 'Product Sans',
                        fontSize: 17,
                      ),
                      onChanged: (value) {
                        // Update the controller value as the user types
                        _controller.text = value;
                      },
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Editor(
                    justify: () {
                      _updateTextAlign(TextAlign.justify);
                    },
                    center: () {
                      _updateTextAlign(TextAlign.center);
                    },
                    left: () {
                      _updateTextAlign(TextAlign.left);
                    },
                    right: () {
                      _updateTextAlign(TextAlign.right);
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
