import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/Schedule.dart';
import 'package:shopping_list/model/Schedule.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['id'] = "id";
    json['user'] = "user";
    var schedule = new Schedule.fromJson(json);
    expect(schedule.id, 'id');
    expect(schedule.user, 'user');
  });
}
