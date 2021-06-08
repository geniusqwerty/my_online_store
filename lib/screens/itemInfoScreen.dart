import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map pageArgs = ModalRoute.of(context).settings.arguments;
    String userId = pageArgs['userId'];
    DocumentSnapshot item = pageArgs['item'];

    return Scaffold(
      appBar: AppBar(
        // shoudl display the selected item name
        title: Text(item['itemName']),
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // item image, description, price and currency
              Image.network(item['image'], width: 300, height: 300),
              SizedBox(height: 10),
              Text(
                item['description'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${item['itemPrice']} ${item['currency']}",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: (){
                  print("add to cart!");
                }, 
                icon: Icon(Icons.add), 
                label: Text("Add to cart")
              ),
            ],
          ),
        ),
      ),
    );
  }
}