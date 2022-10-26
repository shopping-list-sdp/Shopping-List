import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopping_list/queries/join_family_queries.dart';
import 'package:shopping_list/screens/my_list_screen.dart';
import 'package:shopping_list/screens/pantry_screen.dart';
import '../custom_icons_icons.dart';
import '../queries/my_list_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class JoinFamilyScreen extends StatefulWidget {
  const JoinFamilyScreen({super.key});

  @override
  State<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends State<JoinFamilyScreen> {
  final TextEditingController joinFamilyController = TextEditingController();
  final TextEditingController createFamilyController = TextEditingController();
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/essentials/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            //resizeToAvoidBottomInset: false,
            //backgroundColor: myColors("White"),
            body: ListView(children: <Widget>[
              SingleChildScrollView(
                  //allow page to scroll
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    100, MediaQuery.of(context).size.height * 0.1, 100, 0),
                child: Column(children: <Widget>[
                  Text("Family List", //title of page
                      style: TextStyle(
                          color: myColors("Green"),
                          fontSize: 30,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 60,
                  ),
                  reusableTextField("Family Code", CustomIcons.familylist,
                      false, joinFamilyController),
                  const SizedBox(
                    height: 10,
                  ),
                  reusableButton(context, "Join Family", () {
                    joinFamily(joinFamilyController.text, context);
                    joinFamilyController.text = "";
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: myColors("Green")),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  reusableTextField("Family Name", CustomIcons.familylist,
                      false, createFamilyController),
                  const SizedBox(
                    height: 10,
                  ),
                  reusableButton(context, "Create Family", () {
                    createFamily(
                        name: createFamilyController.text, context: context);
                    createFamilyController.text = "";
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "")));
  }
}
