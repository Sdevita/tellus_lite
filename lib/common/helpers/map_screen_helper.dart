import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenHelper {
  static Future<BitmapDescriptor> getMarker(
      {bool isSelected = false, double magnitude = 0.0}) async {

    String svgString = await rootBundle.loadString('assets/image/svg/marker.svg');
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

    double size = 100;

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(size, size));
    ui.Image image = await picture.toImage(size.toInt(), size.toInt());

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final paint1 = ui.Paint();//getStatusColor(marker, isSelected);
    paint1.color = Colors.greenAccent.withOpacity(.5);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 3.2, paint1);
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());

    final img = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());

    var data = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());

  }
}