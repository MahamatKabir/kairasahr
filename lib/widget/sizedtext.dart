import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SizedText extends StatelessWidget {
  final String text;
  final Color color;

  const SizedText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    final Size textSize = _textSize(text);
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          child: const HeroIcon(
            HeroIcons.calendar,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 10, color: color, fontWeight: FontWeight.w400),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.clip,
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: text,
            style: TextStyle(
                fontSize: 16, color: color, fontWeight: FontWeight.w700)),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
