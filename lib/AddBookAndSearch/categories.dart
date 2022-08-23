import 'package:flutter/material.dart';
import 'package:flutter_application/Widgets/constants.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Novel",
    "Historic",
    "Biography",
    "Science",
    "Comics",
    "Education",
    "Cooking",
    "Philosophy",
    "Psycology",
    "Religion"
  ];
  int selectindex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildcategory(index),
      ),
    );
  }

  Widget buildcategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectindex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultpaddin),
        child: Column(
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectindex == index ? kTextcolor : kTextlightcolor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultpaddin / 4),
              height: 2,
              width: 30,
              color: selectindex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
