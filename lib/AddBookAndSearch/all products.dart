/*import 'package:flutter/material.dart';
import 'package:flutter_application/screens/body.dart';

import '../model/product.dart';

class AllProducts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("All Products"),
              Divider(),
              SizedBox(height: 20,),
              ListView.builder(
                  itemCount: 5,
                  itemBuilder: itemBuilder)
            ],

          )
        ),
      ),
    );
  }
}



class ProductsListItem extends StatelessWidget {
  final Product product1;
  final Product product2;

  ProductsListItem({
    @required this.product1,
    @required this.product2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildProductItemCard(context, product1),
        product2 == null
            ? Container()
            : _buildProductItemCard(context, product2),
      ],
    );
  }

  _buildProductItemCard(BuildContext context, Product product) {
    return InkWell(
      onTap: () {
         Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductDetail(product: product);
            },
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                //    child: Image.file(

                ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    product.title,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
