import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.colour, this.onPressed});

  final Color colour;
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(title, style: TextStyle(fontSize: 20)),
        color: colour,
        textColor: Colors.white,
        elevation: 5,
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.all(5),
    //   child: Material(
    //     elevation: 5.0,
    //     color: colour,
    //     // borderRadius: BorderRadius.circular(30.0),
    //     child: MaterialButton(

    //       minWidth: 100,
    //       height: 5,
    //       onPressed: onPressed,
    //       child: Text(
    //         title,
    //         style: TextStyle(
    //           color: Colors.white,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
