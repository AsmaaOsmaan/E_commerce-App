
import 'package:e_commerc/models/product.dart';
import 'package:e_commerc/screens/user/product_info.dart';
import 'package:flutter/material.dart';

import '../functions.dart';
Widget  productView(String pCategory,List<Product>allProudct) {
  List<Product>products;
  products=getProductByCategory(pCategory,allProudct);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.8),
    itemCount: products.length,
    itemBuilder: (context, index) => GestureDetector(

      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Image(
                  image: AssetImage(products[index].plocation),
                  fit: BoxFit.fill,
                )),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          products[index].pName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${products[index].pPrice} ')
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );

}