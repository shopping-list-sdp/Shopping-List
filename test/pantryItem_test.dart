import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/pantryItem.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['id'] = "id";
    json['item_id'] = "itemId";
    json['pantry_id'] = "pantryId";
    json['quantity'] = 1;
    var pantryitem = pantryItem.fromJson(json);
    expect(pantryitem.id, 'id');
    expect(pantryitem.itemId, 'itemId');
    expect(pantryitem.pantryId, 'pantryId');
    expect(pantryitem.quantity, 1);
  });

  test('contains returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['id'] = "id";
    json['item_id'] = "itemId";
    json['pantry_id'] = "pantryId";
    json['quantity'] = 1;
    var pantryitem = pantryItem.fromJson(json);
    expect(pantryitem.Contains("itemId"), true);
  });
}
