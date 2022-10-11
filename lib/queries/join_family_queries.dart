import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/global.dart' as global;

Future<void> updateUserFamilyID(String? userID, String familyID) async {
  FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .update({'familyID': familyID});
}

Future<void> joinFamily(String familyCode) async {
  //increment no items
  final strFrontCode = familyCode.substring(0, familyCode.length - 1);
  final strEndCode = familyCode.characters.last;
  final limit =
      strFrontCode + String.fromCharCode(strEndCode.codeUnitAt(0) + 1);

  var collection = FirebaseFirestore.instance.collection('family');
  var snapshot = await collection
      .where('id', isGreaterThanOrEqualTo: familyCode)
      .where('id', isLessThan: limit)
      .get();

  for (var doc in snapshot.docs) {
    global.familyID = doc.get('id');
  }
  if (snapshot.docs.isEmpty) {
    Fluttertoast.showToast(msg: "Invalid Code");
  } else {
    Fluttertoast.showToast(msg: "Joined Family");
  }
  updateUserFamilyID(global.userId, global.familyID);
}
