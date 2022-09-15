import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/custom_icons_icons.dart';
import 'package:shopping_list/model/family_model.dart';
import 'package:shopping_list/model/user_model.dart';
import 'package:shopping_list/classes/body_layout.dart';
import 'package:shopping_list/reusable_widgets/reusable_widgets.dart';

import '../utils/color_utils.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  late TextEditingController controller;
  String name = "";
  String searchName = "";

  List<String> elements = [];
  List<String> temp = [];

  void add(String value) {
    setState(() {
      elements.add(value);
    });
  }

  postDetailsToFirestore(String value) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    FamilyModel familyModel = FamilyModel();

    // writing all the values
    familyModel.full_name = value;

    await firebaseFirestore.collection("family").doc().set(familyModel.toMap());
    Fluttertoast.showToast(msg: "Family created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const PantryScreen()),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  final searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myColors("White"),
        body: SingleChildScrollView(
          //width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text("Pantry",
                  style: TextStyle(
                      color: myColors("Purple"),
                      fontSize: 30,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              const Image(image: AssetImage('assets/pantryScreen/stall.png')),
              const SizedBox(
                height: 30,
              ),
              searchField("Search Catagories", CustomIcons.search,
                  searchTextEditingController),
              const Image(
                  image: AssetImage('assets/pantryScreen/Rectangle_5.png')),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/pantryScreen/Rectangle_6.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(
                      image: AssetImage('assets/pantryScreen/vegetables.png'))
                ]),
                const SizedBox(
                  width: 25,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/pantryScreen/Rectangle_8.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(
                      image: AssetImage('assets/pantryScreen/fruit.png'))
                ]),
                const SizedBox(
                  width: 25,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/pantryScreen/Rectangle_7.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(
                      image: AssetImage('assets/pantryScreen/dairy.png'))
                ])
              ]),
              const SizedBox(
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/pantryScreen/Rectangle_9.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(
                      image: AssetImage('assets/pantryScreen/canned.png'))
                ]),
                const SizedBox(
                  width: 25,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/pantryScreen/Rectangle_11.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(
                      image: AssetImage('assets/pantryScreen/drinks.png'))
                ]),
                const SizedBox(
                  width: 25,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/pantryScreen/Rectangle_10.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(
                      image: AssetImage('assets/pantryScreen/toiletries.png'))
                ])
              ]),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ), //BodyLayout(context, elements),
        appBar: appBar(context),
        bottomNavigationBar: navBar());
  }

  Future<String?> openDialogList() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("New List"),
          content: TextField(
              autofocus: true,
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Please enter the list name")),
          actions: [TextButton(onPressed: submit, child: const Text('Submit'))],
        ),
      );

  Future<String?> openDialogFolder() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text("New Folder"),
            content: TextField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "Please enter the folder name")),
            actions: [
              TextButton(onPressed: submit, child: const Text('Submit'))
            ]),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
  }

  void searchButton() {
    Navigator.of(context).pop(controller.text);
  }

  void _searchList(String search) {
    List<String> results = [];

    results = elements
        .where(
            (elements) => elements.toLowerCase().contains(search.toLowerCase()))
        .toList();

    print(results);

    setState(() {
      //_myListView(context, results);
      temp = elements;
      elements = results;
    });

    if (search.length == 0) {
      _update();
    }
  }

  void _update() {
    setState(() {
      elements = temp;
      BodyLayout(context, elements);
    });
  }
}
