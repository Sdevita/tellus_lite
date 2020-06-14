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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        leftWidget != null
            ? Flexible(
                child: InkWell(
                  splashColor: Colors.transparent,
                  child:
                      Padding(padding: EdgeInsets.all(20), child: leftWidget),
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
                  splashColor: Colors.transparent,
                  child:
                      Padding(padding: EdgeInsets.all(20), child: rightWidget),
                  onTap: onRightWidgetTapped ?? () {},
                ),
              )
            : IgnorePointer(),
      ],
    );
  }
}
