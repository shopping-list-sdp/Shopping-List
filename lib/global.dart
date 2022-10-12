library global;

import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_list/model/ListItem.dart';

String? userId = '';
String myListId = '';
String familyListId = '';
String familyID = '';
String myPantryId = '';
String pantryCategory = '';
int myListNoItems = 0;
int familyListNoItems = 0;
Timestamp myListDate = Timestamp.now();
Timestamp familyListDate = Timestamp.now();
var myList = [];
var familyList = [];
var myPantry = [];
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

void resetGlobal() {
  userId = '';
  myListId = '';
  familyListId = '';
  familyID = '';
  myPantryId = '';
  pantryCategory = '';
  myListNoItems = 0;
  familyListNoItems = 0;
  myListDate = Timestamp.now();
  familyListDate = Timestamp.now();
  myList = [];
  familyList = [];
  myPantry = [];
}
