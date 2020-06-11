import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ECText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final TextAlign align;
  final int maxLines;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  bool autoResize;

  ECText(this.text,
      {this.fontSize,
      this.color,
      this.align,
      this.maxLines,
      this.overflow,
      this.autoResize = false,
      this.fontWeight = FontWeight.w300});

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
        fontFamily: 'Euclid',
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ?? Theme.of(context).primaryColor);

    if (autoResize) {
      return AutoSizeText(
        text,
        style: style,
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      );
    } else {
      return Text(
        text,
        style: style,
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
      );
    }
  }
}
