import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/custom_icons_icons.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:shopping_list/model/ScheduleItem.dart';
import 'package:shopping_list/queries/scheduled_queries.dart';
import 'package:shopping_list/reusable_widgets/list_view_widgets.dart';
import '../model/ListItem.dart';
import '../queries/my_list_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class ScheduledScreen extends StatefulWidget {
  const ScheduledScreen({super.key});

  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {
  final addTextEditingController = TextEditingController();
  final editDaysController = TextEditingController();
  var duplicateItems = global.items;
  var items = [];
  String d = "";
  late FocusNode myFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode = FocusNode();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(global.items);
    if (query.isNotEmpty) {
      List<String> dumScheduledData = [];
      for (var item in dummySearchList) {
        if (item.contains(query)) {
          dumScheduledData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dumScheduledData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        //items.addAll(global.items);
      });
    }
  }

  /*bool _isEditing = false;
  void _edit() {
    setState(() => _isEditing = true);
  }*/

  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        /*decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/essentials/background.png"),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Scaffold(
            backgroundColor: myColors("White"),
            body: ListView(children: <Widget>[
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                child: Column(children: <Widget>[
                  Text("Scheduled List",
                      style: TextStyle(
                          color: myColors("Yellow"),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 45,
                  ),
                  listHeader("Yellow", "", 1, false, context),
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
                                cursorColor: myColors("Yellow"),
                                style: TextStyle(
                                    color: myColors("Purple"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    CustomIcons.search,
                                    color: myColors("FiftyYellow"),
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
                                      color: myColors("FiftyYellow"),
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

                              await addScheduleItem(
                                  itemName: item,
                                  scheduleID: global.myScheduleId,
                                  days: 7,
                                  dateAdded: Timestamp.now());
                              setState(() {
                                items = [];
                              });
                            },
                          );
                        },
                      )),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Column(
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
                                await clearSchedule(global.myScheduleId);
                                setState(() {
                                  items = [];
                                });
                              }),
                        ],
                      )),
                  Column(
                    key: UniqueKey(),
                    children: [
                      for (var category in global.categories)
                        global.mySchedule
                                .where(
                                    (element) => element.category == category)
                                .isEmpty
                            ? Column()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    category[0].toUpperCase() +
                                                        category.substring(1),
                                                    textAlign: TextAlign.start,
                                                    //make first letter capital
                                                    style: TextStyle(
                                                        color:
                                                            myColors("Yellow"),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 18)),
                                                //const SizedBox(width: 15),
                                                //const SizedBox(width: 165),
                                              ],
                                            )),
                                        //const SizedBox(width: 25)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    for (ScheduleItem entry
                                        in global.mySchedule)
                                      if (entry.category == category)
                                        Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: myColors("Purple"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 0, 0, 0),
                                                  child: Text(
                                                      entry.itemId[0]
                                                              .toUpperCase() +
                                                          entry.itemId.substring(
                                                              1), //make first etter capital
                                                      //textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                          color:
                                                              myColors("Grey"),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                )
                                              ]),
                                              //const SizedBox(width: 10),
                                              PopupMenuButton<int>(
                                                icon: Icon(
                                                    Icons.edit_note_sharp,
                                                    color: myColors("Purple")),
                                                onSelected: (result) async {
                                                  if (result == 1) {
                                                    entry.days = 1;
                                                  } else if (result == 2) {
                                                    entry.days = 2;
                                                  } else if (result == 3) {
                                                    entry.days = 3;
                                                  } else if (result == 4) {
                                                    entry.days = 4;
                                                  } else if (result == 5) {
                                                    entry.days = 5;
                                                  } else if (result == 6) {
                                                    entry.days = 6;
                                                  } else if (result == 7) {
                                                    entry.days = 7;
                                                  } else if (result == 8) {
                                                    entry.days = 14;
                                                  } else if (result == 9) {
                                                    entry.days = 21;
                                                  } else if (result == 10) {
                                                    entry.days = 28;
                                                  }
                                                  await changeFrequency(
                                                      entry.days, entry.id);
                                                  Fluttertoast.showToast(
                                                      msg: "Frequency Changed");
                                                  setState(() {
                                                    d = d;
                                                  });
                                                },
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 120,
                                                        maxHeight: 100),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                ),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                      value: 1,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "1 Days",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 2,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "2 Days",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 3,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "3 Days",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 4,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "4 Days",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 5,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "5 Days",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 6,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "6 Days",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 7,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "1 Week",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 8,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "2 Weeks",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 9,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "3 Weeks",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                      value: 10,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "4 Weeks",
                                                            style: TextStyle(
                                                                color: myColors(
                                                                    "Purple"),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )),
                                                ],
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 30, 0),
                                                offset: const Offset(-30, 40),
                                                color: myColors("EightyWhite"),
                                                elevation: 2,
                                              ),

                                              //SizedBox(
                                              //height: 50,
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 55,
                                              ),
                                              Text(
                                                d = getStr(entry.days),
                                                style: TextStyle(
                                                    color: myColors("Purple"),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ]),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ])
                    ],
                  ),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "Scheduled")));
  }
}
