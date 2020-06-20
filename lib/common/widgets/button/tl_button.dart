import 'package:flutter/material.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';

class TLButton extends StatelessWidget {
  static const smallButtonSize = 128.0;
  final Color color;
  final Color textColor;
  final String text;
  final bool enabled;
  final bool small;
  final Widget leftIcon;
  final double smallWidth;
  final EdgeInsets margin;
  final VoidCallback onTap;

  TLButton(
      {this.onTap,
      this.text,
      this.margin = EdgeInsets.zero,
      this.enabled = true,
      this.small = false,
      this.leftIcon,
      this.smallWidth,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: margin,
      width: small ? _getSmallWidth() : MediaQuery.of(context).size.width,
      height: 40,
      color: color ?? theme.buttonColor,
      child: FlatButton(
        onPressed: this.enabled ? this.onTap : null,
        color: Colors.transparent,
        textColor: textColor ?? theme.primaryColor,
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ECText(
                  text.toUpperCase(),
                  align: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getSmallWidth() => smallWidth ?? 128.0;
}
