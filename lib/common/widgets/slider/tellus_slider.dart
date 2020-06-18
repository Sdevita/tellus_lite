import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';

class TellusSlider extends StatelessWidget {
  final int maxValue;
  final Function(double) onChange;
  final int defaultValue;
  final int minValue;
  final String unit;
  final int step;
  final bool isInt;
  final String leftLabel;

  TellusSlider({
    this.maxValue,
    this.onChange,
    this.defaultValue,
    this.minValue,
    this.unit = " Km",
    this.leftLabel = "",
    this.step,
    this.isInt = false,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: <Widget>[
        FlutterSlider(
          min: minValue.toDouble(),
          max: maxValue.toDouble(),
          values: [defaultValue.truncateToDouble()],
          step: FlutterSliderStep(step: step?.toDouble() ?? 100),
          trackBar: FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(11 / 2)),
            inactiveTrackBar: BoxDecoration(
                color: theme.primaryColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(11 / 2)),
            activeTrackBarHeight: 7,
            inactiveTrackBarHeight: 5,
          ),
          tooltip: FlutterSliderTooltip(
            custom: (value) {
              final printedValue = isInt ? value.toString().split(".")[0] : value.toString();
              return ECText(
                leftLabel + " " +printedValue + unit,
                fontSize: 15,
                color: theme.primaryColor,
              );
            },
            positionOffset: FlutterSliderTooltipPositionOffset(
                top: 50 //with 25 is above the slider
                ),
            alwaysShowTooltip: true,
          ),
          handler: FlutterSliderHandler(
              child: Icon(
                Icons.radio_button_unchecked,
                color: theme.primaryColor,
                size: 30,
              ),
              decoration: BoxDecoration()),
          handlerAnimation: FlutterSliderHandlerAnimation(scale: 1.2),
          onDragCompleted: (index, value, _) {
            onChange(value);
          },
        ),
      ],
    );
  }
}
