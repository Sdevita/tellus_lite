import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {

  final Widget icon;

  final Widget text;

  final double padding;

  const IconLabel({Key key, @required this.icon, @required this.text, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        Container(
            padding: EdgeInsets.only(left: padding?? 16.0),
            child: text)
      ],
    );
  }
}
