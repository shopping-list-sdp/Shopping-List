import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/List.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Timestamp date = Timestamp.now();
    Map<String, dynamic> json = {};
    json['date'] = date;
    json['family'] = "family";
    json['id'] = "id";
    json['name'] = "name";
    json['no_items'] = 1;
    json['type'] = "type";
    json['user'] = "user";
    var list = List.fromJson(json);
    expect(list.date, date);
    expect(list.family, 'family');
    expect(list.id, 'id');
    expect(list.name, 'name');
    expect(list.noItems, 1);
    expect(list.type, 'type');
    expect(list.user, 'user');
  });
}
