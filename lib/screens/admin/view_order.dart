import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerc/constans.dart';
import 'package:e_commerc/models/order.dart';
import 'package:e_commerc/screens/admin/order_details.dart';
import 'package:e_commerc/services/store.dart';
import 'package:flutter/material.dart';

class ViewOrders extends StatelessWidget {
  static String id = 'ViewOrders';
  final Store srore = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: srore.LoadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('There is no data'),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.documents) {
              orders.add(Order(
                documentID:doc.documentID,
                Addres: doc.data[KAddres],
                totalPrice: doc.data[KorderPrice],
              ));
            }
            return ListView.builder(itemCount: orders.length,itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].documentID);
                },
                child: Container(

                  height: MediaQuery.of(context).size.height*.2,

                  color: KsecondryColor,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(orders[index].totalPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                        SizedBox(height: 10,),
                        Text(orders[index].Addres,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }
        },
      ),
    );
  }
}
