import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/widgets/text_widget.dart';
import 'package:flutter/material.dart';


SnackBar kSnackBar(String message) {
  return SnackBar(
    content: Container(
      alignment: Alignment.centerLeft,
      height: 60,
      child: KText(
        text: message,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 2,
    backgroundColor: colorGreen,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}
