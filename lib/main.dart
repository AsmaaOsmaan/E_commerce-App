import 'package:e_commerc/provider/admin_mode.dart';
import 'package:e_commerc/provider/cart_item.dart';
import 'package:e_commerc/provider/progras_hud.dart';
import 'package:e_commerc/screens/admin/add_proudct.dart';
import 'package:e_commerc/screens/admin/admin_home.dart';
import 'package:e_commerc/screens/admin/edit_producttow.dart';
//import 'package:e_commerc/screens/admin/edit_product.dart';
import 'package:e_commerc/screens/admin/manage_product.dart';
import 'package:e_commerc/screens/admin/order_details.dart';
import 'package:e_commerc/screens/admin/view_order.dart';
import 'package:e_commerc/screens/user/CartScreen.dart';
import 'package:e_commerc/screens/user/home.dart';
import 'package:e_commerc/screens/login_screen.dart';
import 'package:e_commerc/screens/signup_screen.dart';
import 'package:e_commerc/screens/user/product_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constans.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserLoggedIn=false;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(home: Scaffold(body: Center (child: Text('loading'),),),);
        }
        else{
          isUserLoggedIn=snapshot.data.getBool(KkeepMeLoggedIn)??false;
          return  MultiProvider(
            providers: [
              ChangeNotifierProvider<prograssHud>(
                  create: (context)=>prograssHud()),
              ChangeNotifierProvider<AdminMode>(
                  create: (context)=>AdminMode()),
              ChangeNotifierProvider<CartItem>(
                  create: (context)=>CartItem()),

            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? Home.id : LoginScreen.id,
              routes: {
                LoginScreen.id:(context)=>LoginScreen(),
                SignupScreen.id:(context)=>SignupScreen(),
                Home.id:(context)=>Home(),
                AdminHome.id:(context)=>AdminHome(),
                AddProduct.id:(context)=>AddProduct(),
                ManageProduct.id:(context)=>ManageProduct(),
                //  EditProduct.id:(context)=>EditProduct(),
                EditProductTwo.id:(context)=>EditProductTwo(),
                ProductInfo.id:(context)=>ProductInfo(),
                CartScreen.id:(context)=>CartScreen(),
                ViewOrders.id:(context)=>ViewOrders(),
                OrderDetails.id:(context)=>OrderDetails(),
              },
            ),
          );
        }
      },

    );

  }
}

