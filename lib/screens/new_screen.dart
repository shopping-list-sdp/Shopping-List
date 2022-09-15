import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/screens/login_screen.dart';
import 'package:flutter_svg/svg.dart';

import '../custom_icons_icons.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class pantry_scr extends StatefulWidget {
  const pantry_scr({super.key});

  @override
  State<pantry_scr> createState() => _pantry_scrState();
}

class _pantry_scrState extends State<pantry_scr> {
  final searchTextEditingController = TextEditingController();
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
                  const Image(
                      image: AssetImage('assets/pantryScreen/stall.png')),
                  const SizedBox(
                    height: 30,
                  ),
                  searchField("Search Catagories", CustomIcons.search,
                      searchTextEditingController),
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
            appBar: appBar(),
            bottomNavigationBar: navBar()));
  }
}
