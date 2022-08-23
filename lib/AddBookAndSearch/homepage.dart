import 'package:flutter/material.dart';
import 'package:flutter_application/AddArticle/add_post.dart';
import 'package:flutter_application/SignInRegister/edit.dart';
import 'package:flutter_application/chat/views/chatrooms.dart';
import 'Champ.dart';
import 'body.dart';
import 'productsoverviewscreen.dart';
import 'searchpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void selectscreen(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ProductsOverviewScreen();
    }));
  }

  // ignore: non_constant_identifier_names
  Future<Null> Refreshlist() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void selectscreen2(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Searchpage();
    }));
  }

  int selectedIndex = 0;
  List<Widget> listWidgets = [
    Homepage(),
    Searchpage(),
    ProductsOverviewScreen(),
    AddPost(),
    ChatRoom()
  ];
  Image applogo = new Image(
    image: new ExactAssetImage("asset/icons/logo.png"),
    height: 100.0,
    width: 120.0,
    alignment: FractionalOffset.center,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 40.0,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: applogo,
        /*Text("Ktabna",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),*/
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Body(),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(5),
          children: <Widget>[
            DrawerHeader(
                child: Column(children: <Widget>[
              Icon(Icons.edit),
              Material(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              )
            ])),
            Champ(Icons.person, 'Edit Profile', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditUserProfile()));
            }
                //() => {},
                ),
            Champ(Icons.book, 'Added books', () {}),
            Champ(
              Icons.door_back,
              'Sign Out',
              () => {},
            ),
          ],
        ),
      ),
    );
  }

  //         size: 40.0,
  //       ),
  //       onPressed: () {
  //         Scaffold.of(context).openDrawer();
  //       },
  //     ),
  //   ),
  //   title: Text("Ktabna",
  //       style: TextStyle(
  //         color: kTextcolor,
  //         fontSize: 30,
  //         fontWeight: FontWeight.bold,
  //       )),
  //   backgroundColor: Colors.black,
  //   elevation: 0,
  // ),
  // body: Body(),
  // drawer: FutureBuilder(builder: (context, snapshot) {
  //   return Drawer(
  //     child: ListView(
  //       padding: const EdgeInsets.all(5),
  //       children: <Widget>[
  //         DrawerHeader(
  //             child: Column(children: <Widget>[
  //           Icon(Icons.edit),
  //           Material(
  //             borderRadius: BorderRadius.all(Radius.circular(50.0)),
  //           )
  //         ])),
  //         Champ(Icons.person, 'Edit Profile', () {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => EditUserProfile()));
  //         }
  //             //() => {},
  //             ),
  //         Champ(Icons.book, 'Added books', () {
  //           ;
  //         }),
  //         Champ(
  //           Icons.door_back,
  //           'Sign Out',
  //           () => {},
  //         ),
  //       ],
  //     ),
  //   );
  // }));
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
