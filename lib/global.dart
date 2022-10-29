library global;

import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_list/model/ListItem.dart';
import 'package:shopping_list/model/pantryItem.dart';

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
String myListMarkedCost = "";
String myFamilyCost = "";
String myFamilyMarkedCost = "";
var myList = [];
var familyList = [];
var myPantry = [];
var mySchedule = [];

var pantryitems = [];

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
  myScheduleId = '';
  pantryCategory = '';
  myListCost = "";
  myListNoItems = 0;
  familyListNoItems = 0;
  today = DateTime.now();
  myListDate = Timestamp.now();
  familyListDate = Timestamp.now();
  myListMarkedCost = "";
  myFamilyCost = "";
  myFamilyMarkedCost = "";
  myList = [];
  familyList = [];
  myPantry = [];
  mySchedule = [];
  pantryitems = [];
}
