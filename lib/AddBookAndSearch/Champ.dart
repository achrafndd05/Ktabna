import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Champ extends StatefulWidget {
  IconData icon;
  String text;
  // ignore: non_constant_identifier_names
  var on_Pressed;

  Champ(this.icon, this.text, this.on_Pressed);

  @override
  _ChampState createState() =>
      _ChampState(this.icon, this.text, this.on_Pressed);
}

class _ChampState extends State<Champ> {
  IconData icon;
  String text;
  // ignore: non_constant_identifier_names
  var on_Pressed;
  _ChampState(this.icon, this.text, this.on_Pressed);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        onTap: on_Pressed,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(widget.icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
