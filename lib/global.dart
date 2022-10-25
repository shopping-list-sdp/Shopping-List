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
String myScheduleId = '';
String pantryCategory = '';
int myListNoItems = 0;
int familyListNoItems = 0;
DateTime today = DateTime.now();
Timestamp myListDate = Timestamp.now();
Timestamp familyListDate = Timestamp.now();
String myListCost = "";
var myList = [];
var familyList = [];
var myPantry = [];
var mySchedule = [];

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
  myListCost = "";
  myListNoItems = 0;
  familyListNoItems = 0;
  myListDate = Timestamp.now();
  familyListDate = Timestamp.now();
  myList = [];
  familyList = [];
  myPantry = [];
}
