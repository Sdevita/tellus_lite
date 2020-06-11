import 'dart:ui' as ui;

import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  final Widget body;
  final Widget appBar;
  final bool loader;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final Color backgroundColor;

  BaseWidget(
      {@required this.body,
      this.appBar,
      this.safeAreaTop = true,
      this.safeAreaBottom = true,
      this.loader = false,
      this.backgroundColor});

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          SafeArea(
            top: widget.safeAreaTop,
            bottom: widget.safeAreaBottom,
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
          widget.loader ? _buildLoader() : IgnorePointer()
        ],
      ),
    );
  }

  _buildLoader() {
    return Container(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white12),
          child: Center(
            child: AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
