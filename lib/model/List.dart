import 'package:cloud_firestore/cloud_firestore.dart';

class List {
  // a list has the following properties
  late Timestamp date; //date it was last cleared
  late String family; //family id if its a family list
  late String id; //id of list
  late String name; //name of list
  late int noItems; //no items in the list
  late String type; //type family, personal or concept
  late String user; //user id it belongs to

  List(
      {required this.date, //required to force user to enter these paras
      required this.family,
      required this.id,
      required this.name,
      required this.noItems,
      required this.type,
      required this.user});

  List.fromJson(Map<String, dynamic> json) {
    //to get item from db
    date = json['date'];
    family = json['family'];
    id = json['id'];
    name = json['name'];
    noItems = json['no_items'];
    type = json['type'];
    user = json['user'];
  }
}
