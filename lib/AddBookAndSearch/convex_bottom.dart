import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

const _kPages = <String, IconData>{
  'Home': Icons.home,
  'Publish': Icons.edit,
  'Add': Icons.add,
  'Message': Icons.message,
  'Menu': Icons.menu,
};

// ignore: camel_case_types
class Convex_Bottom extends StatefulWidget {
  //const Convex_Bottom({Key key}) : super(key: key);

  @override
  _Convex_BottomState createState() => _Convex_BottomState();
}

// ignore: camel_case_types
class _Convex_BottomState extends State<Convex_Bottom> {
  TabStyle _tabStyle = TabStyle.reactCircle;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: Scaffold(
        body: Column(
          children: [
            buildselector(),
            const Divider(),
          ],
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          const <int, dynamic>{3: '99+'},
          style: _tabStyle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(
                icon: entry.value,
                title: entry.key,
              ),
          ],
          onTap: (int i) => print('click index=$i'),
        ),
      ),
    );
  }

  // ignore: missing_return
  Widget buildselector() {}
}
