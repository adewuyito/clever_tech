import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'constants/hive_constants.dart';
import 'data/colors.dart';
import 'screens/app_build/automation_flow/automation.dart';

class AutomationCopy extends StatefulWidget {
  const AutomationCopy({super.key});

  @override
  State<AutomationCopy> createState() => _AutomationCopyState();
}

class _AutomationCopyState extends State<AutomationCopy> {
  int itemCount = 0;
  int activeState = 0;
  final Box<List> box = Hive.box<List>(keyBool);

  setItemCount() {
    List<bool>? switchState = box.get('bool_list')?.cast<bool>();
    if (switchState != null) {
      final trueList = switchState.every((element) => true);
      log(trueList.toString());
      int trueState = 0;
      for (int i = 0; i < switchState.length; i++) {
        if (switchState[i] == true) {
          trueState++;
        }
      }
      final count = switchState.length;
      setState(() {
        activeState = trueState;
        itemCount = count;
      });
    }
  }

  @override
  void initState() {
    setItemCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    sceneNumber: activeState.toString(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ActiveScenes(
                    color_1: colorPurple,
                    name: 'Active Scenes',
                    sceneNumber: itemCount.toString(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
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
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View all',
                            style: TextStyle(
                                color: colorGrey,
                                fontSize: 11,
                                letterSpacing: 0.07),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return ToggledScenes(
                          index: index,
                          onChanged: setItemCount, boolList: const [true, false],
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
  }
}

// class BoolListWidget extends StatelessWidget {
//   const BoolListWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final Box<List<bool>> box = Hive.box<List<bool>>(keyBool);
//     final ValueListenable<Box<List<bool>>> boxListenable = box.listenable();
//
//     return ValueListenableBuilder(
//       valueListenable: boxListenable,
//       builder: (context, box, _) {
//         List<bool>? boolList = box.get('myBoolList', defaultValue: []);
//         return Column(
//           children: [
//             for (int i = 0; i < boolList!.length; i++)
//               ListTile(
//                 title: Text('Item $i'),
//                 trailing: Switch(
//                   value: boolList[i],
//                   onChanged: (newValue) {
//                     boolList[i] = newValue;
//                     box.put('myBoolList', boolList);
//                   },
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

// class SwitchWidget extends StatefulWidget {
//   final Box<bool> box;
//
//   const SwitchWidget({super.key, required this.box});
//
//   @override
//   State<SwitchWidget> createState() => _SwitchWidgetState();
// }
//
// class _SwitchWidgetState extends State<SwitchWidget> {
//   late ValueListenable<Box<List<bool>>> _boxListenable;
//
//   @override
//   void initState() {
//     super.initState();
//     _boxListenable = widget.box.listenable();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: _boxListenable,
//       builder: (context, box, _) {
//         bool? isDarkModeEnabled = box.get('isDarkModeEnabled', defaultValue: false);
//         return ListTile(
//           title: Text('Dark Mode'),
//           trailing: Switch(
//             value: isDarkModeEnabled,
//             onChanged: (newValue) {
//               widget.box.put('isDarkModeEnabled', newValue);
//             },
//           ),
//         );
//       },
//     );
//   }
// }



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

// updateItemCount(List<bool>? box){
//   List<bool>? switchState = box;
//   if (switchState != null){
//     final trueList = switchState.every((element) => true);
//     log(trueList.toString());
//     int trueState = 0;
//     for(int i = 0; i < switchState.length; i++){
//       if (switchState[i] == true){
//         trueState++;
//       }
//     }
//     final count = switchState.length;
//     setState(() {
//       activeScene = trueState;
//       activeDevice = count;
//     });
//   }
// }