import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowWrap extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool clip;
  final double borderRadius;

  ShadowWrap(
      {@required this.child,
      this.color = Colors.black26,
      this.clip = true,
      this.borderRadius = 25});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: color, offset: Offset(0, 5), blurRadius: 20)
      ]),
      child: ClipRRect(
        borderRadius:
            clip ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
        child: Wrap(
          children: <Widget>[
            Container(
              child: child,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
