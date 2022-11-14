import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  //a list item has these properties
  late String category; //cat it belongs to
  late String name; //name
  late double price; //price of item
  late int shelfLife; //shelf life

  Item(
      {required this.category, //required to force these paras
      required this.name,
      required this.price,
      required this.shelfLife});

  Item.fromJson(Map<String, dynamic> json) {
    //when getting items from db
    category = json['category'];
    name = json['name'];
    price = json['estimatedPrice'];
    shelfLife = json['shelf life'];
  }
}
