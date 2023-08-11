import 'package:clever_tech/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _myduration = 3;

  @override
  void initState() {
    Future.delayed(Duration(seconds: _myduration), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OnBoarding(),
      ));
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(79, 192, 112, 1),
      body: Center(
        child: Text(
          '(clever+tech)',
          style: TextStyle(
            fontFamily: 'SFTS',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
