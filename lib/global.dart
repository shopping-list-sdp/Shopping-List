library global;

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String? userId = '';
String myListId = '';
int myListNoItems = 0;
Timestamp myListDate = Timestamp.now();
var myListItems = [];
final Map<String, String> myListItemCategory = {};
