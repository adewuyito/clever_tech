import 'package:clever_tech/data/colors.dart';
import 'package:flutter/material.dart';

class Automation extends StatelessWidget {
  const Automation({super.key});

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
                  ActiveScenes(color_1: colorGreen, name: 'Active Scenes'),
                  const SizedBox(
                    width: 16,
                  ),
                  ActiveScenes(color_1: colorPurple, name: 'Active Scenes')
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
                      itemBuilder: (BuildContext context, int index) =>
                          const ToggledScenes(),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 8),
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

class ActiveScenes extends StatelessWidget {
  final String name;
  final Color color_1;

  const ActiveScenes({super.key, required this.color_1, required this.name});

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
            const Text(
              '5',
              style: TextStyle(
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
  final String sceneName;

  const ToggledScenes({super.key, this.sceneName = ''});

  @override
  State<ToggledScenes> createState() => _ToggledScenes();
}

class _ToggledScenes extends State<ToggledScenes> {
  bool isOn = false;
  final String days = 'Everyday';

  Widget _shedule() {
    return Row(
      children: [
        Text(
          days,
          style: TextStyle(color: colorGrey, fontSize: 12),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5, right: 2),
          child: Icon(Icons.access_time_filled_rounded,
              color: colorGrey, size: 14),
        ),
        Text('2:30 pm', style: TextStyle(color: colorGrey, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 142,
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
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                width: 45,
                height: 43,
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              Switch(
                activeTrackColor: colorGreen,
                value: isOn,
                onChanged: (bool value) {
                  setState(() {
                    isOn = value;
                  });
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

// Column(
//   children: [
//     Row(
//       children: [
//         ActiveScenes(color_1: colorGreen, name: 'Active Scenes'),
//         const SizedBox(
//           width: 16,
//         ),
//         ActiveScenes(color_1: colorPurple, name: 'Active Scenes')
//       ],
//     ),
//     const ToggledScenes(
//       sceneName: 'Good night',
//     ),
//   ],
// ),
