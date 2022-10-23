import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  // a Schedule has the following properties
  late String id; //id of Schedule
  late String user; //user id it belongs to

  Schedule({required this.id, required this.user});

  Schedule.fromJson(Map<String, dynamic> json) {
    //to get item from db
    id = json['id'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    //to post list to db
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    return data;
  }
}
