import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final VoidCallback onLeftWidgetTapped;
  final Widget leftWidget;
  final Widget centerWidget;
  final VoidCallback onRightWidgetTapped;
  final Widget rightWidget;
  AppNavigationBar(
      {this.onLeftWidgetTapped,
      this.leftWidget,
      @required this.centerWidget,
      this.rightWidget,
      this.onRightWidgetTapped});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        leftWidget != null
            ? Flexible(
                child: InkWell(
                  child: leftWidget,
                  onTap: onLeftWidgetTapped ?? () {},
                ),
              )
            : IgnorePointer(),
        Expanded(
          child: centerWidget,
        ),
        rightWidget != null
            ? Flexible(
                child: InkWell(
                  child: rightWidget,
                  onTap: onRightWidgetTapped ?? () {},
                ),
              )
            : IgnorePointer(),
      ],
    );
  }
}
