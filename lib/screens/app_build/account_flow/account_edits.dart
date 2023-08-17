import 'dart:developer';

import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/widgets/button_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  bool isEditable = true;
  final _auth = FirebaseAuth.instance;
  late String profileName = '';
  late TextEditingController? _name = TextEditingController();

  Widget _profilePhoto() {
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
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/image_a.jpg'),
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

  Widget _profileName() {
    const String name = 'Timothy';
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
            profileName,
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
                      getCurrentUser();
                      changeState();
                    } on FirebaseAuthException catch (e) {
                      log(e.code);
                    }
                  })),
        ],
      ),
    );
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          profileName = user.displayName!;
        });
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }

  void changeState(){
    setState(() {
      isEditable = !isEditable;
    });
  }

  @override
  void initState() {
    _name = TextEditingController();
    super.initState();

    getCurrentUser();
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
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 17, left: 17),
        child: Column(
          children: [
            _profilePhoto(),
            const SizedBox(height: 16),
            GestureDetector(
                onTap: () {
                  changeState();
                  log(isEditable.toString());
                },
                child: Visibility(visible: isEditable,child: _profileName(),),),
             Visibility(visible: !isEditable,child: _updateName(),),
            const SizedBox(height: 16),
            _profileTime(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
