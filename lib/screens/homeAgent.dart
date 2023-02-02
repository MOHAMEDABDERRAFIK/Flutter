import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/screens/program.dart';
import 'package:project_flutter/screens/signin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePageAgent extends StatefulWidget {
  const HomePageAgent({Key? key}) : super(key: key);


  @override
  State<HomePageAgent> createState() => _HomePageAgentState();
}
  class _HomePageAgentState extends State<HomePageAgent> {
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
                  Tab(text: 'Programme',icon: Icon(Icons.calendar_month)),
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
                    initialUrl: "http://exomap.tk/",
                    javascriptMode: JavascriptMode.unrestricted,
                )
              ),
              Center(child: const ProgramPage()),
            ],
          ),
      ),
    );
  }


}
