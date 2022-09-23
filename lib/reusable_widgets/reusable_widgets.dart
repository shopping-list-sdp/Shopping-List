import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_list/custom_icons_icons.dart';
import 'package:shopping_list/screens/dashboard_screen.dart';
import 'package:shopping_list/screens/login_screen.dart';
import 'package:shopping_list/screens/my_list_screen.dart';
import 'package:shopping_list/screens/pantry_catagory_screen.dart';
import 'package:shopping_list/screens/pantry_screen.dart';
import 'package:shopping_list/utils/color_utils.dart';

import '../queries/my_list_queries.dart';

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

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
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
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: TextStyle(
            color: myColors("White"),
            fontWeight: FontWeight.w600,
            fontSize: 18),
      ),
    ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
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
          enableFeedback: false,
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
          enableFeedback: false,
          onPressed: () {},
          icon: const Icon(CustomIcons.familylist),
          iconSize: 30,
          color: myColors("FiftyGrey"),
        ),
        IconButton(
          enableFeedback: false,
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
          } else if (result == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PantryScreen(
                        text: '',
                      )),
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

Container listHeader(String col, String date, int noItems, bool isFamily) {
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
            width: 20,
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
            noItems.toString(),
            style: TextStyle(
                color: myColors("White"),
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
          const Spacer(
            flex: 9,
          ),
          SvgPicture.asset(
            'assets/icons/addPerson.svg',
            color: isFamily ? myColors("white") : myColors(col),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ));
}
