
import 'package:flutter/material.dart';
import 'package:e_commerc/widgets/custom_text.dart';
import 'package:e_commerc/services/store.dart';
import 'package:e_commerc/models/product.dart';
class AddProduc extends StatelessWidget {
  static String id='AddProduct';
  String _name,_price,_description,_category,_ImageLocation;
  Store _store=Store();
  static GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(hint:'Product Name',
              onClick: (value){
                _name=value;
              },icon: Icons.add,),
            SizedBox(height: 10,),
            CustomTextField(hint:'Product price',onClick: (value){
              _price=value;
            } ,icon: Icons.add),
            SizedBox(height: 10,),
            CustomTextField(hint:'Product Description',onClick: (value){
              _description=value;
            },icon: Icons.add ),
            SizedBox(height: 10,),
            CustomTextField(hint: 'Product Category',onClick: (value){
              _category=value;
            },icon: Icons.add),
            SizedBox(height: 10,),
            CustomTextField(hint:'Product Location',onClick: (value){
              _ImageLocation=value;
            } ,icon: Icons.add),
            SizedBox(height: 20,),
            RaisedButton(
              child: Text('Add Product',),

              onPressed: (){
                print("asmaaaaaaaaaaaaaaaaaaaaaaa");
                if(_globalKey.currentState.validate()){
                  try{
                    //  print("asmaaaaaaaaaaaaaaaaaaaaaaa");
                    _globalKey.currentState.save();
                    _store.AddProduct(Product(
                        pCategory: _category,
                        pDescription: _description,
                        plocation: _ImageLocation,
                        pName: _name,
                        pPrice: _price
                    ));
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
      ),
    );
  }
}
