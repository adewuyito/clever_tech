import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class LocalImage {

  final ImagePicker _imagePicker = ImagePicker();

  pickImage (ImageSource source, BuildContext context) async {
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null){
      return await _file.readAsBytes();
    }
    else{
      return null;
    }
  }

}