library global;

import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_list/model/ListItem.dart';

String? userId = '';
String myListId = '';
int myListNoItems = 0;
Timestamp myListDate = Timestamp.now();
var myList = [];
final categories = [
  'bakery',
  'beverages',
  'canned',
  'cleaning',
  'dairy',
  'dry goods',
  'fish',
  'frozen',
  'meat',
  'pet care',
  'produce',
  'toiletries'
];

final items = [
  'bread',
  'milk',
  'bagels',
  'baked beans',
  'sliced peaches',
  'rolls',
  'lemonade',
  'juice',
  'tennis biscuit'
];
