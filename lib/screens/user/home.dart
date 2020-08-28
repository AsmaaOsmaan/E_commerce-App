import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerc/models/product.dart';
import 'package:e_commerc/screens/user/CartScreen.dart';
import 'package:e_commerc/screens/user/product_info.dart';
import 'package:e_commerc/services/auth.dart';
import 'package:e_commerc/widgets/product_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerc/constans.dart';
import 'package:e_commerc/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions.dart';
import '../login_screen.dart';

class Home extends StatefulWidget {
  static String id = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = Auth();
  Store _store = Store();
  int tabBarIndex = 0;
  int bottomBarIndex = 0;
  List<Product> _products;
  FirebaseUser _loggedUser;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: bottomBarIndex,
                onTap: (value)async {
                  if(value==2){
                    SharedPreferences pref= await SharedPreferences.getInstance();
                    pref.clear();
                    await _auth.SignOut();
                    Navigator.pushNamed(context,  LoginScreen.id);

                  }
                  setState(() {
                    bottomBarIndex = value;
                  });
                },
                fixedColor: KmainColor,
                items: [
                  BottomNavigationBarItem(
                      title: Text('test'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('test'), icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      title: Text('Sign out'), icon: Icon(Icons.close)),

                ]),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: KmainColor,
                onTap: (value) {
                  setState(() {
                    tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(
                    'Jackets',
                    style: TextStyle(
                        color: tabBarIndex == 0 ? Colors.black : KunActiveColor,
                        fontSize: tabBarIndex == 0 ? 16 : null),
                  ),
                  Text('Trouser',
                      style: TextStyle(
                          color:
                              tabBarIndex == 1 ? Colors.black : KunActiveColor,
                          fontSize: tabBarIndex == 0 ? 16 : null)),
                  Text('T_shirts',
                      style: TextStyle(
                          color:
                              tabBarIndex == 2 ? Colors.black : KunActiveColor,
                          fontSize: tabBarIndex == 0 ? 16 : null)),
                  Text('Shoes',
                      style: TextStyle(
                          color:
                              tabBarIndex == 3 ? Colors.black : KunActiveColor,
                          fontSize: tabBarIndex == 0 ? 16 : null)),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                JacketView(),
                productView(KTrouser, _products),
                productView(KTshirts, _products),
                productView(KShoes, _products),
                //  Text('ytttt'),
                //   Text('ytttt'),
                //  Text('ytttt'),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: Icon(Icons.shopping_cart),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget JacketView() {
    return StreamBuilder<QuerySnapshot>(
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
            _products = [...products];
            products.clear();
            products = getProductByCategory(KJackets, _products);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              itemCount: products.length,
              itemBuilder: (context, index) => GestureDetector(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfo.id,
                        arguments: products[index]);
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
            ); // snapshot.data  :
          }
        }
      },
    );
  }

  /*List<Product> getProductByCategory(String productCatgory) {

List<Product>products=[];
    try{
      for(var product in _products){
        if(product.pCategory==productCatgory){
          products.add(product);
        }
      }
    }
  on Error  catch(e){
      print(e);
    }
    return products;
  }*/

  /*Widget  productView(String pCategory) {
    List<Product>products;
    products=getProductByCategory(pCategory);
   return GridView.builder(
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2, childAspectRatio: 0.8),
     itemCount: products.length,
     itemBuilder: (context, index) => GestureDetector(

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
   );

 }*/
  /*getCurrentUser()async{
    _loggedUser= await _auth.getUser();
  }*/
}
