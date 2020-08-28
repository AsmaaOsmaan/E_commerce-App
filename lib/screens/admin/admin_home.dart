
import 'package:e_commerc/screens/admin/add_proudct.dart';
import 'package:e_commerc/screens/admin/manage_product.dart';
import 'package:e_commerc/screens/admin/view_order.dart';
import 'package:flutter/material.dart';
class AdminHome extends StatelessWidget {
  static String id='AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            onPressed: (){
           Navigator.pushNamed(context, AddProduct.id);
            },
            child: Text("Add Product"),
          ),
          RaisedButton(
            onPressed: (){
         Navigator.pushNamed(context, ManageProduct.id);
            },
            child: Text("Edit Product"),
          ),
          RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, ViewOrders.id);
            },
            child: Text("View Orders"),
          )
        ],
      ),



    );
  }
}
