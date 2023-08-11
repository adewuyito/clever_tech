import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/screens/authentication/login_screen.dart';
import 'package:clever_tech/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();
  bool changeButton = false;

  void currentPage(int i) {
    setState(() {
      changeButton = i == 2 ? true : false;
    });
    // print(changeButton);
  }

  void loginPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const Login(),
      ),
    );
  }

  void nextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: ExpandingDotsEffect(
              spacing: 5,
              expansionFactor: 4,
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: colorBlack2,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: loginPage,
            child: const Text(
              'Skip',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PageView(
              onPageChanged: currentPage,
              pageSnapping: true,
              controller: controller,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/image_e.jpg',
                    fit: BoxFit.fill,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/image_b.jpg',
                    fit: BoxFit.fill,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/image_c.jpg',
                    fit: BoxFit.fill,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Let's make your home autonomous",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFTS'),
                  ),
                  const Text("Hello you've been missed, Get up independent"),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: changeButton
                        ? EButton(
                            label: 'Get started',
                            onPressed: loginPage,
                          )
                        : EButton(
                            label: 'Next',
                            onPressed: nextPage,
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
