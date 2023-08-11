import 'dart:developer';

import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/features/auth/auth_service.dart';
import 'package:clever_tech/screens/app_build/account_edits.dart';
import 'package:clever_tech/screens/authentication/login_screen.dart';
import 'package:clever_tech/widgets/button_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late String userEmail = '';
  late String userFullName = '';

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          userEmail = user.email!;
          userFullName = user.displayName!;
        });
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.only(right: 17, left: 17),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AccountOptions(),
              CircleAvatar(
                backgroundColor: colorGrey3,
                radius: 50,
                child: const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/images/image_a.jpg'),
                ),
              ),
              Text(
              userFullName,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SFTS',
                    fontSize: 20),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    fontFamily: 'SFTS',
                    fontSize: 11,
                    letterSpacing: 0.07,
                    color: colorGrey2),
              ),
              Container(
                margin: const EdgeInsets.only(top: 86),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AccountCubs(
                      widgetIcons: Icons.mic,
                      widgetColor: colorPurple,
                      widgetText: 'Notification',
                    ),
                    AccountCubs(
                      widgetIcons: Icons.message_rounded,
                      widgetColor: colorPink2,
                      widgetText: 'Message center',
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 17, bottom: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AccountCubs(
                        widgetIcons: Icons.message_rounded,
                        widgetColor: colorBlue,
                        widgetText: 'FAQ'),
                    AccountCubs(
                      widgetIcons: Icons.mic,
                      widgetColor: colorGreen,
                      widgetText: 'Notification',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quick action',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.35),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(
                          color: colorGrey, fontSize: 11, letterSpacing: 0.07),
                    ),
                  ),
                ],
              ),
              const QuickActionWidget(),
              EButton(
                label: 'Sign Out',
                onPressed: () async {
                  await AuthService.firebase().logout();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountCubs extends StatelessWidget {
  final String widgetText;
  final Color widgetColor;
  final IconData widgetIcons;

  const AccountCubs(
      {super.key,
      required this.widgetColor,
      required this.widgetIcons,
      required this.widgetText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163,
      height: 115,
      decoration: BoxDecoration(
          border: Border.all(color: colorBlack2.withOpacity(0.1)),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
                color: widgetColor,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Center(
              child: Icon(
                widgetIcons,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            widgetText,
            style: const TextStyle(
                fontSize: 17,
                fontFamily: 'SFTS',
                fontWeight: FontWeight.w600,
                letterSpacing: -0.41),
          )
        ],
      ),
    );
  }
}

class QuickActionWidget extends StatefulWidget {
  const QuickActionWidget({super.key});

  @override
  State<QuickActionWidget> createState() => _QuickActionWidgetState();
}

class _QuickActionWidgetState extends State<QuickActionWidget> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: colorBlack2.withOpacity(0.1)),
      ),
      child: ListTile(
        title: const Text('Off all devices'),
        titleTextStyle: TextStyle(
            color: colorBlack2,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41),
        subtitle: const Text('Turn off all devices in all rooms'),
        subtitleTextStyle:
            TextStyle(color: colorGrey, fontSize: 11, letterSpacing: 0.07),
        trailing: Switch(
          activeTrackColor: colorGreen,
          value: isOn,
          onChanged: (bool value) {
            setState(() {
              isOn = value;
            });
          },
        ),
      ),
    );
  }
}

class AccountOptions extends StatelessWidget {
  const AccountOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EditAccount()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorGrey3,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              width: 60,
              height: 60,
              child: const Icon(Icons.edit_rounded),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: colorGrey3,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              width: 60,
              height: 60,
              child: const Icon(Icons.settings_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
