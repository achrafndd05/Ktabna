import 'package:flutter/material.dart';
import 'Login.dart';
import 'SignUp.dart';
import 'rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/icons/ktabna.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ButtonTheme(
            height: MediaQuery.of(context).size.width * 0.2,
            minWidth: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              children: [
                RoundedButton(
                  title: 'Log In',
                  colour: Color(0xff57886C),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                RoundedButton(
                  title: 'Register',
                  colour: Color(0xffE76F51),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                )
              ],
            )));
  }
}
