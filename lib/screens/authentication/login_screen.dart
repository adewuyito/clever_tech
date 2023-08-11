import 'package:clever_tech/data/fireBase/fire_base_exceptions.dart';
import 'package:clever_tech/screens/app_build/main_app_builder.dart';
import 'package:clever_tech/screens/authentication/sign_up.dart';
import 'package:flutter/material.dart';

import '../../data/fireBase/fire_base_auth.dart';
import '../../widgets/button_widgets.dart';
import 'forgetpassword_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthenticationService auth = AuthenticationService();
  late final AuthStatus _status;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.dispose();
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
              'Welcome back',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SFTS'),
            ),
            const Text(
              "Hello again, you've been missed",
              style: TextStyle(
                  // fontSize: 18,
                  color: Color.fromARGB(255, 182, 176, 176),
                  fontFamily: 'SFTS'),
            ),
            const SizedBox(
              height: 25.0,
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
                onPressed: () async {
                  try{
                    _status = await auth.login(
                      email: _email.toString(),
                      password: _password.toString(),
                    );
                  } on () {
                    if (_status == AuthStatus.successful) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MainApp()),
                              (route) => false);
                    }
                  }
                },
                label: 'Sign in',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgetPassWord()));
              },
              child: const Text(
                'Forget password?',
                style: TextStyle(
                    // fontSize: 18,
                    color: Color.fromARGB(255, 182, 176, 176),
                    fontFamily: 'SFTS'),
              ),
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
                      ),
                    )),
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
            Container(
              margin: const EdgeInsets.only(
                top: 30.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle:
                          const TextStyle(decoration: TextDecoration.underline),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    )),
                    child: const Text("Sign Up"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
