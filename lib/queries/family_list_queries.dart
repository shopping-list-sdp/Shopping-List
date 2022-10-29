import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/main.dart';
import 'package:shopping_list/model/List.dart';
import 'package:shopping_list/model/ListItem.dart';
import 'package:shopping_list/screens/join_family_screen.dart';

import '../screens/dashboard_screen.dart';
import 'my_list_queries.dart';

Future<void> getFamilyListInfo() async {
  //get the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list') //serch list table
      .where('family',
          isEqualTo: global.familyID) //filter to where user is this user
      //.where('type', isEqualTo: 'shared') //filter to where type is personal
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(List.fromJson(item)); //add to list of objects
  }

  List list = myObjects.singleWhere(
      (temp) => temp.type == "shared"); //get where user id is this users id

  global.familyListId = list.id; //set global variables
  global.familyListDate = list.date;
  global.familyListNoItems = list.noItems;

  //print("got list");
  //print("list id: " + global.familyListId);
  //print("list date: " + global.myListDate.toString());
  //print("no items: " + global.myListNoItems.toString());
  await getFamilyListItems(); //get the items in the list
  await calculateFamilyCost(global.familyListId);
}

Future<void> getFamilyListItems() async {
  //get the items in the list
  //print(global.familyListId);
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
}

Future<void> addFamilyListItem(
    {required String itemName, required String listID}) async {
  var collection = FirebaseFirestore.instance.collection('items');
  var querySnapshot = await collection.where('name', isEqualTo: itemName).get();
  Map<String, dynamic> data = {};
  for (var snapshot in querySnapshot.docs) {
    data = snapshot.data();
  }
  var p = data['estimatedPrice'];
  String price = p.toStringAsFixed(2);

  final docMyList = FirebaseFirestore.instance
      .collection('list_item')
      .doc(); //search list item table in db

  final json = {
    'id': docMyList.id,
    'item_id': itemName, //item id is name of item
    'list_id': listID, //list id is the id of this list
    'to_buy': true,
    'quantity': 1, //default to true
    'price': price
  };
  await docMyList.set(json);
  await updateNoItems(listID, 1); //update no items
  await getFamilyListInfo(); //get list info again
  await calculateFamilyCost(global.familyListId);
}

Future<void> calculateFamilyCost(String listId) async {
  //set new date for list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list_item') //search item table in db
      .where('list_id',
          isEqualTo: listId) //filter where name is the same as the items name
      //.where('to_buy', isEqualTo: false)
      .get(); //get from db
  double total = 0;
  double markedTotal = 0;
  //print(querySnapshot.docs);
  for (var doc in querySnapshot.docs) {
    String p = doc.get('price'); //get price
    int q = doc.get('quantity');
    total += double.parse(p) * q;

    if (doc.get('to_buy') == false) {
      String p2 = doc.get('price'); //get price
      int q2 = doc.get('quantity');
      markedTotal += double.parse(p2) * q2;
    }
  }
  global.myFamilyMarkedCost = markedTotal.toStringAsFixed(2);
  global.myFamilyCost = total.toStringAsFixed(2);
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
  global.myFamilyCost = "0.00";
  global.myFamilyMarkedCost = "0.00";
  FirebaseFirestore.instance
      .collection('list') //get from list table
      .doc(listId) //filter to list id
      .update({'no_items': 0}); //change no items to 0

  await updateFamilyDate(listId); //update date in list table
  await getFamilyListInfo(); //get list info again
}

Future<void> updateFamilyDate(String listId) async {
  //set new date for list
  FirebaseFirestore.instance
      .collection('list') //go to list tabale in db
      .doc(listId) //filter where list id is correct
      .update({'date': Timestamp.now()}); //update to current date
}

Future<void> leaveFamily(BuildContext context) async {
  //set new date for list
  FirebaseFirestore.instance
      .collection('users') //go to list tabale in db
      .doc(global.userId) //filter where list id is correct
      .update({'familyID': ""}); //update to empty
  global.familyID = "";
  Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
      (route) => false);
}

Future<void> removeFamilyList(String itemId) async {
  //clear entry from list
  var collection = FirebaseFirestore.instance
      .collection('list_item'); //search list item collection
  var snapshot = await collection
      .where('id', isEqualTo: itemId)
      .get(); //where list id is this list
  for (var doc in snapshot.docs) {
    await doc.reference
        .delete(); //delete where the items have this specific list id
  }

  //await getMyListInfo(); //get list info again
  await getFamilyListInfo(); //get list info again
  //await calculateCost(global.myListId);
  await calculateCost(global.familyListId);
}
