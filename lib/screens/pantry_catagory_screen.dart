import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shopping_list/reusable_widgets/list_view_widgets.dart';
import '../custom_icons_icons.dart';
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
  String catagory;
  _PantryCatagoryScreenState(this.catagory);

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
                  searchField("Search Items", CustomIcons.search,
                      searchTextEditingController, "Red"),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "pantryCatagory")));
  }
}
