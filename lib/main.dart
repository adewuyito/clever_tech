import 'package:clever_tech/features/auth/auth_service.dart';
import 'package:clever_tech/screens/app_build/main_app_builder.dart';
import 'package:clever_tech/screens/authentication/login_screen.dart';
import 'package:clever_tech/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SFTS'
      ),
      home: const Homebuilder(),
    );
  }
}


class Homebuilder extends StatelessWidget {
  const Homebuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null){
                return const MainApp();
              }
              else {
                return const Splash();
              }
            default:
              return const Login();
          }
        });
  }
}

