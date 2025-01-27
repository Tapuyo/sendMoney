import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moneysender/UI/HomePage.dart';
import 'package:moneysender/UI/SignInPage.dart';
import 'package:moneysender/provider/init_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => InitProvider()),
    ],
    child:  MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Sender',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Signinpage(),
    );
  }
}
