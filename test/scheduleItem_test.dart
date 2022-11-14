import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_list/model/ScheduleItem.dart';

void main() {
  test('fromJson returns  a valid object', () {
    Map<String, dynamic> json = {};
    json['id'] = "id";
    json['item_id'] = "itemId";
    json['schedule_id'] = "scheduleId";
    json['days'] = 1;
    json['date_added'] = Timestamp.now;
    var scheduleitem = ScheduleItem.fromJson(json);
    expect(scheduleitem.id, 'id');
    expect(scheduleitem.itemId, 'itemId');
    expect(scheduleitem.scheduleId, 'scheduleId');
    expect(scheduleitem.days, 1);
    expect(scheduleitem.dateAdded, Timestamp);
  });
}
