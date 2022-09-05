import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/model/family_model.dart';
import 'package:shopping_list/model/user_model.dart';
import 'package:shopping_list/classes/body_layout.dart';

import 'login_screen.dart';

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
        MaterialPageRoute(builder: (context) => PantryScreen()),
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
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Image(image: AssetImage('assets/pantryScreen/Pantry.png')),
              const SizedBox(
                height: 5,
              ),
              const Image(image: AssetImage('assets/pantryScreen/Group.png')),
              const SizedBox(
                height: 30,
              ),
              const Image(
                  image: AssetImage('assets/pantryScreen/Rectangle 5.png')),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/pantryScreen/Rectangle 6.png'),
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
                  Image.asset('assets/pantryScreen/Rectangle 8.png'),
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
                  Image.asset('assets/pantryScreen/Rectangle 7.png'),
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
                  Image.asset('assets/pantryScreen/Rectangle 9.png'),
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
                  Image.asset('assets/pantryScreen/Rectangle 11.png'),
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
                  Image.asset('assets/pantryScreen/Rectangle 10.png'),
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
        appBar: AppBar(
          title: Column(children: [
            const SizedBox(height: 40),
            SizedBox(
              height: 20,
              width: 100,
              child: Image.asset('assets/The_Pantry.png', fit: BoxFit.fill),
            )
          ]), //Image.asset('assets/The_Pantry.png'),
          toolbarHeight: 80,
          centerTitle: false,
          shadowColor: Colors.black, //Color.fromARGB(255, 102, 102, 102),
          elevation: 1.0,
          bottomOpacity: 0.0,
          backgroundColor: Colors.white,
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(Icons.list_alt),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Create a List")
                      ],
                    )),
                PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: const [
                        Icon(Icons.folder),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Create a Folder")
                      ],
                    )),
              ],
              icon: Column(children: [
                const SizedBox(height: 30),
                SizedBox(
                  child: Image.asset('assets/Setting.png'),
                )
              ]),
              onSelected: (value) async {
                final name;

                if (value == 1) {
                  name = await openDialogList();
                  postDetailsToFirestore(name);
                  if (name == null || name.isEmpty()) return;
                } else if (value == 2) {
                  name = await openDialogFolder();
                  add(name);
                  if (name == null || name.isEmpty()) return;
                }
              },
              offset: const Offset(0, 100),
              color: const Color.fromARGB(176, 42, 159, 255),
              elevation: 2,
            )
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              //backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/bottomBar/Frame.png'), label: ''),
              //backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/bottomBar/Frame-1.png'), label: ''),
              //backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/bottomBar/Frame-2.png'), label: ''),
              //backgroundColor: Colors.white)
            ],
            elevation: 1.0,
          ),
        ));
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
