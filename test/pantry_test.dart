import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/pantry.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['id'] = "id";
    json['user'] = "user";
    var pantry = Pantry.fromJson(json);
    expect(pantry.id, 'id');
    expect(pantry.user, 'user');
  });
}
