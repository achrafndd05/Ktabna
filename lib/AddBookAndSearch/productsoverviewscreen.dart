import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/Widgets/constants.dart';
import 'package:image_picker/image_picker.dart';

import 'databaseservices.dart';
import 'home1.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String choosevalue = "Novel";
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() {
    final User user = _auth.currentUser;
    if (user != null) {
      loggedInUser =
          user; // omB3d fi les champs create champ fih value loggedInUser.email
      print("$loggedInUser");
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  List<String> listitem = [
    "Novel",
    "Historic",
    "Biography",
    "Science",
    "Comics",
    "Education",
    "Cooking",
    "Philosophy",
    "Psycology",
    "Religion",
  ];

  //image picker function ...
  File _image;

  int i = 0;

  Future<void> _upload(String inputSource, String name) async {
    final picker = ImagePicker();
    PickedFile pickedImage;
    try {
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);
      File imageFile = File(pickedImage.path);
      try {
        await FirebaseStorage.instance.ref('images/').child(name).putFile(
              _image = imageFile,
            );
        setState(() {});
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  } //producttitlecontroller.text.trim();//product infos variables

  //Create an option chooser for selecting camera / gallery
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _upload('gallery', producttitlecontroller.text.trim());
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _upload('camera', producttitlecontroller.text.trim());
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  TextEditingController producttitlecontroller = TextEditingController();
  TextEditingController productauthorname = TextEditingController();
  TextEditingController productisbn = TextEditingController();
  TextEditingController productdescription = TextEditingController();

  // home page design and ... :

  @override
  Widget build(BuildContext ctx) {
    // ignore: unused_local_variable
    final style = TextStyle(
      fontFamily: 'Nexa',
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home1()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 45, // add custom icons also
          ),
        ),
        backgroundColor: Colors.white,
        // title: Text("Add A Book")
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Text(
                "Add a Book",
                style: TextStyle(
                  fontSize: 39,
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
                "Fill this forum so you can exchange "
                "your Book with any Book you want",
                style: TextStyle(
                  fontSize: 22,
                  wordSpacing: 2,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            /*  Container(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: FlatButton(
                  //radius: 55,
                  //backgroundColor: kTextcolor,
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),*/
            //),
            //    childre: Column(
            //   children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: TextFormField(
                  controller: producttitlecontroller,
                  decoration: InputDecoration(
                    labelText: "Title",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: TextFormField(
                  controller: productauthorname,
                  decoration: InputDecoration(
                    labelText: "Author",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: TextFormField(
                  controller: productisbn,
                  decoration: InputDecoration(
                    labelText: "Book ISBN",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: TextFormField(
                  controller: productdescription,
                  decoration: InputDecoration(
                    labelText: "Description",
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                child: DropdownButtonFormField(
                  value: choosevalue,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    labelText: "Select Category ",
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: tcolor,
                    ),
                  ),
                  items: listitem.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        style: TextStyle(
                          fontSize: 22,
                          wordSpacing: 2,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.bold,
                          color: tcolor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newvalue) {
                    setState(() {
                      choosevalue = newvalue;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                height: 60,
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {
                    _showPicker(context);
                  },
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    //radius: 55,
                    //backgroundColor: kTextcolor,
                    onPressed: () {},
                    child: _image != null
                        ? Container(
                            // borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultpaddin, vertical: kDefaultpaddin),
              child: Container(
                height: 60,
                // ignore: deprecated_member_use
                child: FlatButton(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 22,
                        wordSpacing: 2,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.bold,
                        color: tcolor,
                      ),
                    ),
                    color: kTextcolor,
                    onPressed: () async {
                      //  Navigator.pop(ctx);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home1()));
                      if (producttitlecontroller.text.isNotEmpty &&
                          _image.toString().isNotEmpty &&
                          productauthorname.text.trim().isNotEmpty &&
                          choosevalue.isNotEmpty) {
                        await DatabaseServices().CreateNewProduct(
                          producttitlecontroller.text.trim(),
                          productauthorname.text.trim(),
                          productisbn.text.trim(),
                          productdescription.text.trim(),
                          _image.toString(),
                          choosevalue,
                          loggedInUser.email,
                        );
                      }
                    }),
              ),
            ),
          ], // children
        ),
      ),
    );
  }
}
