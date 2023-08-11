import 'package:clever_tech/data/colors.dart';
import 'package:flutter/material.dart';

class Automation extends StatelessWidget {
  const Automation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.only(
            left: 17,
            right: 17,
          ),
          child: Column(children: [
            Row(
              children: [
                ActiveScenes(color_1: colorGreen, name: 'Active Scenes'),
                const SizedBox(
                  width: 16,
                ),
                ActiveScenes(color_1: colorPurple, name: 'Active Scenes')
              ],
            ),
            const ToggledScenes(sceneName: 'Good night',),
          ]),
        ));
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.sceneName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      letterSpacing: -.041,
                    ),
                  )
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colorGrey3,
              ),
            ],
          )
        ],
      ),
    );
  }
}
