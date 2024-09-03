import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie1/Theme/dark_theme.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  double? height;
  ExpandableText({super.key, required this.text, this.height});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  late int character;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    if (widget.height == null) {
      character = 190;
    } else {
      character = (widget.height! / 8).floor();
    }

    if (widget.text.length > character) {
      firstHalf = widget.text.substring(0, character);
      secondHalf = widget.text.substring(character, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(
        TextSpan(
          style: darkTheme.textTheme.bodyMedium,
          children: [
            TextSpan(text: isExpanded ? widget.text : firstHalf),
            if (!isExpanded) ...[
              const TextSpan(text: '...'),
              TextSpan(
                text: 'show more',
                style: TextStyle(
                  color: darkTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      isExpanded = true;
                    });
                  },
              ),
            ],
            if (isExpanded && secondHalf.isNotEmpty) ...[
              TextSpan(text: secondHalf),
              TextSpan(
                text: 'show less',
                style: TextStyle(
                  color: darkTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      isExpanded = false;
                    });
                  },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
