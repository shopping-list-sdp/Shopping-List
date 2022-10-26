import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/queries/family_list_queries.dart';
import 'package:shopping_list/screens/family_list_screen.dart';

Future<void> getFamilyID(String? userID) async {
  var collection = FirebaseFirestore.instance.collection('users');
  var snapshot = await collection.where('uid', isEqualTo: userID).get();

  for (var doc in snapshot.docs) {
    global.familyID = doc.get('familyID');
  }
}

Future<void> updateUserFamilyID(String? userID, String familyID) async {
  FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .update({'familyID': familyID});
}

Future<void> joinFamily(String familyCode, BuildContext context) async {
  //increment no items
  if (familyCode == "") {
    Fluttertoast.showToast(msg: "Enter Code");
    return;
  }

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

  await updateUserFamilyID(global.userId, global.familyID);
  await getFamilyListInfo();

  // ignore: use_build_context_synchronously
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const FamilyListScreen()),
  );
}

Future<void> createFamily(
    {required String name, required BuildContext context}) async {
  if (name == "") {
    Fluttertoast.showToast(msg: "Enter A Name");
    return;
  } else if (name.length < 4) {
    Fluttertoast.showToast(msg: "Invalid Name");
    return;
  }
  final docMyList = FirebaseFirestore.instance.collection('family').doc();

  final json = {
    'id': docMyList.id,
    'familyCode': docMyList.id.substring(0, 5), //item id is name of item
    'name': name //list id is the id of this list
  };
  Fluttertoast.showToast(msg: "Family Created");
  await docMyList.set(json);

  global.familyID = docMyList.id;
  updateUserFamilyID(global.userId, global.familyID);
  createFamilyList(familyID: global.familyID, userID: global.userId);
  getFamilyListInfo();
  // ignore: use_build_context_synchronously
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const FamilyListScreen()),
  );
}

Future createFamilyList(
    {required String? familyID, required String? userID}) async {
  final docMyList = FirebaseFirestore.instance.collection('list').doc();

  final json = {
    'name': 'familyList',
    'no_items': 0,
    'family': familyID,
    'id': docMyList.id,
    'type': 'shared',
    'user': userID,
    'date': FieldValue.serverTimestamp()
  };
  await docMyList.set(json);
  global.familyListId = docMyList.id;
}
