import 'package:flutter/material.dart';

class TellusAppBar extends StatelessWidget {
  final VoidCallback onLeftButtonTapped;
  final IconData leftIcon;
  final Color leftIconColor;

  TellusAppBar(
      {this.onLeftButtonTapped,
      this.leftIcon,
      this.leftIconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        leftIcon != null
            ? IconButton(
                icon: Icon(
                  leftIcon,
                  color: leftIconColor,
                ),
                onPressed: onLeftButtonTapped ?? () {},
              )
            : IgnorePointer()
      ],
    );
  }
}
