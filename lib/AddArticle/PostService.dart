import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class PostService {
  String nodeName = "posts";
  final id = FirebaseAuth.instance.currentUser.uid;

  Map post;

  PostService(this.post);

  addPost() {
    FirebaseDatabase.instance.reference().child(nodeName).push().set(post);
  }

  deletePost() {
    FirebaseDatabase.instance
        .reference()
        .child('$nodeName/${post['key']}')
        .remove();
  }

  updatePost() {
    FirebaseDatabase.instance
        .reference()
        .child('$nodeName/${post['key']}')
        .update({
      "title": post['title'],
      "body": post['body'],
      "date": post['date']
    });
  }
}
