import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NewDevice extends StatelessWidget {
  const NewDevice({super.key});

  Widget kIcon(Color color, IconData data) => Container(
        width: 44,
        height: 43,
        padding: const EdgeInsets.all(11),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: color,
        ),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Icon(
              data,
              color: color,
              size: 18,
            )),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(14),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                KText(
                  text: 'Add new device',
                  fontSize: 28,
                  fontSpacing: 0.39,
                  weight: FontWeight.w600,
                  color: colorBlack2,
                ),
                const SizedBox(
                  height: 5,
                ),
                KText(
                  text: 'Select the device connection type',
                  fontSize: 15,
                  fontSpacing: -0.24,
                  weight: FontWeight.w400,
                  color: colorGrey2,
                ),
                const SizedBox(
                  height: 48,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                    height: 163,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: colorGrey3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        kIcon(colorPurple, Icons.menu),
                        const KText(
                          text: 'Add device manually',
                          fontSize: 17,
                          fontSpacing: -0.41,
                          weight: FontWeight.w600,
                          textCenterAlign: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                    height: 163,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: colorGrey3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        kIcon(colorPink, Icons.wifi),
                        const KText(
                          text: 'Add device automatically',
                          fontSize: 17,
                          fontSpacing: -0.41,
                          weight: FontWeight.w600,
                          textCenterAlign: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      );
  }
}
