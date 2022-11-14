import 'package:cloud_firestore/cloud_firestore.dart';

class Family {
  //a list item has these properties
  late String id;
  late String familyCode; //cat it belongs to
  late String name;

  Family({
    required this.id, //required to force these paras
    required this.familyCode,
    required this.name,
  });

  Family.fromJson(Map<String, dynamic> json) {
    //when getting items from db
    id = json['id'];
    familyCode = json['familyCode'];
    name = json['name'];
  }
}
