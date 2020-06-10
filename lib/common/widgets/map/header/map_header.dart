import 'package:flutter/material.dart';

class MapHeader extends StatefulWidget {
  @override
  _MapHeaderState createState() => _MapHeaderState();
}

class _MapHeaderState extends State<MapHeader> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
