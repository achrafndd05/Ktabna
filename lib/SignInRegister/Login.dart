import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/AddBookAndSearch/home1.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toast/toast.dart';

import '../Widgets/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 50,
                    wordSpacing: 2,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin,
                ),
                child: Text(
                  "Register to your account ",
                  style: TextStyle(
                    fontSize: 22,
                    wordSpacing: 2,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              // Flexible(
              //   child: Hero(
              //     tag: 'logo',
              //     child: Container(
              //       height: 60.0,
              //       width: 60,
              //       child: Image.asset('assets/images/temp.jpg'),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin,
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your Email',
                    labelStyle: TextStyle(
                      fontSize: 22,
                      wordSpacing: 2,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.bold,
                      color: tcolor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin,
                ),
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    labelStyle: TextStyle(
                      fontSize: 22,
                      wordSpacing: 2,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.bold,
                      color: tcolor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              // ignore: deprecated_member_use
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
                  child: Container(
                    height: 50,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      color: Color(0xff57886C),
                      onPressed: () async {
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          // ignore: unnecessary_null_comparison
                          if (user != null) {
                            //Navigator.pushNamed(context, SplashScreen.id);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home1()));
                          }
                        } catch (e) {
                          print(e);
                          Toast.show("$e", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 22,
                          wordSpacing: 2,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.bold,
                          color: tcolor,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
