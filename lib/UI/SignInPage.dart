import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneysender/UI/HomePage.dart';
import 'package:moneysender/UI/SignUpPage.dart';
import 'package:moneysender/provider/init_provider.dart';
import 'package:provider/provider.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _passwordController = TextEditingController(text: "");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        //  decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage("assets/homeback.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Stack(
            children: [
              Container(
                child: Image.asset('assets/authimage.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Optimize Your \nMoney Management \nEffortlessly',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30, bottom: 20),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextField(
                          controller: _emailController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Enter your email",
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Enter your password",
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await signIn();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white54),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Signin with Email',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.email,
                                  color: Colors.white70,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Signuppage())),
                            child: Text(
                              'Sign Up!',
                              style: TextStyle(
                                color: Color.fromARGB(255, 25, 178, 238),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    String email = _emailController.text;
    String pass = _passwordController.text;

    try {
      var res =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
   
      if (res.user!.uid.isNotEmpty) {
        checkuser(email, res.user!.refreshToken);
      }
      
    } on FirebaseAuthException catch (e) {
      print('failed');
    }
  }

  checkuser(String email, token) async {
    final userProvider = context.read<InitProvider>();
    var collection = FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email);
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id; // <-- Document ID
      if(documentID.isNotEmpty){
        userProvider.setUser(documentID, token, snapshot['email'], double.parse(snapshot['balance'].toString()));
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Homepage()));
      }
    }
  }
}
