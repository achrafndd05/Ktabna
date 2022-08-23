import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bdd.dart';

// ignore: must_be_immutable
class EditUserProfile extends StatefulWidget {
  Utilisateur userdata;

  @override
  _EditUserProfileState createState() => _EditUserProfileState(userdata);
}

class _EditUserProfileState extends State<EditUserProfile> {
  Utilisateur userdata;
  _EditUserProfileState(this.userdata);

  String newPassword = '', newUserName = '';

  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

  bool isUserName = true,
      viewPasswordNew = true,
      viewPasswordConfirm = true,
      isusernameCorrect = true,
      isNewPasswordCorrect = true,
      isNewPasswordSet = true,
      isChangePassword = false,
      viewPasswordCurrent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 27.5,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Colors.white,
        ),
        child: SingleChildScrollView(
          //to add the scroll effect
          child: Center(
            child: Column(
              //main column where all input fields exist
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChangeUserName(context),

                //edit password
                ChangePassword(context),

                //test if password was correct or no
                ConfirmNewPassword(context),

                //Confirm password changes
                ConfirmPasswordChange(context),

                //apply changes button
                ModifierButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container ChangeUserName(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Stack(alignment: Alignment.topRight, children: [
            TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Enter your new User Name',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container ChangePassword(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Stack(alignment: Alignment.topRight, children: [
            TextField(
              controller: passwordController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.streetAddress,
              onChanged: (text) {
                setState(() {
                  newPassword = text;
                  if (text.isEmpty)
                    isNewPasswordCorrect = true;
                  else
                    isNewPasswordCorrect =
                        RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                            .hasMatch(text);
                });
              },
              obscureText: viewPasswordNew,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                errorText: isNewPasswordCorrect
                    ? null
                    : '''Invalid password try again
                      Password Must Contain atleast 8 letters
                      Password Must Contain atleast 1 number''',
                helperText: '''Password Must Contain atleast 8 letters
                    Password Must Contain atleast 1 number''',
                helperStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.4),
                ),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: IconButton(
                  color: isNewPasswordCorrect ? Colors.black : Colors.redAccent,
                  icon: Icon(
                    viewPasswordNew
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                  ),
                  onPressed: () {
                    // toggleViewPasswordNew();
                  }),
            ),
          ]),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container ConfirmNewPassword(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Stack(alignment: Alignment.topRight, children: [
            TextField(
              keyboardType: TextInputType.streetAddress,
              onChanged: (text) {
                setState(() {
                  if (!isNewPasswordCorrect)
                    isNewPasswordSet = false;
                  else if (text.isEmpty)
                    isNewPasswordSet = true;
                  else
                    isNewPasswordSet = (text == newPassword);
                });
              },
              obscureText: viewPasswordConfirm,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Enter the last password',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: IconButton(
                  color: isNewPasswordSet ? Colors.black : Colors.redAccent,
                  icon: Icon(
                    viewPasswordConfirm
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                  ),
                  onPressed: () {
                    //toggleViewPasswordConfirm();
                  }),
            ),
          ]),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container ConfirmPasswordChange(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Stack(alignment: Alignment.topRight, children: [
            TextField(
              keyboardType: TextInputType.streetAddress,
              onChanged: (text) {
                setState(() {
                  if (text.isNotEmpty) isChangePassword = true;
                });
              },
              obscureText: viewPasswordCurrent,
              cursorColor: Colors.black,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter old password',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                helperText: 'Enter old password to confirm changes',
                helperStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.4),
                ),
                errorText:
                    isChangePassword ? null : 'Wrong password, try again',
                labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.005,
              ),
              child: IconButton(
                  color: isChangePassword ? Colors.black : Colors.redAccent,
                  icon: Icon(
                    viewPasswordCurrent
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                  ),
                  onPressed: () {
                    // toggleViewPasswordCurrent();
                  }),
            ),
          ]),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container ModifierButton(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future logIn(String email, String password) async {
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: passwordController.text);
        User user = result.user;
        return user;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: RawMaterialButton(
          onPressed: () {
            //_chatPage
            var db = FirebaseFirestore.instance;
            if (passwordController.text == userdata.password) {
              logIn(userdata.email, userdata.password);
            }

            if ((isChangePassword) &&
                (isNewPasswordSet) &&
                (newPassword.isNotEmpty) &&
                (isNewPasswordSet == isChangePassword)) {
              try {
                FirebaseAuth.instance.currentUser.updatePassword(newPassword);
                db
                    .collection("users")
                    .doc(userdata.id)
                    .update({'password': newPassword});
              } catch (e) {
                print(e.toString());
                return null;
              }
              newPassword = '';

              Navigator.pop(context);
            } else {
              setState(() {
                isChangePassword = false;
              });
            }
          },
          fillColor: Colors.black,
          constraints: BoxConstraints(minWidth: 300, minHeight: 57),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text('Apply Changes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ))),
    );
  }
}
