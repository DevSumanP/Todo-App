import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  final TextEditingController controller;
  final Function()? justify;
  final Function()? left;
  final Function()? center;
  final Function()? right;
  final Function()? bold;
  final Function()? italic;

  const Editor({
    super.key,
    required this.controller,
    this.justify,
    this.left,
    this.center,
    this.right,
    this.bold,
    this.italic,
  });

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;

  void toggleBold() {
    setState(() {
      isBold = !isBold;
    });
  }

  void toggleItalic() {
    setState(() {
      isItalic = !isItalic;
    });
  }

  void toggleUnderline() {
    setState(() {
      isUnderlined = !isUnderlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 353,
      decoration: BoxDecoration(
        color: const Color(0xff181818),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: widget.bold,
            child: Icon(
              EneftyIcons.text_bold_outline,
              color: isBold ? Colors.yellow : Color(0xffffffff),
              size: 20,
            ),
          ),
          GestureDetector(
            onTap: widget.italic,
            child: Icon(
              EneftyIcons.text_italic_outline,
              color: isItalic ? Colors.yellow : Color(0xffffffff),
              size: 20,
            ),
          ),
          GestureDetector(
            onTap: toggleUnderline,
            child: Icon(
              EneftyIcons.text_underline_outline,
              color: isUnderlined ? Colors.yellow : Color(0xffffffff),
              size: 20,
            ),
          ),
          GestureDetector(
            onTap: widget.justify,
            child: const Icon(
              EneftyIcons.textalign_justifycenter_outline,
              color: Color(0xffffffff),
              size: 20,
            ),
          ),
          GestureDetector(
            onTap: widget.left,
            child: const Icon(
              EneftyIcons.textalign_justifyleft_outline,
              color: Color(0xffffffff),
              size: 20,
            ),
          ),
          GestureDetector(
            onTap: widget.center,
            child: const Icon(
              EneftyIcons.textalign_center_outline,
              color: Color(0xffffffff),
              size: 20,
            ),
          ),
          GestureDetector(
            onTap: widget.right,
            child: const Icon(
              EneftyIcons.textalign_justifyright_outline,
              color: Color(0xffffffff),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
