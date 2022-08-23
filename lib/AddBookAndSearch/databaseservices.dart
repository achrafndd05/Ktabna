import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product.dart';

class DatabaseServices {
  CollectionReference booksCollecction =
      FirebaseFirestore.instance.collection("Books");

  // ignore: non_constant_identifier_names
  CreateNewProduct(String title, String author, String isbn, String description,
      String imageurl, String category, String creator) async {
    List<String> indexList = [];
    List<String> splitList = title.split(' ');
    List<String> splitList2 = author.split(' ');

    String temp = ""; // add the title index

    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + 1; j++) {
        temp = splitList[i].substring(0, j).toLowerCase();

        indexList.add(temp);
      }
    }

    String temp2 = "";
    for (int i = 0; i < splitList2.length; i++) {
      for (int j = 0; j < splitList2[i].length + 1; j++) {
        temp2 = splitList2[i].substring(0, j).toLowerCase();

        indexList.add(temp2);
      }
    }

    String temp3 = ""; // add the author index

    for (int i = 0; i < title.length; i++) {
      temp3 = temp3 + title[i];

      indexList.add(temp3);
    }

    String temp4 = "";

    for (int i = 0; i < author.length; i++) {
      temp4 = temp4 + author[i];
      indexList.add(temp4);
    }

    // String temp="";
    //
    //
    //
    // // add the title index
    // for(int i =0;i<title.length;i++) {
    //     temp=temp+title[i];
    //     indexList.add(temp);
    // }

    // String temp2="";  // add the author index
    //
    // for(int i =0;i<author.length;i++) {
    //   temp2=temp2+author[i];
    //   indexList.add(temp2);
    // }

    return await booksCollecction.add({
      'title': title,
      'author': author,
      'isbn': isbn,
      'description': description,
      'iscomplet': false,
      'imageurl': imageurl,
      'category': category,
      'searchindex': indexList,
      'creator': creator,
    });
  }

  // ignore: non_constant_identifier_names
  Future CompletTask(pid) async {
    return await booksCollecction.doc(pid).update({'iscomplet': true});
  }

  // ignore: non_constant_identifier_names
  List<Product> ProductsFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Product(
          imageurl: e.data()["imageurl"],
          category: e.data()["category"],
          iscomplet: e.data()["iscomplet"],
          title: e.data()["title"],
          pid: e.id,
          author: e.data()['author'],
          isbn: e.data()['isbn'],
          description: e.data()['description'],
        );
      }).toList();
    } else {
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  Future Getinfo() async {
    List itemsList = [];

    try {
      await booksCollecction.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
