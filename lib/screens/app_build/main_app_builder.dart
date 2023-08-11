import 'dart:developer';

import 'package:clever_tech/data/fireBase/fire_base_auth.dart';
import 'package:clever_tech/screens/app_build/account_edits.dart';
import 'package:clever_tech/screens/app_build/account_screen.dart';
import 'package:clever_tech/screens/app_build/automation.dart';
import 'package:clever_tech/screens/app_build/home_screen.dart';
import 'package:clever_tech/screens/app_build/report_screen.dart';
import 'package:clever_tech/data/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum PopUp {
  newDevice,
  newRoom,
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool showAppbar = true;
  var appBarHeight = AppBar().preferredSize.height;
  final User? user = AuthenticationService().currentUser;
  List pages = [
    const Home(),
    const Automation(),
    const Reports(),
    Account(),
    // const EditAccount(),
  ];
  int selectedIndex = 0;

  hideAppbar() {
    log(selectedIndex.toString());
    if (selectedIndex == 3) {
      setState(() {
        showAppbar = !showAppbar;
      });
    } else {
      showAppbar = true;
    }
  }

  void setIndex(int value) => setState(() {
        selectedIndex = value;
        if (selectedIndex == 3) {
          setState(() {
            showAppbar = !showAppbar;
          });
        } else {
          showAppbar = true;
        }
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showAppbar
          ? AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'My Home',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SFTS',
                  fontSize: 24,
                ),
              ),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: colorGrey3,
                ),
                margin: const EdgeInsets.only(left: 12, top: 26),
                child: PopupMenuButton<PopUp>(
                  // color: ,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  offset: Offset(0.0, appBarHeight),
                  icon: const Icon(Icons.add),
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                          padding: EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Add new device'),
                              ImageIcon(
                                AssetImage('assets/icons/hospital.png'),
                              ),
                            ],
                          )),
                      PopupMenuDivider(),
                      PopupMenuItem(
                          padding: EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Add new room'),
                              ImageIcon(
                                AssetImage('assets/icons/message-add.png'),
                              )
                            ],
                          ))
                    ];
                  },
                ),
              ),
              centerTitle: true,
            )
          : null,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: colorGreen,
        enableFeedback: false,
        onTap: setIndex,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded), label: 'Automation'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
