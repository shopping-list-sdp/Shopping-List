import 'package:flutter/material.dart';
import 'package:shopping_list/utils/color_utils.dart';

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
