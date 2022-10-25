import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/model/Schedule.dart';
import 'package:shopping_list/model/ScheduleItem.dart';
import 'package:shopping_list/queries/my_list_queries.dart';

Future<void> getMyScheduleInfo() async {
  //get the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('schedule') //serch list table
      .where('user',
          isEqualTo: global.userId) //filter to where user is this user
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(Schedule.fromJson(item)); //add to list of objects
  }

  Schedule schedule = myObjects.singleWhere((temp) =>
      temp.user == global.userId); //get where user id is this users id

  global.myScheduleId = schedule.id; //set global variables
  print("sID = " + global.myScheduleId);

  //print("got list");
  //print("list id: " + global.myListId);
  //print("list date: " + global.myListDate.toString());
  //print("no items: " + global.myListNoItems.toString());
  await getMyScheduledItems(); //get the items in the list
}

Future<void> getMyScheduledItems() async {
  //get the items in the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('scheduled_items') //search table list item
      .where('schedule_id',
          isEqualTo: global.myScheduleId) //only get items for this list
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(ScheduleItem.fromJson(item)); //add objects to list
  }

  global.mySchedule = myObjects; //set global variable

  for (int i = 0; i < global.mySchedule.length; i++) {
    ScheduleItem scheduleItem = global.mySchedule.elementAt(i);

    Timestamp ftr = scheduleItem.dateAdded;
    DateTime dst = ftr.toDate();

    if (global.today.isAfter(dst.add(Duration(days: scheduleItem.days)))) {
      await updateDate(scheduleItem.id);
      addListItem(itemName: scheduleItem.itemId, listID: global.myListId);
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('items') //search item table in db
        .where('name',
            isEqualTo: scheduleItem
                .itemId) //filter where name is the same as the items name
        .get(); //get from db

    for (var doc in querySnapshot.docs) {
      String category = doc.get('category'); //get cattegory
      scheduleItem.category = category; //update category of object in list
    }
  }

  //print("got my list");
  //print(global.myList);
}

Future<void> addScheduleItem(
    {required String itemName,
    required String scheduleID,
    required int days,
    required Timestamp dateAdded}) async {
  final docMySchedule = FirebaseFirestore.instance
      .collection('scheduled_items')
      .doc(); //search list item table in db

  final json = {
    'date_added': dateAdded,
    'days': days,
    'id': docMySchedule.id,
    'item_id': itemName, //item id is name of item
    'schedule_id': scheduleID, //list id is the id of this list
  };
  await docMySchedule.set(json);
  await getMyScheduleInfo(); //get list info again
}

Future<void> changeFrequency(int newVal, String itemId) async {
  //change buy status
  FirebaseFirestore.instance
      .collection('scheduled_items') //search list item table
      .doc(itemId) //filter where item id is the same as specific item
      .update({'days': newVal}); //change to buy to false
}

Future<void> updateDate(String itemId) async {
  //change buy status
  FirebaseFirestore.instance
      .collection('scheduled_items') //search list item table
      .doc(itemId) //filter where item id is the same as specific item
      .update({'date_added': Timestamp.now()}); //change to buy to false
}

Future<void> clearSchedule(String scheduleId) async {
  //clear entire list
  var collection = FirebaseFirestore.instance
      .collection('scheduled_items'); //search list item collection
  var snapshot = await collection
      .where('schedule_id', isEqualTo: scheduleId)
      .get(); //where list id is this list
  for (var doc in snapshot.docs) {
    await doc.reference
        .delete(); //delete where the items have this specific list id
  }

  //print("working");

  await getMyScheduleInfo(); //get list info again
}
