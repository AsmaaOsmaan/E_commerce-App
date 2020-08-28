import 'package:flutter/material.dart';

class Product {
  String pID;
  String pName
, pPrice, pDescription, plocation, pCategory;
  int pQuantity;
  Product(
      {this.pID,this.pCategory,
      this.pDescription,
      this.plocation,
      this.pName,
      this.pPrice,
      this.pQuantity});
}
