import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/model/Schedule.dart';
import 'package:shopping_list/model/ScheduleItem.dart';

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
    required String days,
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

Future<void> changeToBuy(bool newVal, String itemId) async {
  //change buy status
  FirebaseFirestore.instance
      .collection('list_item') //search list item table
      .doc(itemId) //filter where item id is the same as specific item
      .update({'to_buy': newVal}); //change to buy to false
}

Future<void> clearList(String listId) async {
  //clear entire list
  var collection = FirebaseFirestore.instance
      .collection('Scheduled_items'); //search list item collection
  var snapshot = await collection
      .where('list_id', isEqualTo: listId)
      .get(); //where list id is this list
  for (var doc in snapshot.docs) {
    await doc.reference
        .delete(); //delete where the items have this specific list id
  }

  FirebaseFirestore.instance
      .collection('list') //get from list table
      .doc(listId) //filter to list id
      .update({'no_items': 0}); //change no items to 0

  await updateDate(listId); //update date in list table
  await getMyListInfo(); //get list info again
}

Future<void> updateDate(String listId) async {
  //set new date for list
  FirebaseFirestore.instance
      .collection('list') //go to list tabale in db
      .doc(listId) //filter where list id is correct
      .update({'date': Timestamp.now()}); //update to current date
}
