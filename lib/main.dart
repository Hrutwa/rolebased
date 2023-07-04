import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolebased/User.dart';
import 'package:rolebased/check_if_login.dart';
import 'package:rolebased/login.dart';
import 'package:rolebased/provider.dart';
import 'package:rolebased/timer_homepage.dart';
import 'package:rolebased/timer_provider.dart';

import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      // home: Register(),
      home:  ChangeNotifierProvider(
      create: (BuildContext context) => TimerProvider(),
      child: LoginPage()),
    );
    
  }
}
