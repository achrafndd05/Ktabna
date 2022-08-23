import 'package:cloud_firestore/cloud_firestore.dart';
import 'bdd.dart';

class UserDataServices {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");

  // ignore: non_constant_identifier_names
  Createnewuser(String fullname, String username, String wilaya,
      String password, String email) async {
    return await userCollection.add({
      'fullname': fullname,
      'username ': username,
      'wilaya': wilaya,
      'password': password,
      'email': email,
    });
  }

  // ignore: non_constant_identifier_names
  Future AddUserData(Utilisateur) async {
    FirebaseFirestore.instance
        .collection("user")
        .add(Utilisateur)
        .catchError((e) {
      print(e.toString());
    });
  }

  // ignore: non_constant_identifier_names
  Future CompletTask(id) async {
    return await userCollection.doc(id).update({'iscomplet': true});
  }

  // ignore: non_constant_identifier_names
  List<Utilisateur> UserFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Utilisateur(
          name: e.data()["name"],
          userFullName: e.data()["userFullName"],
          email: e.data()["email"],
          password: e.data()["password"],
          id: e.id,
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
      await userCollection.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
