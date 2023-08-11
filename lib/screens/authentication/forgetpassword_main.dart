import 'package:clever_tech/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/colors.dart';

class ForgetPassWord extends StatefulWidget {
  const ForgetPassWord({super.key});

  @override
  State<ForgetPassWord> createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  final _formKey = GlobalKey<FormState>();
  final controller = PageController();

  void onPressed() {}

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
          left: true,
          right: true,
          minimum: const EdgeInsets.only(left: 17, right: 17),
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: <Widget>[
                InputMail(
                  nextPage: controller,
                ),
                InputOTP(
                  nextPage: controller,
                  formKey: _formKey,
                ),
                InputPassword(
                  nextPage: controller,
                ),
              ],
            ),
          )),
    );
  }
}

class InputMail extends StatefulWidget {
  PageController nextPage;
  final VoidCallback? onPressed;

  InputMail({super.key, this.onPressed, required this.nextPage});

  @override
  State<InputMail> createState() => _InputMailState();
}

class _InputMailState extends State<InputMail> {
  late final TextEditingController _email;

  void next() {
    widget.nextPage.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Forget password?',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'SFTS',
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 48),
            child: Text(
              'Enter your e-mail then we will sent OTP sms to reset new password.',
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                color: colorGrey2,
                letterSpacing: -0.24,
                fontSize: 15,
                fontFamily: 'SFTS',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w600, fontFamily: 'SFTS'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          EButton(
            label: 'Send OTP',
            onPressed: next,
          )
        ],
      ),
    );
  }
}

class InputOTP extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  PageController nextPage;
  final VoidCallback? onPressed;

  // final email = TextEditingController();

  InputOTP(
      {super.key,
      this.onPressed,
      required this.nextPage,
      required this.formKey});

  void next() {
    nextPage.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  void prev() {
    nextPage.previousPage(
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Forget password?',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'SFTS',
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 48),
            child: Text(
              'Enter your e-mail then we will sent OTP sms to reset new password.',
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                color: colorGrey2,
                letterSpacing: -0.24,
                fontSize: 15,
                fontFamily: 'SFTS',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 77,
                  width: 74,
                  child: TextFormField(
                    onChanged: (e) {
                      if (e.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else if (e.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Center(
                        child: Text('0'),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFTS',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                SizedBox(
                  height: 77,
                  width: 74,
                  child: TextFormField(
                    onChanged: (e) {
                      if (e.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else if (e.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Center(
                        child: Text('0'),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFTS',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                SizedBox(
                  height: 77,
                  width: 74,
                  child: TextFormField(
                    onChanged: (e) {
                      if (e.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else if (e.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Center(
                        child: Text('0'),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFTS',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                SizedBox(
                  height: 77,
                  width: 74,
                  child: TextFormField(
                    onChanged: (e) {
                      if (e.length == 1) {
                        FocusScope.of(context).nextFocus();
                      } else if (e.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Center(
                        child: Text('0'),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SFTS',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          EButton(
            label: 'Send OTP',
            onPressed: next,
          ),
          TextButton(
              onPressed: prev, child: const Text('Enter different Email'))
        ],
      ),
    );
  }
}

class InputPassword extends StatelessWidget {
  PageController nextPage;
  final VoidCallback? onPressed;
  final _passWord = TextEditingController();
  final _passWordVerify = TextEditingController();

  InputPassword({super.key, this.onPressed, required this.nextPage});

  void next() {
    nextPage.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Forget password?',
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'SFTS',
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 48),
            child: Text(
              'Enter your e-mail then we will sent OTP sms to reset new password.',
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                color: colorGrey2,
                letterSpacing: -0.24,
                fontSize: 15,
                fontFamily: 'SFTS',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextField(
            controller: _passWord,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              hintText: 'Enter password',
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w600, fontFamily: 'SFTS'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passWordVerify,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              hintText: 'Verify password',
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w600, fontFamily: 'SFTS'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          EButton(
            label: 'Send OTP',
            onPressed: next,
          )
        ],
      ),
    );
  }
}
