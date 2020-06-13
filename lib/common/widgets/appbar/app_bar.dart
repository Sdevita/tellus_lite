import 'package:flutter/material.dart';

class TellusAppBar extends StatelessWidget {
  final VoidCallback onLeftButtonTapped;
  final Widget leftIcon;

  TellusAppBar(
      {this.onLeftButtonTapped,
      this.leftIcon});

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
            : IgnorePointer()
      ],
    );
  }
}
