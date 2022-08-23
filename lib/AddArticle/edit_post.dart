import 'package:flutter_application/AddBookAndSearch/home1.dart';

import 'PostService.dart';
import 'post.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  final Post post;

  EditPost(this.post);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textFormField = TextFormField(
      initialValue: widget.post.body,
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
      onSaved: (val) => widget.post.body = val,
      // ignore: missing_return
      validator: (val) {
        if (val.isEmpty) {
          return "This field can't be empty";
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit post",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
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
                  initialValue: widget.post.title,
                  decoration: InputDecoration(
                      hintText: "Edit the Title here..",
                      border: UnderlineInputBorder(),
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                  onSaved: (val) => widget.post.title = val,
                  // ignore: missing_return
                  validator: (val) {
                    if (val.isEmpty) {
                      return "This field can't be empty";
                    } else if (val.length > 20) {
                      return "title cannot have more than 20 characters";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: textFormField,
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
            "Save changes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        tooltip: "Click here if you want to save your changes",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void insertPost() {
    _formKey.currentState.save();
    _formKey.currentState.reset();
    widget.post.date = DateTime.now().millisecondsSinceEpoch;
    PostService postService = PostService(widget.post.toMap());
    postService.updatePost();
  }
}
