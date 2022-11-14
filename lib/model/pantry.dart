import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/model/Item.dart';

class Pantry {
  //a list item has these properties
  late String id; //items in pantry
  late String user; //user

  Pantry(
      { //required to force these paras
      required this.user});

  Pantry.fromJson(Map<String, dynamic> json) {
    //when getting items from db
    id = json['id'];
    user = json['user'];
  }
}
