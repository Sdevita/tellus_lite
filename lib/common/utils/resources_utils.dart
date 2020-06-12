import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class ResourcesUtils {
  static Widget getPng(String image,
      {double width,
        double height,
        Color color,
        BoxFit fit = BoxFit.contain,
        Alignment alignment = Alignment.center}) {
    String assetPath = "assets/image/$image.png";

    return Image.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
      fit: fit,
      alignment: alignment,
    );
  }

  static Widget getSvg(String image,
      {double width,
        double height,
        Color color,
        BoxFit fit = BoxFit.contain,
        Alignment alignment = Alignment.center}) {
    String assetPath = "assets/image/svg/$image.svg";

    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
      fit: fit,
      allowDrawingOutsideViewBox: true,
      alignment: alignment,
    );
  }
}
