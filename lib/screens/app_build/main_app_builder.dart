import 'dart:developer';

import 'package:clever_tech/screens/app_build/account_flow/account_screen.dart';
import 'package:clever_tech/screens/app_build/automation_flow/automation.dart';
import 'package:clever_tech/screens/app_build/home/home_screen.dart';
import 'package:clever_tech/screens/app_build/new_device_flow/add_new_device.dart';
import 'package:clever_tech/screens/app_build/report_flow/report_screen.dart';
import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/screens/pop_up_build/room_flow/main_room.dart';
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

class _MainAppState extends State<MainApp> {
  bool showAppbar = true;
  int selectedIndex = 0;
  var appBarHeight = AppBar().preferredSize.height;

  late List<bool> setVisibility;

  List pages = [
    const Home(),
    const Automation(),
    const Reports(),
    const Account(),
    // const EditAccount(),
  ];

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

  void showAppBar(int index) {
    switch (index) {
      case 3:
        setState(() {
          showAppbar = false;
        });
        break;
      default:
        setState(() {
          showAppbar = true;
        });
    }
  }

  List<bool> setPopUp() {
    final list = [true, true, false];
    return list;
  }

  void formatPopUp(int index, List<bool> list) {
    switch (index) {
      case 0:
        setState(() {
          list[0] = true;
          list[2] = false;
        });
        break;
      case 1:
        setState(() {
          list[0] = false;
          list[2] = true;
        });
        break;
      default:
        setState(() {
          list[0] = true;
          list[1] = true;
          list[2] = true;
        });
    }
  }

  @override
  void initState() {
    setVisibility = setPopUp();
    super.initState();
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
                      if (setVisibility[0] == true)
                        const KPopUpMenuItem(
                          name: 'New Device',
                          icons: deviceIcon,
                          // topMargin: 26,
                        ),
                      if (setVisibility[0] == true)
                        const PopupMenuDivider(
                          height: 1,
                        ),
                      if (setVisibility[1] == true)
                        const KPopUpMenuItem(
                          name: 'New Room',
                          icons: deviceIcon,
                        ),
                      if (setVisibility[2] == true)
                        const PopupMenuDivider(
                          height: 1,
                        ),
                      if (setVisibility[2] == true)
                        const KPopUpMenuItem(
                          name: 'New Scene',
                          icons: deviceIcon,
                          // bottomMargin: 26,
                        ),
                    ];
                  },
                ),
              ),
              centerTitle: true,
            )
          : null,
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        indicatorColor: colorGreen.withAlpha(100),
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          showAppBar(index);
          formatPopUp(index, setVisibility);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_rounded),
            label: 'Automation',
          ),
          NavigationDestination(
            icon: Icon(Icons.insert_chart),
            label: 'Report',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class KPopUpMenuItem extends PopupMenuEntry<PopUp> {
  final String name;
  final String icons;
  final double topMargin;
  final double bottomMargin;

  const KPopUpMenuItem({
    super.key,
    this.topMargin = 16,
    this.bottomMargin = 16,
    required this.name,
    required this.icons,
  });

  @override
  State createState() => _KPupUpMenueItem();

  @override
  double get height => 56;

  @override
  bool represents(Object? value) {
    return value is PopUp &&
        ((value == PopUp.newDevice && name == 'New Device') ||
            (value == PopUp.newRoom && name == 'New Room') ||
            (value == PopUp.newScene && name == 'New Scene'));
  }
}

class _KPupUpMenueItem extends State<KPopUpMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PopUp selectedValue;
        switch (widget.name) {
          case 'New Device':
            selectedValue = PopUp.newDevice;
            break;
          case 'New Room':
            selectedValue = PopUp.newRoom;
            break;
          case 'New Scene':
            selectedValue = PopUp.newScene;
            break;
          default:
            selectedValue = PopUp.newDevice;
        }
        Navigator.pop(context, selectedValue);
        // log('Selected popup is: ${selectedValue.toString()}');
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 26,
          right: 26,
          top: widget.topMargin,
          bottom: widget.bottomMargin,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        width: 226,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name),
            ImageIcon(
              AssetImage(widget.icons),
            ),
          ],
        ),
      ),
    );
  }
}

// Asset routes
const String deviceIcon = 'assets/icons/hospital.png';
const String roomIcon = 'assets/icons/message-add.png';
const String sceneIcon = 'assets/icons/message-add.png';
