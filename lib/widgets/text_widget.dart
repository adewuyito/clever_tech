import 'package:clever_tech/data/colors.dart';
import 'package:flutter/material.dart';

class KText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final double? fontSpacing;
  final FontWeight? weight;
  final bool? textCenterAlign;

  const KText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.fontSpacing,
    this.weight,
    this.textCenterAlign = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign:
            (textCenterAlign == true) ? TextAlign.center : null,
        style: TextStyle(
          fontFamily: 'SFTS',
          color: color ?? colorBlack2,
          fontSize: fontSize,
          fontWeight: weight,
          letterSpacing: fontSpacing,
        ));
  }
}
