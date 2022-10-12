import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/main.dart';
import 'package:shopping_list/model/pantry.dart';
import 'package:shopping_list/model/pantryItem.dart';

Future<dynamic> getMyPantryInfo() async {
  //get the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('pantry') //serch list table
      .where('user',
          isEqualTo: global.userId) //filter to where user is this user
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(Pantry.fromJson(item)); //add to list of objects
  }

  Pantry pantry = myObjects.singleWhere((temp) =>
      temp.user == global.userId); //get where user id is this users id

  global.myPantryId = pantry.id;
  print(global.myPantryId); //set global variables

  //print("got list");
  //print("list id: " + global.myListId);
  //print("list date: " + global.myListDate.toString());
  //print("no items: " + global.myListNoItems.toString());
  await getMyPantryItems(); //get the items in the list
  return true;
}

Future<dynamic> getMyPantryItems() async {
  //get the items in the list
  final querySnapshot = await FirebaseFirestore.instance
      .collection('pantry_item') //search table list item
      .where('pantry_id', isEqualTo: global.myPantryId)
      //.where('') //only get items for this list
      .get(); //get from db

  final data =
      querySnapshot.docs.map((doc) => doc.data()).toList(); //convert to list

  var myObjects = [];
  for (var item in data) {
    myObjects.add(pantryItem.fromJson(item)); //add objects to list
  }

  global.myPantry = myObjects; //set global variable

  for (int i = 0; i < global.myPantry.length; i++) {
    pantryItem PantryItem = global.myPantry.elementAt(i);
    print(PantryItem.id);

    final querySnapshot = await FirebaseFirestore.instance
        .collection('items') //search item table in db
        .where('category',
            isEqualTo: global
                .pantryCategory) //filter where name is the same as the items name
        .get(); //get from db

    for (var doc in querySnapshot.docs) {
      String category = doc.get('category'); //get cattegory
      if (PantryItem.itemId == doc.get('name')) {
        PantryItem.category = category;
      } //update category of object in list
    }
  }

  for (int j = 0; j < global.myPantry.length; j++) {
    //print("got my list");
    print("name = " + global.myPantry.elementAt(j).itemId);
    print("category = " + global.myPantry.elementAt(j).category);
  }

  return true;
}

Future<void> updateNoItems(String itemId, int number) async {
  //increment no items
  FirebaseFirestore.instance
      .collection('pantry_item') //search list table
      .doc(itemId)
      //.doc(itemId) //get specific doc from list table
      .update({'quantity': FieldValue.increment(number)}); //increment no items
}

Future<void> addPantryItem(
    //add item to list
    {required String itemName,
    required String pantryID}) async {
  final docMyList = FirebaseFirestore.instance
      .collection('pantry_item')
      .doc(); //search list item table in db

  final json = {
    'id': docMyList.id,
    'item_id': itemName, //item id is name of item
    'pantry_id': pantryID, //list id is the id of this list
    'quantity': 1 //default to true
  };
  //await updateNoItems(pantryID, 1); //update no items
  await docMyList.set(json);
  await getMyPantryInfo(); //get list info again
}

Future<void> clearList() async {
  //clear entire list
  var collection = FirebaseFirestore.instance
      .collection('pantry_item'); //search list item collection
  var snapshot = await collection
      .where('pantry_id', isEqualTo: global.myPantryId)
      .get(); //where list id is this list
  for (var doc in snapshot.docs) {
    await doc.reference
        .delete(); //delete where the items have this specific list id
  }

  await getMyPantryInfo(); //get list info again
}

Future<void> removeFromList(String itemId) async {
  //clear entire list
  var collection = FirebaseFirestore.instance
      .collection('pantry_item'); //search list item collection
  var snapshot = await collection
      .where('id', isEqualTo: itemId)
      .get(); //where list id is this list
  for (var doc in snapshot.docs) {
    await doc.reference
        .delete(); //delete where the items have this specific list id
  }

  await getMyPantryInfo(); //get list info again
}
