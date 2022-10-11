import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/main.dart';
import 'package:shopping_list/model/List.dart';
import 'package:shopping_list/model/ListItem.dart';

import 'my_list_queries.dart';

Future<void> getFamilyListInfo() async {
  //get the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list') //serch list table
      .where('user',
          isEqualTo: global.userId) //filter to where user is this user
      .where('type', isEqualTo: 'shared') //filter to where type is personal
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(List.fromJson(item)); //add to list of objects
  }

  List list = myObjects.singleWhere((temp) =>
      temp.user == global.userId); //get where user id is this users id

  global.familyListId = list.id; //set global variables
  global.familyListDate = list.date;
  global.familyListNoItems = list.noItems;

  //print("got list");
  //print("list id: " + global.myListId);
  //print("list date: " + global.myListDate.toString());
  //print("no items: " + global.myListNoItems.toString());
  await getFamilyListItems(); //get the items in the list
}

Future<void> getFamilyListItems() async {
  //get the items in the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list_item') //search table list item
      .where('list_id',
          isEqualTo: global.familyListId) //only get items for this list
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(ListItem.fromJson(item)); //add objects to list
  }

  global.familyList = myObjects; //set global variable

  for (int i = 0; i < global.familyList.length; i++) {
    ListItem listItem = global.familyList.elementAt(i);

    final querySnapshot = await FirebaseFirestore.instance
        .collection('items') //search item table in db
        .where('name',
            isEqualTo: listItem
                .itemId) //filter where name is the same as the items name
        .get(); //get from db

    for (var doc in querySnapshot.docs) {
      String category = doc.get('category'); //get cattegory
      listItem.category = category; //update category of object in list
    }
  }

  //print("got my list");
  //print(global.myList);
}

Future<void> addFamilyListItem(
    {required String itemName, required String listID}) async {
  final docMyList = FirebaseFirestore.instance
      .collection('list_item')
      .doc(); //search list item table in db

  final json = {
    'id': docMyList.id,
    'item_id': itemName, //item id is name of item
    'list_id': listID, //list id is the id of this list
    'to_buy': true //default to true
  };
  await updateNoItems(listID); //update no items
  await docMyList.set(json);
  await getFamilyListInfo(); //get list info again
}

Future<void> clearFamilyList(String listId) async {
  //clear entire list
  var collection = FirebaseFirestore.instance
      .collection('list_item'); //search list item collection
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
  await getFamilyListInfo(); //get list info again
}
