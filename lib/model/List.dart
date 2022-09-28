import 'package:cloud_firestore/cloud_firestore.dart';

class List {
  late Timestamp date;
  late String family;
  late String id;
  late String name;
  late int noItems;
  late String type;
  late String user;

  List(
      {required this.date,
      required this.family,
      required this.id,
      required this.name,
      required this.noItems,
      required this.type,
      required this.user});

  List.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    family = json['family'];
    id = json['id'];
    name = json['name'];
    noItems = json['no_items'];
    type = json['type'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['family'] = family;
    data['id'] = id;
    data['name'] = name;
    data['no_items'] = noItems;
    data['type'] = type;
    data['user'] = user;
    return data;
  }
}
