import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerc/models/product.dart';
import 'package:e_commerc/screens/admin/add_proudct.dart';
import 'package:e_commerc/constans.dart';
import 'package:e_commerc/screens/login_screen.dart';
class Store{
  final Firestore _firestore=Firestore.instance;
  AddProduct(Product product){
_firestore.collection(KproductsCollection).add({
  KproductName:product.pName,
  KproductDescription:product.pDescription,
  KproductPrice:product.pPrice,
  KproductCategory:product.pCategory,
  KproductLocation:product.plocation
   });
  }

 Stream<QuerySnapshot> LoadProduct(){
    return _firestore.collection(KproductsCollection).snapshots();

  }
  delete(documentID){
    _firestore.collection(KproductsCollection).document(documentID).delete();
  }
  EditProduct(data,documentID){
    _firestore.collection(KproductsCollection).document(documentID).updateData(data);
  }
  StoreOrders(data,List<Product>products){


    var documentRefrance=_firestore.collection(Korder).document();
    documentRefrance.setData(data);
    for(var product in products){
      documentRefrance.collection(KorderDetails).document().setData({
        KproductName:product.pName,
        KproductLocation:product.plocation,
        KproductPrice:product.pPrice,
        KproductQuantity:product.pQuantity,
        KproductCategory:product.pCategory,
      });
    }
  }
  Stream<QuerySnapshot> LoadOrders(){
    return _firestore.collection(Korder).snapshots();

  }
  Stream<QuerySnapshot> LoadOrderDetails(documentID){
    return _firestore.collection(Korder).document(documentID).collection(KorderDetails).snapshots();

  }
}