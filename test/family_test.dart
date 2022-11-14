import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/Family.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['id'] = 'Test';
    json['familyCode'] = 'Test';
    json['name'] = 'Test';
    var family = Family.fromJson(json);
    expect(family.name, 'Test');
  });
}
