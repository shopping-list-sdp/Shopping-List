import 'package:flutter/material.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:flutter_svg/svg.dart';
import 'package:shopping_list/custom_icons_icons.dart';
import 'package:shopping_list/screens/dashboard_screen.dart';
import 'package:shopping_list/screens/family_list_screen.dart';
import 'package:shopping_list/screens/join_family_screen.dart';
import 'package:shopping_list/screens/login_screen.dart';
import 'package:shopping_list/screens/my_list_screen.dart';
import 'package:shopping_list/screens/pantry_catagory_screen.dart';
import 'package:shopping_list/screens/pantry_screen.dart';
import 'package:shopping_list/utils/color_utils.dart';
import 'package:shopping_list/global.dart' as global;

import '../global.dart';
import '../queries/my_list_queries.dart';
import '../queries/pantry_queries.dart';

Image logoWidget(String imageName) {
  return Image.asset(imageName, fit: BoxFit.fitWidth, width: 250, height: 50);
}

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    validator: (value) {
      if (!isPasswordType) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      } else {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        return null;
      }
    },
    onSaved: (value) {
      controller.text = value!;
    },
    textInputAction: TextInputAction.done,
    cursorColor: myColors("White"),
    style: TextStyle(
        color: myColors("Purple"), fontWeight: FontWeight.w500, fontSize: 18),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: myColors("EightyWhite"),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: myColors("EightyWhite"),
          fontSize: 18,
          fontWeight: FontWeight.w500),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: myColors("FiftyGrey"),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

TextFormField searchField(
    String text, IconData icon, TextEditingController controller, String col) {
  return TextFormField(
    controller: controller,
    onSaved: (value) {
      controller.text = value!;
    },
    textInputAction: TextInputAction.done,
    cursorColor: myColors(col),
    style: TextStyle(
        color: myColors("Purple"), fontWeight: FontWeight.w500, fontSize: 18),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: myColors(col),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: myColors("Fifty$col"),
          fontSize: 18,
          fontWeight: FontWeight.w500),
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: myColors("TwentyGrey"),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
  );
}

Container reusableButton(BuildContext context, String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return myColors("Red");
            }
            return myColors("Purple");
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      child: Text(
        text,
        style: TextStyle(
            color: myColors("White"),
            fontWeight: FontWeight.w500,
            fontSize: 18),
      ),
    ),
  );
}

Row dashboardTile(
    BuildContext context, String colour, String iconName, Widget screen) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(alignment: Alignment.centerLeft, children: [
        InkWell(
            onTap: () {
              if (global.familyID == "" && iconName == "Family List") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JoinFamilyScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screen),
                );
              }
            },
            child: SvgPicture.asset(
              'assets/icons/tile$colour.svg',
            )),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            SvgPicture.asset(
              'assets/icons/$iconName.svg',
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
                onPressed: (() {
                  if (global.familyID == "" && iconName == "Family List") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JoinFamilyScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => screen),
                    );
                  }
                }),
                child: Text(iconName,
                    style: TextStyle(
                        color: myColors("White"),
                        fontSize: 20,
                        fontWeight: FontWeight.w500)))
          ],
        )
      ])
    ],
  );
}

Column dashboardButtons(
    BuildContext context, String colour, String iconName, Widget screen) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Padding(padding: EdgeInsets.fromLTRB(70, 0, 70, 0)),
      Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/clipboard$colour.svg',
          ),
          InkWell(
            child: SvgPicture.asset(
              'assets/icons/$iconName.svg',
            ),
            onTap: () {
              if (global.familyID == "" && screen == FamilyListScreen()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinFamilyScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screen),
                );
              }
            },
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      Text(iconName,
          style: TextStyle(
              color: myColors("Purple"),
              fontSize: 18,
              fontWeight: FontWeight.w500)),
    ],
  );
}

Column catagoryButton(BuildContext context, String catagoryName) {
  //add onTap parameter
  return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ElevatedButton(
        onPressed: () {
          global.pantryCategory = catagoryName.toLowerCase();
          getMyPantryItems();
          //getMyPantryInfo();
          //print(global.pantryCategory);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PantryCatagoryScreen(catagory: catagoryName)),
          );
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return myColors("Red");
              }
              return myColors("TenGrey");
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        child: SvgPicture.asset(
          '${'assets/icons/$catagoryName'}.svg',
        ),
      ),
    ),
    Text(catagoryName,
        style: TextStyle(
            color: myColors("Purple"),
            fontSize: 16,
            fontWeight: FontWeight.normal)),
  ]);
}

Container navBar(BuildContext context, String page) {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      color: myColors("White"),
      boxShadow: [
        BoxShadow(
          color: myColors("FiftyGrey"),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          enableFeedback: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyListScreen()),
            );
          },
          icon: const Icon(CustomIcons.mylist),
          iconSize: 30,
          color: page == "myList" ? myColors("Purple") : myColors("FiftyGrey"),
        ),
        IconButton(
          enableFeedback: true,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => global.familyID.isEmpty
                      ? const JoinFamilyScreen()
                      : const FamilyListScreen()),
            );
          },
          icon: const Icon(CustomIcons.familylist),
          iconSize: 30,
          color:
              page == "familyList" ? myColors("Purple") : myColors("FiftyGrey"),
        ),
        IconButton(
          enableFeedback: true,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
          icon: const Icon(Icons.home_rounded),
          iconSize: 40,
          color:
              page == "dashboard" ? myColors("Purple") : myColors("FiftyGrey"),
        ),
      ],
    ),
  );
}

AppBar appBar(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
      color: myColors("Red"), //change your color here
    ),
    centerTitle: true,
    title: Column(children: [
      const SizedBox(height: 20),
      SizedBox(
        height: 25,
        width: 120,
        child: Image.asset('assets/essentials/logo.png', fit: BoxFit.fill),
      )
    ]), //Image.asset('assets/The_Pantry.png'),
    toolbarHeight: 70,
    shadowColor: myColors("FiftyGrey"), //Color.fromARGB(255, 102, 102, 102),
    elevation: 1.0,
    bottomOpacity: 0.0,
    backgroundColor: myColors("White"),
    actions: [
      PopupMenuButton<int>(
        onSelected: (result) {
          if (result == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
            resetGlobal();
          } else if (result == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PantryScreen()),
            );
          }
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/logOut.svg'),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(
                        color: myColors("Purple"),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )),
          PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/Pantry.svg',
                    color: myColors("Purple"),
                    width: 25,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Pantry",
                    style: TextStyle(
                        color: myColors("Purple"),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )),
        ],
        icon: Column(children: [
          const SizedBox(height: 20),
          SvgPicture.asset('assets/icons/settings.svg'),
        ]),
        padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
        offset: const Offset(0, 80),
        color: myColors("EightyWhite"),
        elevation: 2,
      )
    ],
  );
}

PopupMenuButton menuButton(BuildContext context) {
  return PopupMenuButton<int>(
    onSelected: (result) {
      if (result == 1) {
      } else if (result == 2) {}
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
    itemBuilder: (context) => [
      PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Text(
                "1 Day",
                style: TextStyle(
                    color: myColors("Purple"),
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
      PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Text(
                "2 Day",
                style: TextStyle(
                    color: myColors("Purple"),
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
      PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Text(
                "3 Day",
                style: TextStyle(
                    color: myColors("Purple"),
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
      PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Text(
                "4 Day",
                style: TextStyle(
                    color: myColors("Purple"),
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
    ],
    padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
    offset: const Offset(0, 80),
    color: myColors("EightyWhite"),
    elevation: 2,
  );
}

Container listHeader(
    String col, String date, int noItems, bool isFamily, BuildContext context) {
  return Container(
      height: 45,
      decoration: BoxDecoration(
          color: myColors(col),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 25,
          ),
          Text(
            date,
            style: TextStyle(
                color: myColors("White"),
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
          const Spacer(
            flex: 6,
          ),
          Text(
            //noItems.toString(),
            "",
            style: TextStyle(
                color: myColors("White"),
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
          const Spacer(
            flex: 9,
          ),
          IconButton(
              onPressed: () {
                if (isFamily) {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) => AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            title: Text(
                              global.familyID.substring(0, 5),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: myColors("Purple"),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            titlePadding:
                                const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            actionsPadding:
                                const EdgeInsets.fromLTRB(0, 20, 20, 15),
                            content: Text(
                              "Use this code to share your list.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: myColors("Grey"), fontSize: 16),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: myColors("Purple"),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 10, 14, 10),
                                  child: Text(
                                    "Got it!",
                                    style: TextStyle(
                                      color: myColors("White"),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                }
              },
              icon: SvgPicture.asset(
                'assets/icons/addPerson.svg',
                color: isFamily ? myColors("white") : myColors(col),
              )),
          //SvgPicture.asset(
          //'assets/icons/addPerson.svg',
          //color: isFamily ? myColors("white") : myColors(col),
          //),
          const SizedBox(
            width: 10,
          ),
        ],
      ));
}
