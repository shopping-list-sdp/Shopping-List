import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/custom_icons_icons.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:shopping_list/reusable_widgets/list_view_widgets.dart';
import '../model/ListItem.dart';
import '../queries/my_list_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('users');
//.where("name", isEqualTo: "bakery") as CollectionReference<Object?>;

Future<void> getData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  print(allData);
}

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getMyListInfo();
    getMyListItems();
    super.initState();
  }

  final addTextEditingController = TextEditingController();
  int noItems = global.myListNoItems;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
            backgroundColor: myColors("White"),
            body: ListView(children: <Widget>[
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                child: Column(children: <Widget>[
                  Text("My List",
                      style: TextStyle(
                          color: myColors("Blue"),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 45,
                  ),
                  listHeader(
                      "Blue",
                      '${global.myListDate.toDate().day} - ${global.myListDate.toDate().month} - ${global.myListDate.toDate().year.toString()}',
                      global.myListNoItems,
                      false),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 325,
                        child: searchField("Add items", CustomIcons.search,
                            addTextEditingController, "Blue"),
                      ),
                      IconButton(
                          onPressed: () async {
                            addListItem(
                                itemName: addTextEditingController.text,
                                listID: global.myListId);
                            setState(() {
                              noItems = noItems + 1;
                              getMyListInfo();
                              getMyListItems();
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      for (var category in global.categories)
                        global.myList
                                .where(
                                    (element) => element.category == category)
                                .isEmpty
                            ? Column()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(width: 25),
                                        Text(
                                            category[0].toUpperCase() +
                                                category.substring(
                                                    1), //make first letter capital
                                            style: TextStyle(
                                                color: myColors("Blue"),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    for (ListItem entry in global.myList)
                                      if (entry.category == category)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 15),
                                            Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return myColors("Purple");
                                                }),
                                                value: !entry.toBuy,
                                                shape: const CircleBorder(),
                                                onChanged: (bool? val) {
                                                  changeToBuy(
                                                      !entry.toBuy, entry.id);
                                                  setState(() {
                                                    entry.toBuy = !val!;
                                                  });
                                                }),
                                            Text(
                                                entry.itemId[0].toUpperCase() +
                                                    entry.itemId.substring(
                                                        1), //make first etter capital
                                                style: TextStyle(
                                                    color: myColors("Grey"),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ],
                                        ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ])
                    ],
                  ),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "myList")));
  }
}
