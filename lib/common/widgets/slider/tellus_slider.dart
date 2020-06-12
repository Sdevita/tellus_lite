import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_thumb_slider_circle.dart';

class TellusSlider extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final double initialValue;
  final fullWidth;
  final MaterialColor firstGradientColor;
  final MaterialColor secondGradientColor;
  final ValueChanged<double> onChanged;
  final Color backgroundColor;
  final Color controlsColor;

  TellusSlider(
      {this.sliderHeight = 48,
      this.initialValue = 0,
      this.max = 10,
      this.min = 0,
      this.fullWidth = false,
      @required this.onChanged,
      this.firstGradientColor,
      this.secondGradientColor,
      this.backgroundColor = Colors.white,
      this.controlsColor});

  @override
  _TellusSliderState createState() => _TellusSliderState();
}

class _TellusSliderState extends State<TellusSlider> {
  double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${this.widget.min}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.green.withOpacity(1),
                    inactiveTrackColor: Colors.green.withOpacity(.5),

                    trackHeight: 4.0,
                    thumbShape: CustomThumbSliderCircle(
                        thumbRadius: this.widget.sliderHeight * .4,
                        min: this.widget.min,
                        max: this.widget.max,
                        thumbColor: Colors.white10),
                    overlayColor: Colors.green.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.green,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
                  ),
                  child: Slider(
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          widget.onChanged(value);
                          _value = value;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              width: this.widget.sliderHeight * .1,
            ),
            Text(
              '${this.widget.max}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
