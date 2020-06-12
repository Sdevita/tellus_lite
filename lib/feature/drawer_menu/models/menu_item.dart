import 'package:flutter/material.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';
import 'package:telluslite/common/widgets/labels/icon_label.dart';

/// MenuItem widget is used to populate
/// [DrawerMenu] menu list.
class MenuItem extends StatelessWidget {
  final Widget icon;
  final String text;
  final Color textColor;
  final Function onPressed;
  final Widget rightIcon;

  const MenuItem(
      {Key key, this.icon, this.text, this.onPressed, this.rightIcon, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: IconLabel(
              icon: icon,
              text: ECText(
                text,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor ?? Theme.of(context).primaryColor,
              )),
          onTap: onPressed,
        ),
        rightIcon?? SizedBox()
      ],
    );
  }
}