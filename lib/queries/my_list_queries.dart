import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/main.dart';
import 'package:shopping_list/model/List.dart';
import 'package:shopping_list/model/ListItem.dart';

import '../model/Item.dart';

Future<void> getMyListInfo() async {
  //get the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list') //serch list table
      .where('user',
          isEqualTo: global.userId) //filter to where user is this user
      .where('type', isEqualTo: 'personal') //filter to where type is personal
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(List.fromJson(item)); //add to list of objects
  }

  List list = myObjects.singleWhere((temp) =>
      temp.user == global.userId); //get where user id is this users id

  global.myListId = list.id; //set global variables
  global.myListDate = list.date;
  global.myListNoItems = list.noItems;

  //print("got list");
  //print("list id: " + global.myListId);
  //print("list date: " + global.myListDate.toString());
  //print("no items: " + global.myListNoItems.toString());
  await getMyListItems(); //get the items in the list
  await calculateCost(global.myListId);
}

Future<void> getMyListItems() async {
  //get the items in the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list_item') //search table list item
      .where('list_id',
          isEqualTo: global.myListId) //only get items for this list
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(ListItem.fromJson(item)); //add objects to list
  }

  global.myList = myObjects; //set global variable

  for (int i = 0; i < global.myList.length; i++) {
    ListItem listItem = global.myList.elementAt(i);

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

Future<void> updateNoItems(String listId) async {
  //increment no items
  FirebaseFirestore.instance
      .collection('list') //search list table
      .doc(listId) //get specific doc from list table
      .update({'no_items': FieldValue.increment(1)}); //increment no items
}

Future<void> updateItemPrice(String id, String price) async {
  //print(price);
  price = price.replaceAll(",", ".");
  //print(price);
  FirebaseFirestore.instance
      .collection('list_item') //search list table
      .doc(id) //get specific doc from list table
      .update({'price': price}); //increment no items
  await calculateCost(global.myListId);
}

Future<void> addListItem(
    {required String itemName, required String listID}) async {
  bool flag = false;
  for (ListItem listitems in global.myList) {
    if (listitems.itemId.compareTo(itemName) == 0) {
      flag = true;
      break;
    }
  }

  if (flag == false) {
    /*final querySnap = await FirebaseFirestore.instance
        .collection(
            'items') //serch list table //filter to where type is personal
        .get();

    final Data =
        querySnap.docs.map((doc) => doc.data()).toList(); //convert to list

    var myObjects = [];
    for (var item in Data) {
      myObjects.add(Item.fromJson(item)); //add to list of objects
    }

    global.pantryitems = myObjects;*/
    var collection = FirebaseFirestore.instance.collection('items');
    var querySnapshot =
        await collection.where('name', isEqualTo: itemName).get();
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
    await updateNoItems(listID); //update no items
    await docMyList.set(json);
    await getMyListInfo(); //get list info again
    await calculateCost(global.myListId);
  }
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
      .collection('list_item'); //search list item collection
  var snapshot = await collection
      .where('list_id', isEqualTo: listId)
      .get(); //where list id is this list
  for (var doc in snapshot.docs) {
    await doc.reference
        .delete(); //delete where the items have this specific list id
    global.myListCost = "0.00";
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

Future<void> calculateCost(String listId) async {
  //set new date for list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list_item') //search item table in db
      .where('list_id',
          isEqualTo: listId) //filter where name is the same as the items name
      //.where('to_buy', isEqualTo: false)
      .get(); //get from db
  double total = 0;
  //print(querySnapshot.docs);
  for (var doc in querySnapshot.docs) {
    //print(doc);
    String p = doc.get('price'); //get price
    //print(double.parse(p));
    total += double.parse(p);
  }
  global.myListCost = total.toStringAsFixed(2);
}
