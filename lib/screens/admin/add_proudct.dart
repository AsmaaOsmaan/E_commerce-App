
import 'package:e_commerc/constans.dart';
import 'package:flutter/material.dart';
import 'package:e_commerc/widgets/custom_text.dart';
import 'package:e_commerc/services/store.dart';
import 'package:e_commerc/models/product.dart';
class AddProduct extends StatelessWidget {
  static String id='AddProduct';
  String _name,_price,_description,_category,_ImageLocation;
  Store _store=Store();
  static GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Add Product',style: TextStyle(color: Colors.black),),backgroundColor: KmainColor,),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              SizedBox(height: 30,),
                CustomTextField(hint:'Product Name',
                  onClick: (value){
                    _name=value;
                  },),
                SizedBox(height: 10,),
                CustomTextField(hint:'Product price',onClick: (value){
                  _price=value;
                } ,),
                SizedBox(height: 10,),
                CustomTextField(hint:'Product Description',onClick: (value){
                  _description=value;
                }, ),
                SizedBox(height: 10,),
                CustomTextField(hint: 'Product Category',onClick: (value){
                  _category=value;
                },),
                SizedBox(height: 10,),
                CustomTextField(hint:'Product Location',onClick: (value){
                  _ImageLocation=value;
                } ,),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text('Add Product',),

                  onPressed: (){

                    if(_globalKey.currentState.validate()){
                      try{

                        _globalKey.currentState.save();

                        _store.AddProduct(Product(
                            pCategory: _category,
                            pDescription: _description,
                            plocation: _ImageLocation,
                            pName: _name,
                            pPrice: _price
                        ));
                     _globalKey.currentState.reset();
                      }
                      catch(e){
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
        ),
      ),
    );
  }
}
