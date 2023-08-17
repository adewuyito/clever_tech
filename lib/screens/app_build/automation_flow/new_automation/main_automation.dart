import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/widgets/button_widgets.dart';
import 'package:clever_tech/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainAutomation extends StatefulWidget {
  const MainAutomation({super.key});

  @override
  State<MainAutomation> createState() => _MainAutomationState();
}

class _MainAutomationState extends State<MainAutomation> {
  int selectedPage = 0;
  PageController controller = PageController();
  List<Widget> screens = [
    const SceneName(),
    SceneCondition(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: WormEffect(
            dotWidth: 28,
            dotHeight: 4,
            activeDotColor: colorGreen,
            dotColor: colorGrey.withOpacity(0.6),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 17, right: 17, top: 40),
        child: PageView(
          controller: controller,
          children: screens,
        ),
      ),
    );
  }
}

// Scene Condition Page
class SceneCondition extends StatelessWidget {
  SceneCondition({super.key});

  Widget _conditionTile(String title, String subTitle, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        minVerticalPadding: 24,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorGrey3),
          borderRadius: BorderRadius.circular(20),
        ),
        title: KText(
          text: title,
          fontSize: 17,
          fontSpacing: -0.41,
          weight: FontWeight.w500,
        ),
        subtitle: KText(
          text: subTitle,
          fontSize: 11,
          fontSpacing: 0.07,
          color: colorGrey2,
        ),
        leading: Icon(Icons.access_time_filled_rounded, color: iconColor,),
        trailing: Icon(Icons.arrow_forward_ios_sharp, color: colorGrey2),
      ),
    );
  }

  final List title = [
    'When weather changes',
    'Exact time',
    'Location',
    'When device status changes',
  ];

  final List subtitle = [
    'Run scene when the weather changes',
    'Run scene once at a specified time',
    'Getting started when your location changes',
    'Example: when an unusual activity is detected',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const KText(
            fontSize: 28,
            text: 'Room condition',
            fontSpacing: 0.36,
            weight: FontWeight.w600,
          ),
          KText(
            fontSize: 15,
            text: 'Define a condition for your new room',
            fontSpacing: -0.24,
            color: colorGrey2,
          ),
          const SizedBox(height: 40),
          _conditionTile(title[0], subtitle[0], colorPink2),
          _conditionTile(title[1], subtitle[1], colorPink),
          _conditionTile(title[2], subtitle[2], colorBlue),
          _conditionTile(title[3], subtitle[3], colorPurple),
        ],
      ),
    );
  }
}

// Scene Name Page
class SceneName extends StatefulWidget {
  const SceneName({super.key});

  @override
  State<SceneName> createState() => _SceneNameState();
}

class _SceneNameState extends State<SceneName> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const KText(
            fontSize: 28,
            text: 'Set name of scene',
            fontSpacing: 0.36,
            weight: FontWeight.w600,
          ),
          KText(
            fontSize: 15,
            text: 'Set a unique name for your scene for further identification',
            fontSpacing: -0.24,
            color: colorGrey2,
            textCenterAlign: true,
          ),
          const SizedBox(height: 48),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              label: const Text('Room name'),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(
                color: colorGrey2,
                fontWeight: FontWeight.w600,
                fontFamily: 'SFTS',
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const EButton(label: 'Next step'),
        ],
      ),
    );
  }
}

//