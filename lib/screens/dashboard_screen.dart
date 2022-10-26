import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shopping_list/screens/family_list_screen.dart';
import 'package:shopping_list/screens/join_family_screen.dart';
import 'package:shopping_list/screens/my_list_screen.dart';
import 'package:shopping_list/screens/pantry_screen.dart';
import 'package:shopping_list/screens/scheduled_screen.dart';
import '../custom_icons_icons.dart';
import '../queries/my_list_queries.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/color_utils.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // do something
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (global.familyID.isEmpty) {
      screen = const JoinFamilyScreen();
    } else {
      screen = const FamilyListScreen();
    }
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
                  //allow page to scroll
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.05, 0, 0),
                child: Column(children: <Widget>[
                  Text("Home",
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
                      Material(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PantryScreen()),
                                );
                              },
                              child: const Image(
                                  image:
                                      AssetImage('assets/images/stall.png')))),
                      Column(children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PantryScreen()),
                              );
                            },
                            child: Text("Pantry",
                                style: TextStyle(
                                    color: myColors("White"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                      ]),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  dashboardTile(
                      context, "Blue", "My List", const MyListScreen()),
                  const SizedBox(
                    height: 20,
                  ),
                  dashboardTile(context, "Green", "Family List",
                      const FamilyListScreen()),
                  const SizedBox(
                    //add space
                    height: 20,
                  ),
                  dashboardTile(
                      context, "Yellow", "Scheduled", const ScheduledScreen()),
                ]),
              )),
            ]),
            appBar: appBar(context),
            bottomNavigationBar: navBar(context, "dashboard")));
  }
}
