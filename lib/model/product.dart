import 'anyimage.dart';

class Product {
  String pid;

  bool ifproductavailable;

  List<AnyImage> images;
  String category;

  String title;

  String author;

  String isbn;

  String description;

  bool iscomplet;

  String imageurl;

  Product({
    this.imageurl,
    this.pid,
    this.images,
    this.ifproductavailable,
    this.title,
    this.author,
    this.isbn,
    this.description,
    this.iscomplet,
    this.category,
  });
}
