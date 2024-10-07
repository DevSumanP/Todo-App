import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:taskly/database/firebase_database.dart';
import 'package:taskly/widgets/editor.dart';

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

  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;

  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.items);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }
  }

  void _updateTextAlign(TextAlign align) {
    setState(() {
      widget.textAlign = align;
    });
  }

  void _toggleBold() {
    final text = _controller.text;
    final selection = _controller.selection;

    final selectedText = text.substring(selection.start, selection.end);

    setState(() {
      // Toggle the bold state
      isBold = !isBold;
      _fontWeight = isBold ? FontWeight.bold : FontWeight.normal;

      // Replace the selected text with the updated text
      _controller.text = text.replaceRange(
        selection.start,
        selection.end,
        selectedText, // You can add bold formatting here if necessary
      );

      // Restore the cursor position
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: selection.start + selectedText.length),
      );
    });
  }

  void _toggleItalic() {
    final text = _controller.text;
    final selection = _controller.selection;

    final selectedText = text.substring(selection.start, selection.end);

    setState(() {
      // Toggle the italic state
      isItalic = !isItalic;
      _fontStyle = isItalic ? FontStyle.italic : FontStyle.normal;

      // Replace the selected text with the updated text
      _controller.text = text.replaceRange(
        selection.start,
        selection.end,
        selectedText, // You can add italic formatting here if necessary
      );

      // Restore the cursor position
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: selection.start + selectedText.length),
      );
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
                if (_controller.text != widget.items) {
                  FirebaseService().updateItem(widget.id, _controller.text);
                }
                Navigator.pop(context);
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
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextField(
                    textAlign: widget.textAlign,
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 17,
                      fontWeight: _fontWeight,
                      fontStyle: _fontStyle,
                    ),
                    onChanged: (value) {
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
                  const SizedBox(height: 20),
                  Editor(
                    controller: _controller,
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
                    bold: _toggleBold,
                    italic: _toggleItalic,
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
