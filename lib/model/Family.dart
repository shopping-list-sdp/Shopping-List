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

  Map<String, dynamic> toJson() {
    //when posting items to db
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['familyCode'] = familyCode;
    data['name'] = name;
    return data;
  }
}
