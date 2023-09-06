import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ErrorPickingImage implements Exception {}

class LocalImage {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        return image;
      }
      log("No image selected");
      return null;
    } catch (_) {
      throw ErrorPickingImage();
    }
  }

}
