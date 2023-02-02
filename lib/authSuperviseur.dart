import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/screens/homeSuperviseur.dart';
import 'package:project_flutter/screens/signin.dart';

class AuthSuperviseur extends StatelessWidget {
  const AuthSuperviseur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot){
          if(snapshot.hasData){
              return HomePageSuperviseur();
          }else {
              return SignInPage();
          }
        }),
      ),
    );
  }
}
