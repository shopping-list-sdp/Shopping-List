import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;

void getMyListInfo() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list')
      .where('user', isEqualTo: global.userId)
      .where('type', isEqualTo: 'personal')
      .get();

  for (var doc in querySnapshot.docs) {
    // Getting data directly
    global.myListId = doc.get('id');
    global.myListDate = doc.get('date');
    global.myListNoItems = doc.get('no_items');
  }
}

void getMyListItems() async {
  var list = [];
  final querySnapshot = await FirebaseFirestore.instance
      .collection('list_item')
      .where('list_id', isEqualTo: global.myListId)
      .get();

  for (var doc in querySnapshot.docs) {
    // Getting data directly
    list.add(doc.get('item_id'));
  }
  global.myListItems = list;
  for (int i = 0; i < global.myListItems.length; i++) {
    //print(global.myListItems[i]);
    final querySnapshot = await FirebaseFirestore.instance
        .collection('items')
        .where('name', isEqualTo: global.myListItems[i])
        .get();

    for (var doc in querySnapshot.docs) {
      String category = doc.get('category');
      global.myListItemCategory[global.myListItems[i]] = category;
    }
  }
  print(global.myListItemCategory);
}

void test() {
  //print(global.);
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
    'item_id': itemName,
    'list_id': listID,
  };
  updateNoItems(listID);
  await docMyList.set(json);
}
