import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  late String category;
  late String name;
  late int price;
  late String shelfLife;

  Item(
      {required this.category,
      required this.name,
      required this.price,
      required this.shelfLife});

  Item.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    name = json['name'];
    price = json['price'];
    shelfLife = json['shelf life'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['name'] = name;
    data['price'] = price;
    data['shelf life'] = shelfLife;
    return data;
  }
}
