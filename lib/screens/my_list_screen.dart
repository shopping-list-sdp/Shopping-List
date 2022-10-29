import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/custom_icons_icons.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:shopping_list/queries/pantry_queries.dart';
import 'package:shopping_list/reusable_widgets/list_view_widgets.dart';
import '../model/ListItem.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../queries/my_list_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  final addTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();
  var duplicateItems = global.items;
  var items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(global.items);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.contains(query)) {
          dummyListData.add(item);
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

  int noItems = global.myListNoItems;
  Timestamp date = global.myListDate;
  String clickedItemPrice = "";

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
                      '${date.toDate().day} - ${date.toDate().month} - ${date.toDate().year.toString()}',
                      noItems,
                      false,
                      context),
                  const SizedBox(
                    height: 35,
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
                                cursorColor: myColors("Blue"),
                                style: TextStyle(
                                    color: myColors("Purple"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    CustomIcons.search,
                                    color: myColors("Blue"),
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
                                      color: myColors("FiftyBlue"),
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
                                FocusManager.instance.primaryFocus?.unfocus();
                                addTextEditingController.text = '';
                                String item = items[index];
                                setState(() {
                                  items = [];
                                });
                                /*bool flag = false;
                                for (ListItem listitems in global.myList) {
                                  if (listitems.itemId.compareTo(item) == 0) {
                                    flag = true;
                                  }
                                  if (flag) {
                                    await updateQuantityOfItems(
                                        listitems.id, 1);
                                    setState(() {
                                      //items = [];
                                      listitems.quantity += 1;
                                      noItems += 1;
                                    });
                                    break;
                                  }
                                }*/
                                //if (flag == false) {
                                await addListItem(
                                    itemName: item, listID: global.myListId);
                                setState(() {
                                  noItems = noItems + 1;
                                });
                                //}
                                Fluttertoast.showToast(msg: "Item Added");
                              });
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          child: Text(
                            "Clear List          ",
                            style: TextStyle(
                                color: myColors("Purple"),
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () async {
                            await clearList(global.myListId);
                            setState(() {
                              date = Timestamp.now();
                              noItems = 0;
                            });
                          }),
                    ],
                  ),
                  Column(
                    key: UniqueKey(),
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
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  //const SizedBox(width: 15),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Checkbox(
                                                            checkColor:
                                                                Colors.white,
                                                            fillColor: MaterialStateProperty
                                                                .resolveWith<
                                                                    Color>((Set<
                                                                        MaterialState>
                                                                    states) {
                                                              return myColors(
                                                                  "Purple");
                                                            }),
                                                            value: !entry.toBuy,
                                                            shape:
                                                                const CircleBorder(),
                                                            onChanged: (bool?
                                                                val) async {
                                                              await changeToBuy(
                                                                  !entry.toBuy,
                                                                  entry.id);
                                                              await calculateCost(
                                                                  global
                                                                      .myListId);
                                                              setState(() {
                                                                entry.toBuy =
                                                                    !val!;
                                                                global
                                                                    .myListMarkedCost;
                                                              });
                                                            }),
                                                        Text(
                                                            entry.itemId[0]
                                                                    .toUpperCase() +
                                                                entry.itemId
                                                                    .substring(
                                                                        1), //make first etter capital
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Grey"),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                      ]),
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(children: [
                                                        InkWell(
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/plus.svg',
                                                          ),
                                                          onTap: () async {
                                                            int number = 1;
                                                            await updateQuantityOfItems(
                                                                entry.id,
                                                                number);
                                                            setState(() {
                                                              entry.quantity +=
                                                                  number;
                                                              noItems++;
                                                              global.myListCost;
                                                            });
                                                            updateNoItems(
                                                                global.myListId,
                                                                1);
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                            entry.quantity
                                                                .toString(), //make first etter capital
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18)),
                                                        const SizedBox(
                                                            width: 10),
                                                        InkWell(
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/minus.svg',
                                                          ),
                                                          onTap: () async {
                                                            if (entry.quantity >
                                                                1) {
                                                              int number = -1;
                                                              await updateQuantityOfItems(
                                                                  entry.id,
                                                                  number);
                                                              setState(() {
                                                                entry.quantity +=
                                                                    number;
                                                                noItems--;
                                                              });
                                                              updateNoItems(
                                                                  global
                                                                      .myListId,
                                                                  -1);
                                                            } else if (entry
                                                                    .quantity ==
                                                                1) {
                                                              //print("Q = " +
                                                              //entry.quantity.toString());
                                                              await removeList(
                                                                  entry.id);
                                                              setState(() {
                                                                entry.quantity =
                                                                    0;
                                                                if (noItems >=
                                                                    1) {
                                                                  updateNoItems(
                                                                      global
                                                                          .myListId,
                                                                      -1);
                                                                  noItems--;
                                                                }
                                                              });
                                                              /*updateQuantityItems(
                                                    entry.id, 0);*/
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Item removed from list");
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            width: 35),
                                                      ])),
                                                  //const SizedBox(width: 180),
                                                  /*Column(children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Row(children: [
                                                            InkWell(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/icons/plus.svg',
                                                              ),
                                                              onTap: () async {
                                                                int number = 1;
                                                                await updateQuantityOfItems(
                                                                    entry.id,
                                                                    number);
                                                                setState(() {
                                                                  entry.quantity +=
                                                                      number;
                                                                  noItems++;
                                                                  global
                                                                      .myListCost;
                                                                });
                                                                updateNoItems(
                                                                    global
                                                                        .myListId,
                                                                    1);
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                                entry.quantity
                                                                    .toString(), //make first etter capital
                                                                style: TextStyle(
                                                                    color: myColors(
                                                                        "Purple"),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        18)),
                                                            const SizedBox(
                                                                width: 10),
                                                            InkWell(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/icons/minus.svg',
                                                              ),
                                                              onTap: () async {
                                                                if (entry
                                                                        .quantity >
                                                                    1) {
                                                                  int number =
                                                                      -1;
                                                                  await updateQuantityOfItems(
                                                                      entry.id,
                                                                      number);
                                                                  setState(() {
                                                                    entry.quantity +=
                                                                        number;
                                                                    noItems--;
                                                                  });
                                                                  updateNoItems(
                                                                      global
                                                                          .myListId,
                                                                      -1);
                                                                } else if (entry
                                                                        .quantity ==
                                                                    1) {
                                                                  //print("Q = " +
                                                                  //entry.quantity.toString());
                                                                  await removeList(
                                                                      entry.id);
                                                                  setState(() {
                                                                    entry.quantity =
                                                                        0;
                                                                    if (noItems >=
                                                                        1) {
                                                                      updateNoItems(
                                                                          global
                                                                              .myListId,
                                                                          -1);
                                                                      noItems--;
                                                                    }
                                                                  });
                                                                  /*updateQuantityItems(
                                                    entry.id, 0);*/
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Item removed from My List");
                                                                }
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                width: 25),
                                                          ]),
                                                        ),
                                                      ],
                                                    )
                                                  ]),*/
                                                ],
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(width: 57),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        alignment:
                                                            Alignment.topCenter,
                                                      ),
                                                      onPressed: () async {
                                                        clickedItemPrice = entry
                                                            .price
                                                            .toString()
                                                            .replaceAll(
                                                                ",", ".");
                                                        print(clickedItemPrice);
                                                        //calculateCost(
                                                        //global.myListId);
                                                        showDialog(
                                                            barrierDismissible:
                                                                true,
                                                            context: context,
                                                            builder:
                                                                (ctx) =>
                                                                    AlertDialog(
                                                                      shape: const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(20))),
                                                                      title:
                                                                          Text(
                                                                        "Change Cost",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color: myColors(
                                                                                "Purple"),
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      titlePadding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              0,
                                                                              40,
                                                                              0,
                                                                              0),
                                                                      contentPadding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              0,
                                                                              10,
                                                                              0,
                                                                              0),
                                                                      content: Column(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .center,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                              Text(
                                                                                "R ",
                                                                                style: TextStyle(color: myColors("Purple"), fontSize: 16, fontWeight: FontWeight.w500),
                                                                              ),
                                                                              Container(
                                                                                  width: 60,
                                                                                  child: TextField(
                                                                                    textAlign: TextAlign.center,
                                                                                    controller: _priceTextEditingController,
                                                                                    inputFormatters: <TextInputFormatter>[
                                                                                      CurrencyTextInputFormatter(
                                                                                        locale: 'en_ZA',
                                                                                        decimalDigits: 2,
                                                                                        symbol: '',
                                                                                      ),
                                                                                    ],
                                                                                    maxLines: 1,
                                                                                    keyboardType: TextInputType.number,
                                                                                    style: TextStyle(
                                                                                      color: myColors("Grey"),
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    decoration: InputDecoration(
                                                                                      //errorText: "hi",
                                                                                      errorStyle: TextStyle(color: myColors("Grey")),
                                                                                      hintText: clickedItemPrice,
                                                                                      focusedErrorBorder: UnderlineInputBorder(
                                                                                        borderSide: BorderSide(color: myColors("Grey"), width: 1),
                                                                                      ),
                                                                                      errorBorder: UnderlineInputBorder(
                                                                                        borderSide: BorderSide(color: myColors("Purple"), width: 1),
                                                                                      ),
                                                                                      enabledBorder: UnderlineInputBorder(
                                                                                        borderSide: BorderSide(color: myColors("Purple"), width: 1),
                                                                                      ),
                                                                                      focusedBorder: UnderlineInputBorder(
                                                                                        borderSide: BorderSide(color: myColors("Grey"), width: 1),
                                                                                      ),
                                                                                      hintStyle: TextStyle(color: myColors("FiftyGrey"), fontSize: 16, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ))
                                                                            ]),
                                                                            const SizedBox(height: 15),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.of(ctx).pop();
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: myColors("Purple"), borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                                                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                                                                    child: Text(
                                                                                      "Cancel",
                                                                                      style: TextStyle(
                                                                                        color: myColors("White"),
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () async {
                                                                                    print(entry.id);
                                                                                    await updateItemPrice(entry.id, _priceTextEditingController.text);
                                                                                    setState(() {
                                                                                      String temp = _priceTextEditingController.text;
                                                                                      entry.price = temp.replaceAll(",", ".");
                                                                                      global.myListCost;
                                                                                    });
                                                                                    _priceTextEditingController.text = "";
                                                                                    Navigator.of(ctx).pop();
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(color: myColors("Purple"), borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                                                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                                                                    child: Text(
                                                                                      "Update",
                                                                                      style: TextStyle(
                                                                                        color: myColors("White"),
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 20,
                                                                                )
                                                                              ],
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            )
                                                                          ]),

                                                                      /*Text(
                                                                        "Use this code to share your list.",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                myColors("Grey"),
                                                                            fontSize: 16),
                                                                      ),*/
                                                                      /*actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(ctx).pop();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(color: myColors("Purple"), borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                14,
                                                                                10,
                                                                                14,
                                                                                10),
                                                                            child:
                                                                                Text(
                                                                              "Update",
                                                                              style: TextStyle(
                                                                                color: myColors("White"),
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],*/
                                                                    ));
                                                      },
                                                      child: Text(
                                                        "R ${entry.price.toString()}",
                                                        style: TextStyle(
                                                            color: myColors(
                                                                "Purple"),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/icons/edit.svg',
                                                      height: 14,
                                                      width: 14,
                                                      color: myColors("Grey"),
                                                    ),
                                                    /*Icon(
                                                      Icons.edit,
                                                      color: myColors("Purple"),
                                                      size: 17,
                                                    ),*/
                                                  ])
                                            ]),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ])
                    ],
                  ),
                  global.myList.isEmpty
                      ? Row()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "All Items Total: R" + global.myListCost,
                              style: TextStyle(
                                  color: myColors("Purple"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  global.myList.isEmpty
                      ? Row()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Marked Items Total: R" + global.myListMarkedCost,
                              style: TextStyle(
                                  color: myColors("Purple"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      child: Text(
                        "Add Marked to Pantry",
                        style: TextStyle(
                            color: myColors("Purple"),
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () async {
                        if (global.myList.isNotEmpty) {
                          await addToPantry(global.myListId);
                          setState(() {
                            items = [];
                            //global.myListCost;
                            //global.myListMarkedCost;
                            //noItems = noItems + 1;
                            //noItems;
                          });
                          Fluttertoast.showToast(msg: "Added To Pantry");
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "myList")));
  }
}
