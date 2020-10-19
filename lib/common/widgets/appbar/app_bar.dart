import 'package:flutter/material.dart';

class TellusAppBar extends StatelessWidget {
  final VoidCallback onLeftButtonTapped;
  final Widget leftIcon;
  final Widget title;
  final Widget rightIcon;

  TellusAppBar({this.onLeftButtonTapped, this.leftIcon, this.title, this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        leftIcon != null
            ? InkWell(
                child: leftIcon,
                onTap: onLeftButtonTapped ?? () {},
              )
            : IgnorePointer(),
        Expanded(child: title ?? Container()),
        rightIcon ?? Container(height: 48, width: 48,)
      ],
    );
  }
}
