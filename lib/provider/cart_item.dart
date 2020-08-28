import 'package:e_commerc/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier{
  List<Product>products=[];
  AddProductToCart(Product product){
    products.add(product);
    notifyListeners();
  }

  DeleteProductFromCart(Product product){
    products.remove(product);
    notifyListeners();
  }

}
