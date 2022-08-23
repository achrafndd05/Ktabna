import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/AddArticle/home.dart';
import 'package:flutter_application/chat/views/chatrooms.dart';

import 'homepage.dart';
import 'productsoverviewscreen.dart';
import 'searchpage.dart';

class Home1 extends StatefulWidget {
  const Home1({Key key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int selectedIndex = 0;
  List<Widget> listWidgets = [
    Homepage(),
    Searchpage(),
    ProductsOverviewScreen(),
    HomePage(),
    ChatRoom()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidgets[selectedIndex],
      bottomNavigationBar: ConvexAppBar.badge(
        {},
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.edit, title: 'Publish'),
          TabItem(icon: Icons.message, title: 'Message'),
        ],
        onTap: onItemTapped,
        backgroundColor: Colors.black,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
