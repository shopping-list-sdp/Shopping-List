import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/Item.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['category'] = 'Test';
    json['name'] = 'Test';
    json['estimatedPrice'] = 1.0;
    json['shelf life'] = 1;
    var item = Item.fromJson(json);
    expect(item.category, 'Test');
  });
}
