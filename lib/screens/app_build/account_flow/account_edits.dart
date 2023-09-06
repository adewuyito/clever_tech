import 'dart:developer';
import 'dart:io';

import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/features/auth/auth_service.dart';
import 'package:clever_tech/services/image_picker_service.dart';
import 'package:clever_tech/widgets/button_widgets.dart';
import 'package:clever_tech/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  bool isEditable = true;
  final _auth = FirebaseAuth.instance;
  LocalImage localImage = LocalImage();
  Reference referenceRoot = FirebaseStorage.instance.ref();
  late TextEditingController? _name = TextEditingController();

  late XFile? image;

  setImage(XFile file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceDirImages = referenceRoot.child('profile_pictures');

    Reference referenceImage = referenceDirImages.child(fileName);

    try {
      await referenceImage.putFile(File(file.path));
      final profileImage = await referenceImage.getDownloadURL();
      await AuthService.firebase().updateProfilePicture(photoUrl: profileImage);
    } catch (_) {
      log(_.toString());
    }
  }

  Widget _profilePhoto(String? image) {
    return Container(
      height: 95,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorGrey3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text('Profile photo',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -.41,
                )),
          ),
          CircleAvatar(
            backgroundColor: colorGrey2,
            radius: 26,
            child: image != null
                ? ClipOval(
                    child: Image(
                      image: NetworkImage(image),
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  )
                : const ClipOval(
                    child: Image(
                      image: AssetImage(
                        'assets/icons/profile_image.png',
                      ),
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          const SizedBox(
            width: 16,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorGrey3,
          ),
        ],
      ),
    );
  }

  Widget _profileName(String name) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorGrey3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Profile name',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: -.41,
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 13, letterSpacing: -0.08, color: colorGrey2),
          ),
          const SizedBox(
            width: 16,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorGrey3,
          ),
        ],
      ),
    );
  }

  Widget _profileTime() {
    const String name = 'Not Set';

    return Container(
      height: 70,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorGrey3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Time zone',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: -.41,
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 13, letterSpacing: -0.08, color: colorGrey2),
          ),
          const SizedBox(
            width: 16,
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: colorGrey3,
          ),
        ],
      ),
    );
  }

  Widget _updateName() {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(
            color: colorGrey3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: _name ?? TextEditingController(text: 'N/A'),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter a name',
                hintStyle: TextStyle(
                  fontSize: 13,
                  letterSpacing: -0.08,
                  color: colorGrey2,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: EButton(
              label: 'Save',
              onPressed: () async {
                final name = _name?.text;
                final user = _auth.currentUser;
                try {
                  await user!.updateDisplayName(name);
                  user.reload();
                  changeState();
                } on FirebaseAuthException catch (e) {
                  log(e.code);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void changeState() {
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  void initState() {
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'SFTS',
          fontSize: 17,
          color: colorBlack2,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: StreamBuilder<User?>(
        stream: _auth.userChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          final displayName = user?.displayName ?? 'N/A';
          final profileImage = user?.photoURL;

          return SafeArea(
            minimum: const EdgeInsets.only(right: 17, left: 17),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    image = await localImage.pickImage(ImageSource.gallery);
                    if (image != null) {
                      await setImage(image!);
                    } else {
                      if (mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(kSnackBar('No image selected'));
                      }
                    }
                  },
                  child: _profilePhoto(profileImage),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    changeState();
                    log(isEditable.toString());
                  },
                  child: Visibility(
                    visible: isEditable,
                    child: _profileName(displayName),
                  ),
                ),
                Visibility(
                  visible: !isEditable,
                  child: _updateName(),
                ),
                const SizedBox(height: 16),
                _profileTime(),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
