import 'package:flutter/material.dart';

class LimitedTextBox extends StatelessWidget {
  final double maxWidth;
  final String text;
  final Color textColor;
  final TextOverflow textOverflow;
  final double fontSize;
  final int maxLines;

  const LimitedTextBox(
      {Key key,
      this.maxWidth,
      @required this.text,
      this.fontSize,
      this.textColor,
      this.maxLines,
      this.textOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var theme = Theme.of(context);
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth ?? mq.size.width * 0.8),
      child: Text(
        text,
        maxLines: maxLines ?? defaultTextStyle.maxLines,
        style: TextStyle(
            fontSize: fontSize ?? 15, color: textColor ?? theme.primaryColor),
        overflow: textOverflow ?? TextOverflow.fade,
      ),
    );
  }
}
