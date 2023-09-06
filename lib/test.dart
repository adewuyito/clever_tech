import 'dart:developer';
import 'dart:io';
import 'package:clever_tech/widgets/snackbar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  String profilePicture = '';

  Reference referenceRoot = FirebaseStorage.instance.ref();

  setImage(XFile file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceDirImages = referenceRoot.child('profile_pictures');

    Reference referenceImage = referenceDirImages.child(fileName);

    try {
      await referenceImage.putFile(File(file.path));
      profilePicture = await referenceImage.getDownloadURL();
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker from Gallery"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  await setImage(image!);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(kSnackBar('No image selected'));
                }
                setState(() {
                  //update UI
                });
              },
              child: const Text("Pick Image"),
            ),
            image == null ? Container() : Image.file(File(image!.path))
          ],
        ),
      ),
    );
  }
}
