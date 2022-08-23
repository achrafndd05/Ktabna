import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Bookprofile.dart';
import 'homepage.dart';

//import 'package:flutter_svg/flutter_svg.dart';

class Searchpage extends StatefulWidget {
  static String id = 'search_screen';

  _Searchpage createState() => _Searchpage();
}

class _Searchpage extends State<Searchpage> {
  Bookprofile book = new Bookprofile();
  final TextEditingController _searchBook = new TextEditingController();

  String _searchText = "";
  bool isSearching = false;

  // void _filterBooks(value) {
  //   print(value);
  // }
  void selectscreen3(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Homepage();
    }));
  }

  _Searchpage() {
    _searchBook.addListener(() {
      if (_searchBook.text.isEmpty) {
        setState(() {
          isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          isSearching = true;
          _searchText = _searchBook.text.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,

          backgroundColor: Colors.white,
          title: TextField(
            controller: _searchBook,
            onChanged: (value) {
              setState(() {
                // _filterBooks(value);
              });
            },
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black, fontSize: 16),
            maxLines: 1,
            decoration: new InputDecoration(
              hintText: " Book title or author name",
              hintStyle: TextStyle(color: Colors.grey),

              contentPadding: EdgeInsets.symmetric(vertical: 12),
              //Change this value to custom as you like
              isDense: true,
              border: InputBorder.none,
            ),
          ),
          // actions: <Widget>[
          //   !isSearching
          //       ? IconButton(
          //           icon: const Icon(Icons.cancel),
          //           onPressed: () {
          //             setState(() {
          //               _searchBook.clear();
          //               this.isSearching = false;
          //             });
          //           },
          //         )
          //       : IconButton(
          //           icon: const Icon(Icons.search),
          //           onPressed: () {
          //             setState(() {
          //               this.isSearching = true;
          //             });
          //           },
          //         ),
          //
          // ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: (_searchText == null || _searchText == "")
                ? FirebaseFirestore.instance.collection('Books').snapshots()
                : FirebaseFirestore.instance
                    .collection('Books')
                    .where('searchindex',
                        arrayContains: _searchText.toLowerCase())
                    .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');

              return new ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    //children: snapshot.data.docs.map((document) {
                    return Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      child: Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          leading: FutureBuilder(
                            future: book
                                .createState()
                                .getImage(context, '/images/' + data['title']),
                            //_getImage(context, '/images/'+data['title']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 1.0, color: Colors.grey))),
                                  width: 60,
                                  height: 60,
                                  child: snapshot.data,
                                );
                              }
                              return Container();
                            },
                          ),
                          // leading:  Image.network(
                          //   book.urlImage,
                          //   fit: BoxFit.cover,
                          //   width: 50,
                          //   height: 50,
                          // ),
                          title: new Text(
                            data['title'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          subtitle: new Text(
                            data['author'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right_sharp),
                          enabled: true,
                          dense: true,
                          selected: false,
                          // tileColor: Colors.green[400],
                          focusColor: Colors.orangeAccent,
                          hoverColor: Colors.blue,
                          onTap: () {
                            return Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return Bookprofile(
                                  title: data['title'],
                                  author: data['author'],
                                  description: data['description'],
                                  ISBN: data['isbn'],
                                  category: data['category'],
                                  image: data['imageurl']);
                            }));
                            // print('thebookpageof '+  data['title'].toString(),);
                          },
                        ),
                      ),
                    );

                    /*  ListTile(
            leading: const Icon(Icons.flight_land ),
            title:new  Text(data['name'], style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            subtitle: new Text(data['author'], style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            enabled: true,
            dense: true,
            selected: false,

            onTap: (){
              print('thebookpage');
            },

          ); */
                  });
            }),
      ),
    );
  }
}
/*Widget buildBook(Book book) => ListTile(
  leading: Image.network(
    book.urlImage,
    fit: BoxFit.cover,
    width: 50,
    height: 50,
  ),
  title: Text(book.title),
  subtitle: Text(book.author),
); */
/* class BooksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Books').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (
        !snapshot.hasData

        )
          return new Text('Loading...');

        return new ListView(
          children: snapshot.data.docs.map((document) {





            return
              new ListTile(
              leading: const Icon(Icons.flight_land,

              ),
              title: new Text(document.data()['name']?? 'default'.contains(_searchText), style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              subtitle: new Text(document.data()['author']?? 'default', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              dense: true,
              selected: false,

              onTap: (){
                print('thebookpage');
              },

            );
          }).toList(),
        );
      },
    );
  }
}  */
