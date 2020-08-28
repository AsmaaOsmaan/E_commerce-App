import 'package:e_commerc/constans.dart';
import 'package:e_commerc/models/product.dart';
import 'package:e_commerc/services/store.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id='OrderDetails';
  final Store store=Store();
  @override
  Widget build(BuildContext context) {
    String documentID=ModalRoute.of(context).settings.arguments;
    return StreamBuilder(stream: store.LoadOrderDetails(documentID),builder: (context,snabshot){
      if (snabshot.hasData){
        List<Product>products=[];
        for(var doc in snabshot.data.documents){
          products.add(Product(
            pName: doc.data[KproductName],
            pCategory: doc.data[KproductCategory],
            pQuantity: doc.data[KproductQuantity],
          ));
        }
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(itemCount: products.length,itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(20),

                  child: Container(

                    height: MediaQuery.of(context).size.height*.2,

                    color: KsecondryColor,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('product name: ${products[index].pName}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          SizedBox(height: 10,),
                          Text('product category:${products[index].pCategory}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          SizedBox(height: 10,),
                          Text('product Quantity:${products[index].pQuantity}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonTheme(
                    buttonColor: KmainColor,
                    child: RaisedButton(onPressed: (){

                    },
                    child: Text('Confirm Order'),
                    ),
                  ),
                ),

                SizedBox(width: 10,),
                Expanded(
                  child: ButtonTheme(
                    buttonColor: KmainColor,
                    child: RaisedButton(onPressed: (){

                    },
                      child: Text('Delete Order'),
                    ),
                  ),
                ),


              ],
            )
          ],
        ),
      );
      }
      else{
        return Center(child:Text('Load Details....'));
      }
    });
  }
}
