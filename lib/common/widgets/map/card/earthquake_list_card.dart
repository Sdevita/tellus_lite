import 'package:flutter/material.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';

import '../../limited_text_box.dart';

class EarthQuakeListCard extends StatelessWidget {
  final String title;
  final double magnitude;
  final Color topCardColor;
  final double cardPadding;
  final double cardHeight;
  final double cardWidth;
  final VoidCallback onTopTapped;

  const EarthQuakeListCard(
      {Key key,
      this.title,
      this.magnitude,
      this.topCardColor,
      this.cardPadding,
      this.cardHeight,
      @required this.onTopTapped,
      this.cardWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = cardPadding ?? 10.0;
    var mediaQuery = MediaQuery.of(context);
    var height = cardHeight ?? mediaQuery.size.height / 5;
    var theme = Theme.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: EdgeInsets.all(padding),
      color: Colors.transparent,
      height: height,
      child: Stack(
        children: <Widget>[
          //_buildBottomCard(context, height, theme),
          _buildTopCard(context, height, theme, mediaQuery),
          _buildMagnitude(context, theme),
        ],
      ),
    );
  }

  _buildMagnitude(BuildContext context, ThemeData theme) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        decoration:
            BoxDecoration(color: theme.buttonColor, shape: BoxShape.circle),
        height: 50,
        width: 50,
        child: Center(
          child: ECText(
            magnitude.toString(),
            fontSize: 15,
            autoResize: true,
            overflow: TextOverflow.fade,
            color: theme.accentColor,
          ),
        ),
      ),
    );
  }

  _buildTopCard(BuildContext context, double height, ThemeData theme,
      MediaQueryData mediaQuery) {
    return Positioned(
      top: 25,
      left: 0,
      right: 0,
      child: InkWell(
        onTap: onTopTapped,
        child: Container(
          height: height / 2,
          decoration: BoxDecoration(
              color: topCardColor ?? theme.backgroundColor,
              borderRadius: BorderRadius.circular(15)),
          child: LimitedBox(
            maxWidth: mediaQuery.size.width / 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ECText(
                      title,
                      fontSize: 15,
                      autoResize: true,
                      overflow: TextOverflow.fade,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomCard(BuildContext context, double height, ThemeData theme) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          height: height / 2,
          decoration: BoxDecoration(
              color: topCardColor ?? Colors.white30,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Center(
            child: Text(title),
          )),
    );
  }
}
