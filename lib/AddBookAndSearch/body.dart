import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Widgets/constants.dart';
import 'Bookprofile.dart';
import 'books.dart';
import 'databaseservices.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List userProfilesList = [];
  List<Books> booksList = [];

  String userID = "";

  @override
  void initState() {
    super.initState();
    //fetchUserInfo();
    fetchDatabaseList();
    DatabaseReference booksref =
        FirebaseDatabase.instance.reference().child("Books");
    booksref.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      booksList.clear();
      for (var indkey in keys) {
        Books books = new Books(
            data[indkey]["imageurl"],
            data[indkey]["title"],
            data[indkey]["category"],
            data[indkey]["description"],
            data[indkey]["author"],
            data[indkey]["isbn"],
            data[indkey["creator"]]);
        booksList.add(books);
      }
      setState(() {
        print('length: $booksList.length');
      });
    });
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseServices().Getinfo();
    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  final FirebaseFirestore fb = FirebaseFirestore.instance;

/*  Future<QuerySnapshot<Map<String, dynamic>>> getImages() {
    return fb.collection("images").get();
  }*/

  @override
  Widget build(BuildContext context) {
    /*return new Container(
child: booksList.length == 0 ? Text("no books are available") : new ListView.builder(
  itemCount: booksList.length,
    itemBuilder: (_, index){
    return Booksui(
      booksList[index].imageurl ,
      booksList[index].title ,
      booksList[index].author ,
      booksList[index].isbn ,
      booksList[index].description ,
      booksList[index].category ,
    );
    }
),
  );*/
    Future<String> getimg(String name) async {
      var image = await FirebaseStorage.instance
          .ref()
          .child("images/" + name)
          .getDownloadURL();
      print('debug & : ' + image);
      return image;
    }

    int index = 0;
    print(getimg(userProfilesList[index]["title"]));
    /*RefreshIndicator(
      onRefresh: Refreshlist,
      backgroundColor: kTextcolor,
      child:*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //  Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultpaddin),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultpaddin / 2,
                  crossAxisSpacing: kDefaultpaddin,
                  childAspectRatio: 0.69,
                ),
                itemCount: userProfilesList.length,
                itemBuilder: (context, int index) {
                  //   final image = snapshot.data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultpaddin / 2),
                    child: Container(
                      height: 120,
                      //color: Colors.black,
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            return Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return Bookprofile(
                                title: userProfilesList[index]["title"],
                                author: userProfilesList[index]["author"],
                                category: userProfilesList[index]["category"],
                                description: userProfilesList[index]
                                    ["description"],
                                image: userProfilesList[index]["imageurl"],
                                ISBN: userProfilesList[index]["isbn"],
                                creator: userProfilesList[index]["creator"],
                              );
                            }));
                          },
                          child: FutureBuilder(
                              future: getimg(
                                  userProfilesList[index]["title"].toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  print('debug' + snapshot.data);
                                  return Container(
                                    height: 120,
                                    child: Image.network(snapshot.data),
                                  );
                                  /*   color: Colors.black,
                                      child:  Column(
                                        children:<Widget> [
                                          Container(
                                          height : 180 ,
                                            width: 160,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: kTextcolor,
                                            ),
                                            child: Image.network(snapshot.data),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: kDefaultpaddin / 4),
                                            child: Text(
                                                userProfilesList[index]["title"],
                                              style: TextStyle(color: kTextlightcolor),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: kDefaultpaddin / 4),
                                            child: Text(
                                              userProfilesList[index]["author"],
                                              style: TextStyle(color: kTextlightcolor),
                                            ),
                                          ),
                                          /*ListTile(
                                            title: Text(
                                                userProfilesList[index]["title"]),
                                            subtitle: Text(
                                                userProfilesList[index]["author"]),
                                          ),*/
                                        ],
                                      ),*/

                                } else
                                  return Container();
                              }),
                          /*,*/
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
