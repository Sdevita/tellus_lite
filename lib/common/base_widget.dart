import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  final Widget body;
  final bool loader;
  final Color backgroundColor;

  BaseWidget(
      {
      @required this.body,
      this.loader = false,
      this.backgroundColor = Colors.white});

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            widget.body,
            widget.loader? Center(child: CircularProgressIndicator(),) : IgnorePointer()
          ],
        ),
      ),
    );
  }
}
