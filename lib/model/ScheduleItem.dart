import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleItem {
  late Timestamp dateAdded;
  late int days; //date it was last cleared
  late String id; //id of the list item
  late String itemId; //item id
  late String scheduleId; // list id of list item belongs to
  String category = ""; //category item belongs to

  ScheduleItem(
      //required to force these paras
      {required this.id,
      required this.itemId,
      required this.scheduleId,
      required this.days,
      required this.category,
      required this.dateAdded});

  ScheduleItem.fromJson(Map<String, dynamic> json) {
    //to get item from db
    id = json['id'];
    itemId = json['item_id'];
    scheduleId = json['schedule_id'];
    days = json['days'];
    dateAdded = json['date_added'];
  }
}
