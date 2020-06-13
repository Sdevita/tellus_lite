import 'dart:ui' as ui;

import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:telluslite/feature/drawer_menu/drawer_widget.dart';

class BaseWidget extends StatefulWidget {
  final Widget body;
  final Widget appBar;
  final bool loader;
  final bool hasDrawer;
  final bool showSafeAreaTop;
  final bool showSafeAreaBottom;

  BaseWidget(
      {@required this.body,
      this.appBar,
      this.loader = false,
      this.showSafeAreaTop = true,
      this.showSafeAreaBottom = false,
      this.hasDrawer = false});

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: widget.hasDrawer
            ? DrawerMenu(child: _buildStack(context))
            : _buildStack(context));
  }

  Stack _buildStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
            top: widget.showSafeAreaTop,
            bottom: widget.showSafeAreaBottom,
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(
                        top: 0,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: widget.body),
              ],
            )),
        widget.loader ? _buildLoader() : IgnorePointer(),
      ],
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
