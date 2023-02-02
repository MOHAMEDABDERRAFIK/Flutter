import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  DatabaseReference refAgent = FirebaseDatabase.instance.ref("Agents");
  DatabaseReference refSuperviseur = FirebaseDatabase.instance.ref("Superviseurs");
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _roleController = TextEditingController();
  final _fullNameController = TextEditingController();
  final List<String> list = <String>['Agent','Superviseur'];
  String? dropdownValue = 'Superviseur';

  Future signUp() async {
    DatabaseReference newRefAgent = refAgent.push();
    DatabaseReference newRefSuperviseur = refSuperviseur.push();
    if (passwordConfirm()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
      );
      if(dropdownValue=='Agent'){
        await newRefAgent.set({
          "id" : FirebaseAuth.instance.currentUser?.uid,
          "fullname": _fullNameController.text.trim(),
          "email": _emailController.text.trim()
        });
        Navigator.of(context).pushNamed('/');
      }
      if(dropdownValue=='Superviseur'){
        await newRefSuperviseur.set({
          "id" : FirebaseAuth.instance.currentUser?.uid,
          "fullname": _fullNameController.text.trim(),
          "email": _emailController.text.trim()
        });
        Navigator.of(context).pushNamed('authSuperviseur');
      }

    }
  }
  bool passwordConfirm(){
    if(_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
    }else {
      return false;
    }
  }
  void openSignup(){
    Navigator.of(context).pushReplacementNamed('signin');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _roleController.dispose();
    _fullNameController.dispose();
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
                //Title
                Text(
                    'SIGN UP',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 40, fontWeight: FontWeight.bold
                    )
                ),

                SizedBox(height: 150),

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
                                controller: _fullNameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Full Name'
                                )
                            )
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

                //Role TextField
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

                //Confirm Password
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
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Confirm Password'
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
                      onTap: signUp,
                      child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.amber[900],
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                              child: Text("S'inscrire",
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
                        'Déja membre ?  ',
                        style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold
                        )
                    ),
                    GestureDetector(
                      onTap: openSignup,
                      child: Text(
                          "Se connecter",
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

