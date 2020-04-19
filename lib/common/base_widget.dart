import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  final Widget body;
  final Widget appBar;
  final bool loader;
  final Color backgroundColor;

  BaseWidget(
      {@required this.body,
      this.appBar,
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
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              children: <Widget>[
                widget.appBar != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: widget.appBar,
                      )
                    : IgnorePointer(),
                Expanded(child: widget.body),
              ],
            ),
          ),
          widget.loader
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : IgnorePointer()
        ],
      ),
    );
  }
}
