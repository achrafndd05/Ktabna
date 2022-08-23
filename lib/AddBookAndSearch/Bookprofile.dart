import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/chat/services/database.dart';
import 'package:flutter_application/chat/views/chat.dart';

// ignore: must_be_immutable
class Bookprofile extends StatefulWidget {
  static String id = "bookprofile";

  String title = '';
  String author = '';
  // ignore: non_constant_identifier_names
  String ISBN = '';
  String image = '';
  String description = '';
  String category = '';
  String creator = '';

  Bookprofile(
      {this.title,
      this.author,
      this.description,
      // ignore: non_constant_identifier_names
      this.ISBN,
      this.category,
      this.image,
      this.creator});

  @override
  _BookprofileState createState() => _BookprofileState();
}

class _BookprofileState extends State<Bookprofile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

// print user email logged in
  void getCurrentUser() {
    final User user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }

  sendMessage(String userEmail) {
    List<String> users = [loggedInUser.email, userEmail];

    String chatRoomId = getChatRoomId(loggedInUser.email, userEmail);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                )));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<Widget> getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.LoadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /* appBar:
      AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),   */

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        // ignore: deprecated_member_use
        child: FlatButton(
          color: Colors.grey[400],
          onPressed: () {
            if (widget.creator != null) {
              sendMessage(widget.creator);
            } else {
              print('creator is nullllll');
            }
          },
          child: Text(
            'Contact the OWNER',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      // Positioned(
                      //   left: 25,
                      //   top: 35,
                      //   // child: GestureDetector(
                      //   //   onTap: () {
                      //   //     Navigator.pop(context);
                      //   //   },
                      //   //   child: Container(
                      //   //     width: 32,
                      //   //     height: 32,
                      //   //     decoration: BoxDecoration(
                      //   //         borderRadius: BorderRadius.circular(5),
                      //   //         color: Colors.white),
                      //   //     // child: const Icon(
                      //   //     //   Icons.arrow_back,
                      //   //     //   color: Colors.black,
                      //   //     //   size: 40.0,
                      //   //     // ),
                      //   //   ),
                      //   // ),
                      // ),
                      Align(
                        //alignment: Alignment.bottomCenter,
                        child: FutureBuilder(
                          future: getImage(context, '/images/' + widget.title),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                width: 200,
                                height: 300,
                                child: snapshot.data,
                              );
                            }

                            return Container();
                          },
                        ),

                        // child: Container(
                        //   margin: EdgeInsets.only(bottom: 62),
                        //   width: 190,
                        //   height: 270,
                        //   decoration: BoxDecoration(
                        //     // borderRadius: BorderRadius.circular(10),
                        //     image:  DecorationImage(image: AssetImage(image)),
                        //
                        //   ),
                        // ),
                      )
                      // child: Container(
                      //   margin: EdgeInsets.only(bottom: 62),
                      //   width: 190,
                      //   height: 270,
                      //   decoration: BoxDecoration(
                      //     // borderRadius: BorderRadius.circular(10),
                      //     image:  DecorationImage(image: AssetImage(image)),
                      //
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.only(top: 24, left: 25),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 27,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7, left: 25),
                  child: Text(
                    widget.author,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400),
                  ),
                ),

                // Padding(
                //     padding: EdgeInsets.only(top: 7, left: 25),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: <Widget>[
                //         Text(
                //           '\$',
                //           style: GoogleFonts.openSans(
                //               fontSize: 14,
                //               color: kMainColor,
                //               fontWeight: FontWeight.w600),
                //         ),
                //         Text(
                //           popularBookModel.price,
                //           style: GoogleFonts.openSans(
                //               fontSize: 32,
                //               color: kMainColor,
                //               fontWeight: FontWeight.w600),
                //         ),
                //       ],
                //     )),

                // Container(
                //   height: 28,
                //   margin: EdgeInsets.only(top: 23, bottom: 36),
                //   padding: EdgeInsets.only(left: 25),
                //   child: DefaultTabController(
                //     length: 1,
                //     child: TabBar(
                //         labelPadding: EdgeInsets.all(0),
                //         indicatorPadding: EdgeInsets.all(0),
                //         isScrollable: true,
                //         labelColor: Colors.black,
                //         unselectedLabelColor: Colors.grey,
                //         labelStyle: TextStyle(
                //             fontSize: 14, fontWeight: FontWeight.w700),
                //         unselectedLabelStyle: TextStyle(
                //             fontSize: 14, fontWeight: FontWeight.w600),
                //          indicator: RoundedRectangleTabIndicator(
                //             weight: 2, width: 30, color: Colors.black),
                //         tabs: [
                //           Tab(
                //             child: Container(
                //               margin: EdgeInsets.only(right: 39),
                //               child: Text('Description'),
                //             ),
                //           ),
                //           // Tab(
                //           //   child: Container(
                //           //     margin: EdgeInsets.only(right: 39),
                //           //     child: Text('ISBN'),
                //           //   ),
                //           // ),
                //           // Tab(
                //           //   child: Container(
                //           //     margin: EdgeInsets.only(right: 39),
                //           //     child: Text('Similar'),
                //           //   ),
                //           // )
                //         ]),
                //   ),
                //
                // ),

                Padding(
                  padding:
                      EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 5),
                  child: Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      letterSpacing: 1.5,
                      height: 2,
                    ),
                  ),

                  // Text(
                  //   ISBN,
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.grey,
                  //     letterSpacing: 1.5,
                  //     height: 2,
                  //   ),
                  // ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 5),
                  child: Text(
                    "ISBN",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Text(
                    widget.ISBN,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[700],
                      letterSpacing: 1.5,
                      height: 2,
                    ),
                  ),

                  // Text(
                  //   ISBN,
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.grey,
                  //     letterSpacing: 1.5,
                  //     height: 2,
                  //   ),
                  // ),
                )
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  // ignore: non_constant_identifier_names
  static Future<dynamic> LoadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
