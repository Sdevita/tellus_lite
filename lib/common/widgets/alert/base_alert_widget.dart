import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';
import 'package:telluslite/common/widgets/button/tl_button.dart';

class BaseAlertWidget extends StatelessWidget {
  final String title;
  final Widget messageWidget;
  final String message;
  final TextAlign titleAlign;
  final TextAlign messageAlign;
  final String buttonText;
  final bool isButtonVisible;
  final Widget image;
  final VoidCallback onButtonPressed;
  final bool smallButton;
  final double buttonSmallWidth;

  BaseAlertWidget({
    @required this.title,
    this.message,
    this.messageWidget,
    this.buttonText,
    this.titleAlign = TextAlign.left,
    this.messageAlign = TextAlign.left,
    this.image,
    this.smallButton = true,
    this.buttonSmallWidth,
    this.isButtonVisible = false,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: ECText(
              title,
              align: titleAlign,
            ),
          ),
          Expanded(
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Center(
                  child: image,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    child: messageWidget == null
                        ? ECText(
                            message,
                            align: messageAlign,
                          )
                        : messageWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Visibility(
                      visible: isButtonVisible, child: _buildButton(context)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return LimitedBox(
      child: TLButton(
        text: buttonText,
        onTap: () {
          onButtonPressed();
        },
      ),
    );
  }

}
