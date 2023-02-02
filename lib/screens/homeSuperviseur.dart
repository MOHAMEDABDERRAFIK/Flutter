import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/screens/program.dart';
import 'package:project_flutter/screens/signin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePageSuperviseur extends StatefulWidget {
  const HomePageSuperviseur({Key? key}) : super(key: key);


  @override
  State<HomePageSuperviseur> createState() => _HomePageSuperviseurState();
}

  class _HomePageSuperviseurState extends State<HomePageSuperviseur> {
  final auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar : AppBar(
              backgroundColor: Colors.blue[300],
              toolbarHeight: 30,
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Carte',icon: Icon(Icons.map)),
                ],
              ),
            actions: [
              IconButton(onPressed: (){
                auth.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                });
                }, icon: Icon(Icons.logout_outlined)),
              SizedBox(width: 8,)
            ],
          ),

          body : TabBarView(
            children: [
              Center(
                  child:WebView(
                    initialUrl: "https://timely-torrone-c1fd86.netlify.app/",
                    javascriptMode: JavascriptMode.unrestricted,
                )
              ),
            ],
          ),
      ),
    );
  }


}
