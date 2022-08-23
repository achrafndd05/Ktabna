import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/SignInRegister/welcome_screen.dart';
import 'package:dcdg/dcdg.dart';

import 'AddBookAndSearch/home1.dart';
import 'AddBookAndSearch/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? Homepage()
            : WelcomeScreen.id,
        home: WelcomeScreen(),
        theme: ThemeData(
            fontFamily: 'Nexa',
            backgroundColor: Colors.white,
            primaryColor: Colors.black,
            primaryColorDark: Color.fromRGBO(7, 16, 19, 265)));
  }
}

class MainPage extends StatefulWidget {
  static const String id = 'MainPage';

  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home1(),
    );
  }
}
