import 'package:firebase_database/firebase_database.dart';

class Post {
  static const TITLE = "title";
  static const BODY = "body";
  static const DATE = "date";
  static const KEY = "key";

  String title;
  String body;
  String key;
  int date;

  Post(
    this.title,
    this.body,
    this.date,
    this.key,
  );

  Post.fromSnapshot(DataSnapshot snap)
      : this.key = snap.key.toString(),
        this.body = snap.value[BODY],
        this.date = snap.value[DATE],
        this.title = snap.value[TITLE];

  Map toMap() {
    return {BODY: body, TITLE: title, DATE: date, KEY: key};
  }
}
