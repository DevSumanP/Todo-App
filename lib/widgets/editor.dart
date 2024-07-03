import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Editor extends StatefulWidget {
  final Function()? justify;
  final Function()? left;
  final Function()? center;
  final Function()? right;
  const Editor({super.key, this.justify, this.left, this.center, this.right});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
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
          const Icon(
            EneftyIcons.text_bold_outline,
            color: Color(0xffffffff),
            size: 20,
          ),
          const Icon(
            EneftyIcons.text_italic_outline,
            color: Color(0xffffffff),
            size: 20,
          ),
          const Icon(
            EneftyIcons.text_underline_outline,
            color: Color(0xffffffff),
            size: 20,
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
