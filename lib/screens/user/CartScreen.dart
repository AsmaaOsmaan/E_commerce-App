import 'package:e_commerc/constans.dart';
import 'package:e_commerc/models/product.dart';
import 'package:e_commerc/provider/cart_item.dart';
import 'package:e_commerc/screens/user/product_info.dart';
import 'package:e_commerc/services/store.dart';
import 'package:e_commerc/widgets/custom_pop_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var Address;
  @override
  Widget build(BuildContext context) {

    List<Product> products = Provider.of<CartItem>(context).products;

    final double ScreenHeight = MediaQuery.of(context).size.height;
    final double ScreenWidth = MediaQuery.of(context).size.width;
    final double AppbarHeight = AppBar().preferredSize.height;
    final double statuesBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
   //   key:_scaffoldKey ,
      appBar: AppBar(
        title: Text(
          'My cart',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constrains) {
              if (products.isNotEmpty) {
                return Container(
                    height: ScreenHeight-ScreenHeight*0.08-AppbarHeight-statuesBarHeight,
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(15),
                            child: GestureDetector(
                              onTapUp: (details){
                                showCustomMenu(details,context,products[index]);
                              },
                              child: Container(
                                color: KsecondryColor,
                                height: ScreenHeight * 0.15,
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: ScreenHeight * 0.15 / 2,
                                      backgroundImage:
                                          AssetImage(products[index].plocation),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  products[index].pName,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '\$${products[index].pPrice}',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(right: 20),
                                              child: Text(
                                                products[index]
                                                    .pQuantity
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );

              } else {
                return Container(
                    height: ScreenHeight -
                        ScreenHeight * 0.08 -
                        AppbarHeight -
                        statuesBarHeight,
                    child: Center(child: Text('Cart Empty')));
              }
            },
          ),
          Builder(
            builder:(context)=> ButtonTheme(
              minWidth: ScreenWidth,
              height: ScreenHeight * 0.08,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                onPressed: () {

                  showAlertDialog(products,context);
                },
                child: Text('ODER'),
                color: KmainColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details, context,Product product) async{


      double dx=details.globalPosition.dx;
      double dy=details.globalPosition.dy;
      double dx2=MediaQuery.of(context).size.width-dx;
      double dy2=MediaQuery.of(context).size.height-dy;
      showMenu(context: context, position: RelativeRect.fromLTRB(dx,dy,dx2,dy2), items: [

        MyPopupMenuItem(
          child: Text('Edit'),
          onClick: (){

    Navigator.pop(context);
    Provider.of<CartItem>(context,listen: false).DeleteProductFromCart(product);
    Navigator.pushNamed(context, ProductInfo.id,arguments:product );


          },
        ),


        MyPopupMenuItem(
          child: Text('Delete'),
          onClick: (){


            Navigator.pop(context);
            Provider.of<CartItem>(context,listen: false).DeleteProductFromCart(product);

          },
        ),


      ]);


  }

  void showAlertDialog(List <Product>products,context)async {
    var price=getTotalPrice(products);
    AlertDialog alert=AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
      try{
        Store store=Store();
        store.StoreOrders({
          KorderPrice:price,
          KAddres:Address
        }, products);
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('order Sussesfuly'),
        ));
      Navigator.pop(context);
      }
      catch(e){
        print('ddddd${e.message}');

      }

          },
          child: Text('Confirm'),
        )
      ],
      title: Text('total price \$ $price'),
      content: TextField(
        onChanged: (value){
          Address=value;
        },
        decoration: InputDecoration(hintText: 'Enter your address'),
      ),

    );
    await showDialog(context:context,builder: (context){
      return alert;
    });
  }

  getTotalPrice(List <Product>products) {
    var price=0;
    for(var product in products ){
      price+=product.pQuantity*int.parse(product.pPrice);
    }
     return price;
  }
}
