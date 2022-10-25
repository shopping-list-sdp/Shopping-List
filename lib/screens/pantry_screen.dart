import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/screens/pantry_catagory_screen.dart';
import '../custom_icons_icons.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';
import 'package:shopping_list/global.dart' as global;

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  final searchTextEditingController = TextEditingController();
  final addTextEditingController = TextEditingController();

  var duplicateItems = global.categories;
  var categories = [];

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
        categories.clear();
        categories.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        categories.clear();
        //items.addAll(global.items);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/essentials/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(children: <Widget>[
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    35, MediaQuery.of(context).size.height * 0.05, 35, 0),
                child: Column(children: <Widget>[
                  Text("Pantry",
                      style: TextStyle(
                          color: myColors("Purple"),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Image(image: AssetImage('assets/images/stall.png')),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 330,
                    child: //searchField("Add items", CustomIcons.search,
                        //addTextEditingController, "Blue"),
                        TextField(
                            controller: addTextEditingController,
                            onChanged: (value) {
                              filterSearchResults(value);
                              if (addTextEditingController.toString() == '') {
                                categories = [];
                              }
                            },
                            onSubmitted: (value) {
                              String val = value.toString();
                              val = val.substring(0, 1).toUpperCase() +
                                  val.substring(1);
                              if (global.categories
                                  .contains(val.toLowerCase())) {
                                global.pantryCategory = val.toLowerCase();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PantryCatagoryScreen(catagory: val)),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Category not found");
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
                                    categories = [];
                                    addTextEditingController.text = '';
                                  });
                                },
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: myColors("FiftyGrey"),
                                ),
                              ),
                              labelText: "Search Categories",
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
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none)),
                            )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    catagoryButton(context, "Bakery"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Beverages"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Canned"),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    catagoryButton(context, "Cleaning"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Dairy"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Dry Goods"),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    catagoryButton(context, "Fish"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Frozen"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Meat"),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    catagoryButton(context, "Pet Care"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Produce"),
                    const SizedBox(
                      width: 35,
                    ),
                    catagoryButton(context, "Toiletries"),
                  ]),
                  const SizedBox(
                    height: 35,
                  ),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "pantry")));
  }
}
