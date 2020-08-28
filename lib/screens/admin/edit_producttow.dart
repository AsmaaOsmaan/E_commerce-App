import 'package:flutter/material.dart';
import 'package:e_commerc/widgets/custom_text.dart';
import 'package:e_commerc/services/store.dart';
import 'package:e_commerc/models/product.dart';

import '../../constans.dart';

class EditProductTwo extends StatelessWidget {
  static String id = 'EditProductTwo';
  String _name, _price, _description, _category, _ImageLocation;
  Store _store = Store();

  static GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Add Product',style: TextStyle(color: Colors.black),),backgroundColor: KmainColor,),

      key: _scaffoldKey,
      body: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30,),

                  CustomTextField(
                    hint: 'Product Name',
                    onClick: (value) {
                      _name = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'Product price',
                    onClick: (value) {
                      _price = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'Product Description',
                    onClick: (value) {
                      _description = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      hint: 'Product Category',
                      onClick: (value) {
                        _category = value;
                      },
                      icon: Icons.add),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hint: 'Product Location',
                    onClick: (value) {
                      _ImageLocation = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text(
                      'Edit Product',
                    ),
                    onPressed: () {
                      if (_globalKey.currentState.validate()) {
                        try {
                          _globalKey.currentState.save();

                          _store.EditProduct({
                            KproductName: _name,
                            KproductPrice: _price,
                            KproductDescription: _description,
                            KproductLocation: _ImageLocation,
                            KproductCategory: _category,
                          }, product.pID);
                          _globalKey.currentState.reset();
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(SnackBar(

                            content: Text('somthing wrong'),
                          ));
                        }
                      }
                    },
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
