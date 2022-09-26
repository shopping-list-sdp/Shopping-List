import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/main.dart';
import 'package:shopping_list/model/List.dart';
import 'package:shopping_list/model/ListItem.dart';

Future<void> getMyListInfo() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list')
      .where('user', isEqualTo: global.userId)
      .where('type', isEqualTo: 'personal')
      .get();

  final data = querySnapshot.docs.map((doc) => doc.data()).toList();

  var myObjects = [];
  for (var item in data) {
    myObjects.add(List.fromJson(item));
  }

  List list = myObjects.singleWhere((temp) => temp.user == global.userId);

  global.myListId = list.id;
  global.myListDate = list.date;
  global.myListNoItems = list.noItems;

  //print("got list");
  //print("list id: " + global.myListId);
  //print("list date: " + global.myListDate.toString());
  //print("no items: " + global.myListNoItems.toString());
  await getMyListItems();
}

Future<void> getMyListItems() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list_item')
      .where('list_id',
          isEqualTo: global.myListId) //only get items for this list
      .get();

  final data = querySnapshot.docs.map((doc) => doc.data()).toList();

  var myObjects = [];
  for (var item in data) {
    myObjects.add(ListItem.fromJson(item));
  }

  global.myList = myObjects;

  for (int i = 0; i < global.myList.length; i++) {
    ListItem listItem = global.myList.elementAt(i);

    final querySnapshot = await FirebaseFirestore.instance
        .collection('items')
        .where('name', isEqualTo: listItem.itemId)
        .get();

    for (var doc in querySnapshot.docs) {
      String category = doc.get('category');
      listItem.category = category;
    }
  }

  //print("got my list");
  //print(global.myList);
}

Future<void> updateNoItems(String listId) async {
  FirebaseFirestore.instance
      .collection('list')
      .doc(listId)
      .update({'no_items': FieldValue.increment(1)});
}

Future<void> addListItem(
    {required String itemName, required String listID}) async {
  final docMyList = FirebaseFirestore.instance.collection('list_item').doc();

  final json = {
    'id': docMyList.id,
    'item_id': itemName,
    'list_id': listID,
    'to_buy': true
  };
  await updateNoItems(listID);
  await docMyList.set(json);
  await getMyListInfo();
}

Future<void> changeToBuy(bool newVal, String itemId) async {
  FirebaseFirestore.instance
      .collection('list_item')
      .doc(itemId)
      .update({'to_buy': newVal});
}

Future<void> clearList(String listId) async {
  var collection = FirebaseFirestore.instance.collection('list_item');
  var snapshot = await collection.where('list_id', isEqualTo: listId).get();
  for (var doc in snapshot.docs) {
    await doc.reference.delete();
  }

  FirebaseFirestore.instance
      .collection('list')
      .doc(listId)
      .update({'no_items': 0});

  await updateDate(listId);
  await getMyListInfo();
}

Future<void> updateDate(String listId) async {
  FirebaseFirestore.instance
      .collection('list')
      .doc(listId)
      .update({'date': Timestamp.now()});
}
