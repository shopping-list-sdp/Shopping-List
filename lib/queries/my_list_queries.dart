import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/main.dart';
import 'package:shopping_list/model/List.dart';
import 'package:shopping_list/model/ListItem.dart';

void getMyListInfo() async {
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
}

void getMyListItems() async {
  var list = [];
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
    ListItem list_item = global.myList.elementAt(i);

    final querySnapshot = await FirebaseFirestore.instance
        .collection('items')
        .where('name', isEqualTo: list_item.itemId)
        .get();

    for (var doc in querySnapshot.docs) {
      String category = doc.get('category');
      list_item.category = category;
    }
  }
}

void updateNoItems(String listId) async {
  FirebaseFirestore.instance
      .collection('list')
      .doc(listId)
      .update({'no_items': FieldValue.increment(1)});
}

Future addListItem({required String itemName, required String listID}) async {
  final docMyList = FirebaseFirestore.instance.collection('list_item').doc();

  final json = {
    'id': docMyList.id,
    'item_id': itemName,
    'list_id': listID,
    'to_buy': true
  };
  updateNoItems(listID);
  await docMyList.set(json);
}

void changeToBuy(bool newVal, String itemId) {
  FirebaseFirestore.instance
      .collection('list_item')
      .doc(itemId)
      .update({'to_buy': newVal});
}
