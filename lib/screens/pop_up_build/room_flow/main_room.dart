import 'dart:developer';
import 'dart:io';

import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/services/image_picker_service.dart';
import 'package:clever_tech/widgets/button_widgets.dart';
import 'package:clever_tech/widgets/snackbar_widget.dart';
import 'package:clever_tech/widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  PageController controller = PageController();
  List<Widget> screens = [
    const SetName(),
    const SetRoom(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: SmoothPageIndicator(
          controller: controller,
          count: 2,
          effect: WormEffect(
            dotWidth: 28,
            dotHeight: 4,
            activeDotColor: colorGreen,
            dotColor: colorGrey.withOpacity(0.6),
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 17, right: 17, top: 40),
        child: PageView(
          controller: controller,
          children: screens,
        ),
      ),
    );
  }
}

class SetName extends StatefulWidget {
  const SetName({super.key});

  @override
  State<SetName> createState() => _SetNameState();
}

class _SetNameState extends State<SetName> {
  TextEditingController controller = TextEditingController();

  final String header = 'Set name of room';
  final String subHeader =
      'Set a unique name for your room for further identification';

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        KText(
          text: header,
          fontSize: 28,
          fontSpacing: 0.36,
          weight: FontWeight.w600,
          textCenterAlign: true,
        ),
        const SizedBox(
          height: 8,
        ),
        KText(
          text: subHeader,
          fontSize: 16,
          color: colorGrey2,
          textCenterAlign: true,
        ),
        const SizedBox(height: 48),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            label: const Text('Room name'),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(
              color: colorGrey2,
              fontWeight: FontWeight.w600,
              fontFamily: 'SFTS',
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const EButton(label: 'Next step'),
      ]),
    );
  }
}

class SetRoom extends StatefulWidget {
  const SetRoom({super.key});

  @override
  State<SetRoom> createState() => _SetRoomState();
}

class _SetRoomState extends State<SetRoom> {
  // Set image
  bool withImage = false;

  //Header strings
  final String header = 'Set photo of room';
  final String subHeader =
      'Take a photo of your room and select an icon for further identification';

  // Setting image
  XFile? image;
  LocalImage localImage = LocalImage();
  String imageName = '';

  // Firebase Refrence
  Reference referenceRoot = FirebaseStorage.instance.ref();

  // Functions
  setImage(XFile file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceDirImages = referenceRoot.child('profile_pictures');

    Reference referenceImage = referenceDirImages.child(fileName);

    try {
      await referenceImage.putFile(File(file.path));
      imageName = await referenceImage.getDownloadURL();
    } catch (_) {
      log(_.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KText(
          text: header,
          fontSize: 28,
          fontSpacing: 0.36,
          weight: FontWeight.w600,
          textCenterAlign: true,
        ),
        const SizedBox(
          height: 8,
        ),
        KText(
          text: subHeader,
          fontSize: 16,
          color: colorGrey2,
          textCenterAlign: true,
        ),
        const SizedBox(height: 48),
        Container(
          height: 239,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: colorGrey2.withOpacity(.4),
          ),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomLeft,
                children: [
                  !withImage
                      ? Container(
                          width: double.infinity,
                          height: 153,
                          alignment: Alignment.center,
                          color: colorGrey2.withOpacity(.6),
                          child: Icon(
                            Icons.add_rounded,
                            color: colorBlack.withOpacity(.6),
                          ),
                        )
                      : Image.file(
                          File(image!.path),
                          fit: BoxFit.fitWidth,
                          height: 153,
                          width: double.infinity,
                          alignment: const Alignment(0.7, 0.5),
                        ),
                  Positioned.directional(
                    textDirection: TextDirection.ltr,
                    start: 10,
                    bottom: -15,
                    child: Container(
                      width: 50,
                      height: 45,
                      decoration: BoxDecoration(
                        color: colorGreen,
                        border: Border.all(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final XFile? local;
                          local =
                              await localImage.pickImage(ImageSource.gallery);
                          if (local != null) {
                            setState(() {
                              image = local;
                            });
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                kSnackBar('No image selected'),
                              );
                            }
                          }
                          setState(() {
                            if ((withImage == false) && (image != null)) {
                              withImage = !withImage;
                            }
                          });
                        },
                        child:
                            const Icon(Icons.add_rounded, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 86,
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  bottom: 4,
                ),
                child: const KText(
                  text: 'Living Room',
                  fontSize: 17,
                  weight: FontWeight.w600,
                  fontSpacing: -0.07,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        EButton(
          label: 'Save',
          onPressed: () async {
            await setImage(image!);
          },
        ),
      ],
    );
  }
}
