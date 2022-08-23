import 'package:flutter_application/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/constants.dart';
import 'authservice.dart';

class SignUp extends StatefulWidget {
  static const String id = 'SignUp';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String name;
  String username;
  String wilaya;
  String confirm;
  String valeur = "ADRAR";
  bool _passwordVisible = false;
  var regExp = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  List<String> items = [
    'ADRAR',
    'CHLEF',
    'LAGHOUAT',
    'OUM BOUAGHI',
    'BATNA',
    'BEJAIA',
    'BISKRA',
    'BECHAR',
    'BLIDA',
    'BOUIRA',
    'TAMANRASSET',
    'TEBESSA',
    'TLEMCEN',
    'TIARET',
    'TIZI OUZOU',
    'ALGER',
    'DJELFA',
    'JIJEL',
    'SETIF',
    'SAIDA',
    'SKIKDA',
    'SIDI BEL ABBES',
    'ANNABA',
    'GUELMA',
    'CONSTANTINE',
    'MEDEA',
    'MOSTAGANEM',
    'MSILA',
    'MASCARA',
    'OUARGLA',
    'ORAN',
    'EL BAYADH',
    'ILLIZI',
    'BORDJ BOU ARRERIDJ',
    'BOUMERDES',
    'EL TAREF',
    'TINDOUF',
    'TISSEMSILT',
    'EL OUED',
    'KHENCHLA',
    'SOUK AHRASS',
    'TIPAZA',
    'MILA',
    'AÏN DEFLA',
    'NÂAMA',
    'AÏN TEMOUCHENT',
    'GHARDAÏA',
    'RELIZANE'
  ];

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController wilayacontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Text(
                "Sign Up",
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
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Text(
                "create an account so you can "
                "Exchange books easily",
                style: TextStyle(
                  fontSize: 22,
                  wordSpacing: 2,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
                child: Container(
                    child: TextFormField(
                  controller: fullnamecontroller,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(
                      fontSize: 22,
                      wordSpacing: 2,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.bold,
                      color: tcolor,
                    ),
                  ),
                  onSaved: (val) => name = val,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Nom est obligatoire";
                    }
                    return null;
                  },
                ))),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
                child: Container(
                  child: TextFormField(
                    controller: usernamecontroller,
                    decoration: InputDecoration(
                      labelText: "User Name",
                      labelStyle: TextStyle(
                        fontSize: 22,
                        wordSpacing: 2,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.bold,
                        color: tcolor,
                      ),
                    ),
                    onSaved: (val) => usernamecontroller.text = val,
                    // ignore: missing_return
                    validator: (val) {
                      if (val.isEmpty) {
                        return "User Name est obligatoire";
                      }
                    },
                  ),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
                child: Container(
                  child: TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 22,
                          wordSpacing: 2,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.bold,
                          color: tcolor,
                        ),
                      ),
                      onSaved: (val) => email = val,
                      // ignore: missing_return
                      validator: (val) {
                        if (val.isEmpty) {
                          return "ce champ ne peut pas etre vide";
                        } else if (regExp.hasMatch(val)) {
                          return 'Entrer un mail valide';
                        }
                      }),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
                child: Container(
                    child: TextFormField(
                  controller: passwordcontroller,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 22,
                      wordSpacing: 2,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.bold,
                      color: tcolor,
                    ),
                  ),
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Mot de passe obligatoire';
                    }
                  },
                  onChanged: (val) {
                    setState(() => confirm = val);
                  },
                ))),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
                child: Container(
                    child: TextFormField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(
                      fontSize: 22,
                      wordSpacing: 2,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.bold,
                      color: tcolor,
                    ),
                  ),
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Mot de passe obligatoire';
                    }
                  },
                  onChanged: (val) {
                    setState(() => confirm = val);
                  },
                ))),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: DropdownButtonFormField(
                  value: valeur,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    labelText: "Wilaya",
                    labelStyle: TextStyle(
                      fontSize: 22,
                      wordSpacing: 2,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.bold,
                      color: tcolor,
                    ),
                  ),
                  items: items.map((String val) {
                    return new DropdownMenuItem<String>(
                      value: val,
                      child: new Text(val),
                    );
                  }).toList(),
                  onChanged: (String newval) {
                    setState(() {
                      valeur = newval;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                height: 50,
                // ignore: deprecated_member_use
                child: FlatButton(
                  color: Color(0xffE76F51),
                  // onPressed: () async {
                  // UserDataServices().Createnewuser(
                  //     fullnamecontroller.text.trim(),
                  //     usernamecontroller.text.trim(),
                  //     valeur,
                  //     passwordcontroller.text.trim(),
                  //     emailcontroller.text.trim());

                  //   try {
                  //     final user = await _auth.createUserWithEmailAndPassword(
                  //         email: email, password: password);
                  //     // ignore: unnecessary_null_comparison
                  //     if (user != null) {
                  //       //Navigator.pushNamed(context, SplashScreen.id);
                  //       Navigator.pushReplacement(context,
                  //           MaterialPageRoute(builder: (context) => MainPage()));
                  //     }
                  //   } catch (e) {
                  //     print(e);
                  //     Toast.show("$e", context,
                  //         duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  //   }
                  // }
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 22,
                      wordSpacing: 2,
                      letterSpacing: 1.8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    UserDataServices().Createnewuser(
                        fullnamecontroller.text.trim(),
                        usernamecontroller.text.trim(),
                        valeur,
                        passwordcontroller.text.trim(),
                        emailcontroller.text.trim());
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: emailcontroller.text,
                          password: passwordcontroller.text);
                      // ignore: unnecessary_null_comparison
                      if (user != null) {
                        //Navigator.pushNamed(context, SplashScreen.id);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),

            //     try {
            //       if (name.isNotEmpty &&
            //           name.isNotEmpty &&
            //           password.isNotEmpty &&
            //           confirm.isNotEmpty &&
            //           username.isNotEmpty &&
            //           password == confirm) {
            //         await UserDataServices().Createnewuser(
            //             fullnamecontroller.text.trim(),
            //             usernamecontroller.text.trim(),
            //             valeur,
            //             passwordcontroller.text.trim(),
            //             emailcontroller.text.trim());

            //         final newUser = await _auth.createUserWithEmailAndPassword(
            //             email: email, password: password);
            //       }
            //     } catch (e) {
            //       print(e);
            //       Toast.show("$e", context,
            //           duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            //     }

            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (context) => Homepage()));
            //   },

            // RoundedButton(
            //   title: 'Back',
            //   colour: Colors.grey,
            //   onPressed: () {
            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (context) => WelcomeScreen()));
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,

// Flexible(
//   child: Hero(
//     tag: 'logo',
//     child: Container(
//       height: 60.0,
//       width: 60.0,
//       child: Image.asset('assets/images/temp.jpg'),
//     ),
//   ),

// ),

//             TextField(
//               textAlign: TextAlign.left,
//               onChanged: (val) {
//                 username = val;
//               },
//               decoration: kTextFieldDecoration.copyWith(hintText: 'User name'),
//             ),

//             // TextField(

//             //   textAlign: TextAlign.left,
//             //   onChanged: (val) {
//             //     wilaya = val;
//             //   },
//             //   decoration: kTextFieldDecoration.copyWith(hintText: 'Wilaya'),
//             // ),

// DropdownButtonFormField(
//                     val: chooseval,
//                     icon: Icon(Icons.arrow_downward),
//                     decoration: InputDecoration(
//                     labelText: "Select Category",
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                     items: listitem.map((String val){
//                       return new DropdownMenuItem<String>(
//                           val: val,
//                           child: new Text(val),
//                       );
//                     }).toList(),
//                   onChanged: (String newval){
//                       setState(() {
//                         chooseval =newval ;
//                       });
//                   },
//                 ),

//             TextField(
//               keyboardType: TextInputType.emailAddress,
//               textAlign: TextAlign.left,
//               onChanged: (val) {
//                 email = val;
//               },
//               decoration:
//                   kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
//             ),
//             SizedBox(
//               height: 8.0,
//             ),
//             TextField(
//               obscureText: true,
//               textAlign: TextAlign.left,
//               onChanged: (val) {
//                 password = val;
//               },
//               decoration: kTextFieldDecoration.copyWith(
//                   hintText: 'Enter your password'),
//             ),
//             TextField(
//               obscureText: true,
//               textAlign: TextAlign.left,
//               onChanged: (val) {
//                 password = val;
//               },
//               decoration: kTextFieldDecoration.copyWith(
//                   hintText: 'confirm your password'),
//             ),
