import 'dart:developer';

import 'package:clever_tech/constants/hive_constants.dart';
import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Automation extends StatefulWidget {
  const Automation({super.key});

  @override
  State<Automation> createState() => _AutomationState();
}

class _AutomationState extends State<Automation> {
  int activeScene = 0;
  int activeDevice = 0;
  late List<bool>? _active;
  late Box<List> _box;

  List<bool>? setItemCount() {
    List<bool>? switchState = _getBox();
    if (switchState == null) {
      return null;
    }
    Iterable<bool> trueList = switchState.where(
      (element) => element == true || element == false,
    );
    // log('Hive box holds --> ${switchState.toString()}');
    int trueState = trueList.where((element) => element == true).length;
    final count = switchState.length;
    // log('Active scense $trueState   Active Devices $count');
    setState(() {
      activeScene = trueState;
      activeDevice = count;
    });
    return trueList.toList();
  }

  Future<void> updateBox(List<dynamic> value) async {
    _box.put('bool_list', value);
  }

  List<bool>? _getBox() {
    final box = _box;
    return box.get('bool_list')?.cast<bool>();
  }

  Box<List> setBox() {
    final box = Hive.box<List>(keyBool);
    return box;
  }

  @override
  void initState() {
    _box = setBox();
    _active = setItemCount();
    super.initState();
  }

  @override
  void dispose() {
    final recentBox = _active!.cast<dynamic>();
    updateBox(recentBox);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Box<List> box = Hive.box<List>(keyBool);
    final ValueListenable<Box<List>> boxListenable = box.listenable();
    return ValueListenableBuilder(
      valueListenable: boxListenable,
      builder: (context, box, _) {
        _active ??= <bool>[];
        int listLength = _active!.length;
        int activeLength = _active!
            .where(
              (element) => element == true,
            )
            .length;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            minimum: const EdgeInsets.only(
              left: 17,
              right: 17,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    children: [
                      ActiveScenes(
                        color_1: colorGreen,
                        name: 'Active Scenes',
                        sceneNumber: activeLength.toString(),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ActiveScenes(
                        color_1: colorPurple,
                        name: 'Active Devices',
                        sceneNumber: listLength.toString(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Regular scenes',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                              child: Text(
                                'View all',
                                style: TextStyle(
                                  color: colorGrey,
                                  fontSize: 11,
                                  letterSpacing: 0.07,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: listLength,
                          itemBuilder: (BuildContext context, int index) {
                            return ToggledScenes(
                              index: index,
                              boolList: _active,
                              changeList: updateBox(_active!.cast<dynamic>()),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 8);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ActiveScenes extends StatelessWidget {
  final String name;
  final Color color_1;
  final String sceneNumber;

  const ActiveScenes({
    super.key,
    required this.color_1,
    required this.name,
    required this.sceneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: color_1,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    height: 17,
                    width: 17,
                    child: Icon(
                      size: 6,
                      Icons.circle,
                      color: colorGreen,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: -.24,
                    ),
                  )
                ],
              ),
            ),
            Text(
              sceneNumber,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 48,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ToggledScenes extends StatefulWidget {
  final VoidCallback? whenChanged;
  final Future<void> changeList;
  final String sceneName;
  final int index;
  final List<bool>? boolList;

  const ToggledScenes({
    super.key,
    required this.boolList,
    this.sceneName = '',
    this.whenChanged,
    required this.changeList,
    required this.index,
  });

  @override
  State<ToggledScenes> createState() => _ToggledScenes();
}

class _ToggledScenes extends State<ToggledScenes> {
  final String days = 'Everyday';

  action(VoidCallback? button) => button = widget.whenChanged ?? () {};

  setList() => widget.changeList;

  Widget _shedule() {
    return Row(
      children: [
        Text(
          days,
          style: TextStyle(color: colorGrey, fontSize: 12),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5, right: 2),
          child: Icon(
            Icons.access_time_filled_rounded,
            color: colorGrey,
            size: 14,
          ),
        ),
        Text('2:30 pm', style: TextStyle(color: colorGrey, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Getting the value from the List<bool> at it's index
    bool value = widget.boolList![widget.index];
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: colorBlack2.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                width: 45,
                height: 43,
                child: const Icon(
                  /// Edit to get the icon from the database
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              Switch(
                activeTrackColor: colorGreen,
                value: value,
                onChanged: (bool _) {
                  setState(() {
                    widget.boolList![widget.index] = _;
                  });
                  action(widget.whenChanged);
                  setList();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sceneName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      letterSpacing: -.041,
                    ),
                  ),
                  _shedule(),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colorGrey2,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class ToggledScenes extends StatefulWidget {
//   final  VoidCallback? onChanged;
//   final String sceneName;
//   final int index;
//
//
//   const ToggledScenes({
//     super.key,
//     this.sceneName = '',
//     this.onChanged,
//     required this.index,
//   });
//
//   @override
//   State<ToggledScenes> createState() => _ToggledScenes();
// }
//
// class _ToggledScenes extends State<ToggledScenes> {
//   final String days = 'Everyday';
//
//   action(VoidCallback? button){
//     return button = widget.onChanged ?? () {};
//   }
//
//   Widget _shedule() {
//     return Row(
//       children: [
//         Text(
//           days,
//           style: TextStyle(color: colorGrey, fontSize: 12),
//         ),
//         Container(
//           margin: const EdgeInsets.only(left: 5, right: 2),
//           child: Icon(Icons.access_time_filled_rounded,
//               color: colorGrey, size: 14),
//         ),
//         Text('2:30 pm', style: TextStyle(color: colorGrey, fontSize: 12)),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<bool> switchState = List.generate(
//       widget.index,
//       (index) => false,
//     );
//     final Box<List> box = Hive.box<List>(keyBool);
//     final ValueListenable<Box<List>> boxListenable = box.listenable();
//     return ValueListenableBuilder(
//       valueListenable: boxListenable,
//       builder: (context, box, _) {
//         List<bool>? boolList =
//             box.get('bool_list', defaultValue: switchState)?.cast<bool>();
//         return Container(
//           alignment: Alignment.center,
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(20)),
//             border: Border.all(color: colorBlack2.withOpacity(0.1)),
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // margin: const EdgeInsets.only(right: 15),
//                     decoration: BoxDecoration(
//                         color: Colors.red.withOpacity(0.9),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(20))),
//                     width: 45,
//                     height: 43,
//                     child: const Icon(
//                       Icons.home,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Switch(
//                     activeTrackColor: colorGreen,
//                     value: boolList![widget.index],
//                     onChanged: (bool value) {
//                       setState(() {
//                         boolList[widget.index] = value;
//                       });
//                       box.put('bool_list', boolList);
//                       action(widget.onChanged);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.sceneName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17,
//                           letterSpacing: -.041,
//                         ),
//                       ),
//                       _shedule(),
//                     ],
//                   ),
//                   Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     color: colorGrey2,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
