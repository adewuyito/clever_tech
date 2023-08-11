import 'package:clever_tech/data/fireBase/fire_base_auth.dart';
import 'package:clever_tech/data/fireBase/fire_base_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clever_tech/data/colors.dart';
import '../../widgets/button_widgets.dart';
import '../app_build/main_app_builder.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  AuthenticationService auth = AuthenticationService();
  late final AuthStatus _status;
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.dispose();
  }

  void register() async {
    try {
      _status = await auth.createAccount(
          email: _email.toString(),
          password: _password.toString(),
          name: _name.toString());
      final user = FirebaseAuth.instance.currentUser;
    } finally {
      if (auth.currentUser?.emailVerified ?? false)
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainApp()),
                  (route) => false);
        }else {
        Navigator.of(context).pop;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            const Text(
              "Let's get started",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SFTS'),
            ),
            Text(
              "Hello again, you've been missed",
              style: TextStyle(
                  // fontSize: 18,
                  color: colorGrey,
                  fontFamily: 'SFTS'),
            ),
            const SizedBox(
              height: 25.0,
            ),
            TextField(
              controller: _name,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Full Name',
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w600, fontFamily: 'SFTS'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
            ), //Email_Field
            const SizedBox(height: 15),
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
            ), //Email_Field
            const SizedBox(height: 15),
            TextField(
              controller: _password,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                hintText: 'Password',
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w600, fontFamily: 'SFTS'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
              ),
            ), //Password_Field
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: EButton(
                onPressed: register,
                label: 'Register',
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: colorGrey,
                  checkColor: Colors.white,
                  fillColor:
                      MaterialStateColor.resolveWith((states) => colorGreen),
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      const TextSpan(text: "I agree "),
                      TextSpan(
                          text: "Privacy Policy ",
                          style: TextStyle(color: colorGreen),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      const TextSpan(text: "and "),
                      TextSpan(
                          text: "User Agreement ",
                          style: TextStyle(color: colorGreen),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ],
                  ),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'or',
                    style: TextStyle(
                        // fontSize: 18,
                        color: Color.fromARGB(255, 182, 176, 176),
                        fontFamily: 'SFTS'),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.grey),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ))),
                onPressed: () {},
                child: const Text('Login with  Google'),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1, color: Colors.grey),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ))),
                onPressed: () {},
                child: const Text('Login with  Apple'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
