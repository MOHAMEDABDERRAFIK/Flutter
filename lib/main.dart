import 'package:flutter/material.dart';
import 'package:project_flutter/authAgent.dart';
import 'package:project_flutter/authSuperviseur.dart';
import 'package:project_flutter/screens/homeAgent.dart';
import 'package:project_flutter/screens/homeSuperviseur.dart';
import 'package:project_flutter/screens/program.dart';
import 'package:project_flutter/screens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_flutter/screens/signup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relevé cartographique des constructions',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      routes:{
        '/': (context) => const AuthAgent(),
        'authSuperviseur': (context) => const AuthSuperviseur(),
        'homeAgent': (context) => const HomePageAgent(),
        'homeSuperviseur': (context) => const HomePageSuperviseur(),
        'signup': (context) => const SignupPage(),
        'signin': (context) => const SignInPage(),
        'program': (context) => const ProgramPage()
      },
    );
  }
}

