import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerc/models/product.dart';
import 'package:e_commerc/widgets/custom_pop_menu_item.dart';
//import 'package:e_commerc/screens/admin/edit_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerc/services/store.dart';

import '../../constans.dart';
import 'edit_producttow.dart';

class ManageProduct extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String id = 'ManageProduct';
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Store _store = Store();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    /*  appBar: AppBar(
        title: Text('Edit Product'),
      ),*/
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.LoadProduct(), // function where you call your api
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Please wait its loading...'));
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                  pID: doc.documentID,
                    pPrice: data[KproductPrice],
                    pName: data[KproductName],
                    plocation: data[KproductLocation],
                    pDescription: data[KproductDescription],
                    pCategory: data[KproductCategory]));
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemCount: products.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTapUp: (details){
                    double dx=details.globalPosition.dx;
                    double dy=details.globalPosition.dy;
                    double dx2=MediaQuery.of(context).size.width-dx;
                    double dy2=MediaQuery.of(context).size.height-dy;
                    showMenu(context: _scaffoldKey.currentContext, position: RelativeRect.fromLTRB(dx,dy,dx2,dy2), items: [

                      MyPopupMenuItem(
                        child: Text('Edit'),
                        onClick: (){
                         Navigator.pushNamed(context, EditProductTwo.id,arguments: products[index]);



                        },
                      ),


                      MyPopupMenuItem(
                        child: Text('Delete'),
                        onClick: (){
                        _store.delete(products[index].pID);
                        Navigator.pop(context);



                        },
                      ),


                    ]);

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
              ); // snapshot.data  :
            }
          }
        },
      ),
    );
  }
}
