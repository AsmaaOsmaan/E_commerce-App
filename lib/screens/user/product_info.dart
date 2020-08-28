import 'package:e_commerc/constans.dart';
import 'package:e_commerc/models/product.dart';
import 'package:e_commerc/provider/cart_item.dart';
import 'package:e_commerc/screens/user/CartScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int Quantity=1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(product.plocation),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      child: Icon(Icons.arrow_back_ios)),
                  GestureDetector(onTap: (){
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                Opacity(
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.pName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.pDescription,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$ ${product.pPrice}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: KmainColor,
                                  child: GestureDetector(
                                      onTap: add,
                                      child: SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: Icon(Icons.add),
                                      )),
                                ),
                              ),
                              Text(Quantity.toString(),style: TextStyle(fontSize: 60),),
                              ClipOval(
                                child: Material(
                                  color: KmainColor,
                                  child: GestureDetector(
                                      onTap: subtract,
                                      child: SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: Icon(Icons.remove),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  opacity: 0.5,
                ),
                ButtonTheme(
                  height: MediaQuery.of(context).size.height * 0.1,
                  minWidth: MediaQuery.of(context).size.width,
                  child: Builder(
                  builder:(context)=> RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )),
                      color: KmainColor,
                      onPressed: () {
                        addToCart(context,product);
                      },
                      child: Text(
                        'Add to cart'.toUpperCase(),
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void add() {
    if(Quantity<50){
      setState(() {
        Quantity++;
      });
    }
  }

  void subtract() {
    if(Quantity>1){
      setState(() {
        Quantity--;
      });
    }
  }

  void addToCart(BuildContext context,Product product) {
    CartItem cartItem=  Provider.of<CartItem>(context,listen: false);
    var productItemsInCart=cartItem.products;
    bool exist=false;

    product.pQuantity=Quantity;
    for(var productItemInCart in productItemsInCart){
      if (productItemInCart.pName==product.pName){
        exist=true;
      }
    }
    if(exist){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('you have added this item befor '),
      ));
    }
    else{
      cartItem.AddProductToCart(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Added Sussesfuly'),
      ));
    }

  }
}
