import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  //a list item has these properties
  late String category; //cat it belongs to
  late String name; //name
  late String price; //price of item
  late String shelfLife; //shelf life

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

  Map<String, dynamic> toJson() {
    //when posting items to db
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['name'] = name;
    data['estimatedPrice'] = price;
    data['shelf life'] = shelfLife;
    return data;
  }
}
