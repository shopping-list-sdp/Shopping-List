import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/model/Item.dart';
import 'package:shopping_list/queries/my_list_queries.dart';
import 'package:shopping_list/reusable_widgets/list_view_widgets.dart';
import 'package:shopping_list/global.dart' as global;
import '../custom_icons_icons.dart';
import '../model/pantryItem.dart';
import '../queries/pantry_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class PantryCatagoryScreen extends StatefulWidget {
  final String catagory;
  const PantryCatagoryScreen({super.key, required this.catagory});

  @override
  State<PantryCatagoryScreen> createState() =>
      _PantryCatagoryScreenState(catagory);
}

class _PantryCatagoryScreenState extends State<PantryCatagoryScreen> {
  final searchTextEditingController = TextEditingController();
  final addTextEditingController = TextEditingController();

  var duplicateItems = global.pantryitems;
  var items = [];

  void filterSearchResults(String query) {
    var dummySearchList = [];
    dummySearchList.addAll(global.pantryitems);
    if (query.isNotEmpty) {
      var dummyListData = [];
      for (Item item in dummySearchList) {
        String id = item.name.toString();
        if (id.contains(query)) {
          dummyListData.add(item.name);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        //items.addAll(global.items);
      });
    }
  }

  String catagory;
  _PantryCatagoryScreenState(this.catagory);
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getMyPantryItems();
    //getMyPantryInfo();
    //global.pantryCategory = catagory;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            /*image: DecorationImage(
            image: AssetImage("assets/essentials/background.png"),
            fit: BoxFit.cover,
          ),*/
            ),
        child: Scaffold(
            backgroundColor: myColors("White"),
            body: ListView(children: <Widget>[
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                child: Column(children: <Widget>[
                  Text("Pantry",
                      style: TextStyle(
                          color: myColors("Purple"),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Image(image: AssetImage('assets/images/stall.png')),
                      Text(catagory,
                          style: TextStyle(
                              color: myColors("White"),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 325,
                        child: //searchField("Add items", CustomIcons.search,
                            //addTextEditingController, "Blue"),
                            TextField(
                                controller: addTextEditingController,
                                onChanged: (value) {
                                  filterSearchResults(value);
                                  if (addTextEditingController.toString() ==
                                      '') {
                                    items = [];
                                  }
                                },
                                textInputAction: TextInputAction.done,
                                cursorColor: myColors("Purple"),
                                style: TextStyle(
                                    color: myColors("Purple"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    CustomIcons.search,
                                    color: myColors("Purple"),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        items = [];
                                        addTextEditingController.text = '';
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel_rounded,
                                      color: myColors("FiftyGrey"),
                                    ),
                                  ),
                                  labelText: "Add Items",
                                  labelStyle: TextStyle(
                                      color: myColors("FiftyPurple"),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  filled: true,
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: myColors("TwentyGrey"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(20),
                                          topRight: const Radius.circular(20),
                                          bottomLeft:
                                              addTextEditingController.text ==
                                                      ''
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0),
                                          bottomRight:
                                              addTextEditingController.text ==
                                                      ''
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0)),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)),
                                )),
                      ),
                    ],
                  ),
                  Container(
                      width: 325,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: myColors("TwentyGrey")),
                      //border: Border.all(color: Colors.blueAccent)),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length < 5 ? items.length : 5,
                        itemBuilder: (context, index) {
                          return ListTile(
                            //tileColor: myColors("TwentyGrey"),
                            /*shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            */
                            leading: Transform.translate(
                                offset: const Offset(-5, 0),
                                child: Icon(
                                  Icons.add,
                                  color: myColors("Purple"),
                                )),
                            title: Transform.translate(
                                offset: const Offset(-22, 0),
                                child: Text(
                                  items[index],
                                  style: TextStyle(color: myColors("Grey")),
                                )),
                            onTap: () async {
                              String item = items[index];
                              bool flag = false;
                              for (pantryItem pantryitems in global.myPantry) {
                                if (pantryitems.itemId.compareTo(item) == 0) {
                                  flag = true;
                                }
                                if (flag) {
                                  await updateQuantityItems(pantryitems.id, 1);
                                  setState(() {
                                    items = [];
                                    pantryitems.quantity += 1;
                                  });
                                  break;
                                }
                              }

                              if (flag == false) {
                                await addPantryItem(
                                    itemName: item,
                                    pantryID: global.myPantryId,
                                    quantity: 1);
                              }
                              FocusManager.instance.primaryFocus?.unfocus();
                              addTextEditingController.text = '';
                              setState(() {
                                items = [];
                              });
                              Fluttertoast.showToast(msg: "Item Added");
                            },
                          );
                        },
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          child: Text(
                            "Clear List     ",
                            style: TextStyle(
                                color: myColors("Purple"),
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () async {
                            //await getMyPantryItems();
                            await clearPantryList();
                            setState(() {
                              items = [];
                            });
                          })),
                  Column(
                    key: UniqueKey(),
                    children: [
                      //for (var category in global.categories)
                      //global.myPantry
                      //.where((element) => element.category == category)
                      //.isEmpty
                      //? Column()
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            for (pantryItem entry in global.myPantry)
                              if (entry.category == global.pantryCategory)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //const SizedBox(width: 15),
                                    /*Checkbox(
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
                                                })*/

                                    Text(
                                        "     ${entry.itemId[0].toUpperCase()}${entry.itemId.substring(1)}", //make first etter capital
                                        style: TextStyle(
                                            color: myColors("Purple"),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18)),
                                    //const SizedBox(width: ),
                                    Column(children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: Row(children: [
                                              InkWell(
                                                child: SvgPicture.asset(
                                                  'assets/icons/plus.svg',
                                                ),
                                                onTap: () {
                                                  int number = 1;
                                                  updateQuantityItems(
                                                      entry.id, number);
                                                  setState(() {
                                                    entry.quantity += number;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                  entry.quantity
                                                      .toString(), //make first etter capital
                                                  style: TextStyle(
                                                      color: myColors("Purple"),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18)),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                child: SvgPicture.asset(
                                                  'assets/icons/minus.svg',
                                                ),
                                                onTap: () async {
                                                  if (entry.quantity > 1) {
                                                    int number = -1;
                                                    setState(() {
                                                      entry.quantity += number;
                                                    });
                                                    updateQuantityItems(
                                                        entry.id, number);
                                                  } else if (entry.quantity ==
                                                      1) {
                                                    //print("Q = " +
                                                    //entry.quantity.toString());

                                                    await removeFromList(
                                                        entry.id);
                                                    setState(() {
                                                      entry.quantity = 0;
                                                    });
                                                    /*updateQuantityItems(
                                                    entry.id, 0);*/
                                                    updateNoItems(
                                                        global.myListId, 1);

                                                    if (count < 1) {
                                                      count++;
                                                      addListItem(
                                                          itemName:
                                                              entry.itemId,
                                                          listID:
                                                              global.myListId);
                                                    } else {
                                                      count = 0;
                                                    }

                                                    Fluttertoast.showToast(
                                                        msg: "Item Added List");
                                                  }
                                                },
                                              ),
                                              const SizedBox(width: 25),
                                            ]),
                                          ),
                                        ],
                                      )
                                    ]),
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
            bottomNavigationBar: navBar(context, "pantryCatagory")));
  }
}
