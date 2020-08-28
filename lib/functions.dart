


import 'models/product.dart';

List<Product> getProductByCategory(String productCatgory,List<Product>allProduct) {

  List<Product>products=[];
  try{
    for(var product in allProduct){
      if(product.pCategory==productCatgory){
        products.add(product);
      }
    }
  }
  on Error  catch(e){
    print(e);
  }
  return products;
}