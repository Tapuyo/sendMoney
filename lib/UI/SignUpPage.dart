import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneysender/UI/HomePage.dart';
import 'package:moneysender/UI/SignInPage.dart';
import 'package:moneysender/provider/init_provider.dart';
import 'package:provider/provider.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 200),
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
                      Spacer(),
                     Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Sign Up',
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
                         onTap: ()async {
                          await signUp(context);
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
                              Text('Sign up with Email', style: TextStyle(color: Colors.white70),),
                              SizedBox(width: 8,),
                              Icon(Icons.email, color: Colors.white70,)
                            ],),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                     
                      
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already had an account? ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signinpage())),
                            child: Text(
                              'Sign In!',
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

    Future<void> signUp(BuildContext context) async {
    String email = _emailController.text;
    String pass = _passwordController.text;
   
                  

    try {
      final res = await _auth.createUserWithEmailAndPassword(email: email, password: pass);

      if(res.additionalUserInfo!.isNewUser){
       await addUser(context, email);
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

    Future<void> addUser(BuildContext context, String email)async {

       String email = _emailController.text;
   
    CollectionReference users = await FirebaseFirestore.instance.collection('users');
    return users
        .add({
      'email': email,
      'balance': 500
    }).then((value){

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Signinpage()));

    });

  }
}
