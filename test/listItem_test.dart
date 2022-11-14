import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/ListItem.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['id'] = "id";
    json['item_id'] = "itemId";
    json['list_id'] = "listId";
    json['to_buy'] = false;
    json['price'] = "price";
    json['quantity'] = 1;
    var listItem = ListItem.fromJson(json);
    expect(listItem.id, 'id');
    expect(listItem.itemId, 'itemId');
    expect(listItem.listId, 'listId');
    expect(listItem.toBuy, false);
    expect(listItem.price, 'price');
    expect(listItem.quantity, 1);
  });
}
