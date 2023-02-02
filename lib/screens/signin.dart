import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<String> list = <String>['Agent','Superviseur'];
  String? dropdownValue = 'Superviseur';

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
    );
    if(dropdownValue=='Agent'){
      Navigator.of(context).pushNamed('/');
    }
    else{
      Navigator.of(context).pushNamed('authSuperviseur');
    }
  }

  void openSignup(){
    Navigator.of(context).pushReplacementNamed('signup');
  }
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/map-icon-construction.png'),
                SizedBox(height: 30),

                //Subtitle
                Text(
                    'Relevez vos constructions',
                    style: GoogleFonts.robotoCondensed(fontSize: 20)
                ),

                SizedBox(height: 50),
                //Title
                Text(
                  'SIGN IN',
                   style: GoogleFonts.robotoCondensed(
                     fontSize: 40, fontWeight: FontWeight.bold
                   )
                ),

                SizedBox(height: 70),

                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: DropdownButton<String>(

                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            items: list.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: 100.0, // for example
                                  child: Text(value, textAlign: TextAlign.left),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                          ),
                        )
                    )
                ),

                SizedBox(height: 30),
                //Email TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email'
                        )
                      )
                    )
                  )
                ),

                SizedBox(height: 30),

                //Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password'
                        )
                      )
                    )
                  )
                ),

                SizedBox(height: 40),
                //Sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[900],
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                          child: Text('Login',
                              style: GoogleFonts.robotoCondensed(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ))
                          )
                    ),
                  )
                ),

                SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pas encore membre ?  ',
                      style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold
                      )
                    ),
                    GestureDetector(
                      onTap: openSignup,
                      child: Text(
                        "S'inscrire",
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        )
                      ),
                    )
                  ],
                )
              ],
              ),
          ),
        ),
      ),
    );
  }
}
