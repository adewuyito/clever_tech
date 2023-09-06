import 'dart:developer';
import 'package:clever_tech/screens/app_build/account_flow/account_screen.dart';
import 'package:clever_tech/screens/app_build/automation_flow/automation.dart';
import 'package:clever_tech/screens/app_build/home/home_screen.dart';
import 'package:clever_tech/screens/app_build/new_device_flow/add_new_device.dart';
import 'package:clever_tech/screens/app_build/report_flow/report_screen.dart';
import 'package:clever_tech/data/colors.dart';
import 'package:flutter/material.dart';

import 'automation_flow/new_automation/main_automation.dart';

enum PopUp {
  newDevice,
  newRoom,
  newScene,
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

/// TODO Implement Remaining automation pages.
class _MainAppState extends State<MainApp> {
  bool showAppbar = true;
  var appBarHeight = AppBar().preferredSize.height;
  List pages = [
    const Home(),
    const Automation(),
    const Reports(),
    const Account(),
    // const EditAccount(),
  ];
  List pagesTitle = [
    const Home(),
    const Automation(),
    const Reports(),
    const Account(),
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

  String setTitle() {
    switch (selectedIndex) {
      case 0:
        return 'My Home';
      case 1:
        return 'Automation';
      case 2:
        return 'Reports';
      default:
        return 'My Home';
    }
  }

  void setIndex(int value) {
    setState(
      () {
        selectedIndex = value;
        if (selectedIndex == 3) {
          setState(() {
            showAppbar = !showAppbar;
          });
        } else {
          showAppbar = true;
        }
      },
    );
  }

  Widget setVisibility({
    required int index,
    required int hideAt,
    required Row child,
  }) {
    bool visibility = true;
    if (index == hideAt) {
      setState(() {
        visibility = true;
      });
    } else {
      setState(() {
        visibility = false;
      });
    }
    return Visibility(
      visible: visibility,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: showAppbar
          ? AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              scrolledUnderElevation: 0.0,
              elevation: 0,
              title: Text(
                setTitle(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SFTS',
                  fontSize: 24,
                ),
              ),
              leading: Container(
                // width: 274,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: colorGrey3,
                ),
                margin: const EdgeInsets.only(left: 12, top: 26),
                child: PopupMenuButton<PopUp>(
                  surfaceTintColor: Colors.white,
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  offset: Offset(0.0, appBarHeight),
                  icon: const Icon(Icons.add),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const NewDevice()));
                          },
                          padding: const EdgeInsets.all(24),
                          child: setVisibility(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Add new device'),
                                ImageIcon(
                                  AssetImage('assets/icons/hospital.png'),
                                ),
                              ],
                            ),
                            index: selectedIndex,
                            hideAt: 0,
                          )),
                      const PopupMenuDivider(),
                      const PopupMenuItem(
                          padding: EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Add new room'),
                              ImageIcon(
                                AssetImage('assets/icons/message-add.png'),
                              )
                            ],
                          )),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MainAutomation()));
                        },
                        padding: const EdgeInsets.all(24),
                        child: setVisibility(
                          index: selectedIndex,
                          hideAt: 1,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Add new scene'),
                              ImageIcon(
                                AssetImage('assets/icons/message-add.png'),
                              )
                            ],
                          ),
                        ),
                      ),
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
            icon: Icon(Icons.add_box_rounded),
            label: 'Automation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
