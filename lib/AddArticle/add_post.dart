import 'package:flutter_application/AddBookAndSearch/home1.dart';

import 'PostService.dart';
import 'package:flutter/material.dart';
import 'post.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  Post post = Post("", "", 0, "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publish",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        elevation: 0.0,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: "Type the Title here..",
                      border: UnderlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  onSaved: (val) => post.title = val,
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isEmpty) {
                      return "This field can't be empty";
                    } else if (val.length > 20) {
                      return "Title can't have more than 20 characters";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  style: TextStyle(fontWeight: FontWeight.normal),
                  keyboardType: TextInputType.multiline,
                  maxLines: 20,
                  decoration: InputDecoration(
                    hintText: 'Unleash your magic here...',
                    border: UnderlineInputBorder(),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onSaved: (val) => post.body = val,
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isEmpty) {
                      return "This field can't be empty";
                    }
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            insertPost();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home1()),
              (Route<dynamic> route) => false,
            );
          }
        },
        backgroundColor: Color.fromRGBO(231, 111, 81, 265),
        label: Center(
          child: Text(
            "Publish",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        tooltip: "Click here if you want others to see it",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void insertPost() {
    _formKey.currentState.save();
    _formKey.currentState.reset();
    post.date = DateTime.now().millisecondsSinceEpoch;
    PostService postService = PostService(post.toMap());
    postService.addPost();
  }
}
