import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/Item.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = new Map();
    json['category'] = 'Test';
    json['name'] = 'Test';
    json['price'] = 1;
    json['shelf life'] = 'Test';
    var item = Item.fromJson(json);
    expect(item.category, 'Test');
  });
}
