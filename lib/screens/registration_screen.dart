import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/model/user_model.dart';
import 'package:shopping_list/queries/scheduled_queries.dart';
import 'package:shopping_list/screens/dashboard_screen.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_list/screens/login_screen.dart';
import '../queries/join_family_queries.dart';
import '../queries/my_list_queries.dart';
import '../utils/color_utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First name cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Invalid name");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: myColors("White"),
      style: TextStyle(
          color: myColors("Purple"), fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person_rounded,
          color: myColors("EightyWhite"),
        ),
        labelText: "Name",
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
    );

    //second name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Surname cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: myColors("White"),
      style: TextStyle(
          color: myColors("Purple"), fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person_rounded,
          color: myColors("EightyWhite"),
        ),
        labelText: "Surname",
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
    );

    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter email address");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Invalid email address");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: myColors("White"),
      style: TextStyle(
          color: myColors("Purple"), fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_rounded,
          color: myColors("EightyWhite"),
        ),
        labelText: "Email",
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
    );

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please enter password");
        }
        if (!regex.hasMatch(value)) {
          return ("Invalid Password");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: myColors("White"),
      style: TextStyle(
          color: myColors("Purple"), fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.key_rounded,
          color: myColors("EightyWhite"),
        ),
        labelText: "Password",
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
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      cursorColor: myColors("White"),
      style: TextStyle(
          color: myColors("Purple"), fontWeight: FontWeight.w500, fontSize: 18),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.key_rounded,
          color: myColors("EightyWhite"),
        ),
        labelText: "Confirm Password",
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
    );

    //signup button
    final signUpButton = Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: ElevatedButton(
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return myColors("Red");
              }
              return myColors("Purple");
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        child: Text(
          'SIGN UP',
          style: TextStyle(
              color: myColors("White"),
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
    );

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
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    30, MediaQuery.of(context).size.height * 0.02, 30, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Welcome",
                          style: TextStyle(
                              color: myColors("Purple"),
                              fontSize: 30,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 25,
                      ),
                      Image.asset("assets/essentials/logo.png",
                          fit: BoxFit.fitWidth, width: 250, height: 50),
                      const SizedBox(height: 45),
                      firstNameField,
                      const SizedBox(height: 15),
                      secondNameField,
                      const SizedBox(height: 15),
                      emailField,
                      const SizedBox(height: 15),
                      passwordField,
                      const SizedBox(height: 15),
                      confirmPasswordField,
                      const SizedBox(height: 25),
                      signUpButton,
                      signInOption()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        // ignore: avoid_print
        print(error.code);
      }
    }
  }

  Future createMyList({required String? uid}) async {
    final docMyList = FirebaseFirestore.instance.collection('list').doc();

    final json = {
      'name': 'myList',
      'no_items': 0,
      'family': "",
      'id': docMyList.id,
      'type': 'personal',
      'user': uid,
      'date': FieldValue.serverTimestamp()
    };

    await docMyList.set(json);
  }

  Future createMyPantry({required String? uid}) async {
    final docMyList = FirebaseFirestore.instance.collection('pantry').doc();

    final json = {
      'id': docMyList.id,
      'user': uid,
    };

    await docMyList.set(json);
  }

  Future createMySchedule({required String? uid}) async {
    final docMySchedule =
        FirebaseFirestore.instance.collection('schedule').doc();

    final json = {
      'id': docMySchedule.id,
      'user': uid,
    };

    await docMySchedule.set(json);
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.familyID = "";

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    global.userId = user.uid;
    await getFamilyID(global.userId);
    await createMyList(uid: global.userId);
    getMyListInfo();
    createMyPantry(uid: global.userId);
    createMySchedule(uid: global.userId);
    getMyScheduleInfo();

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (route) => false);
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? ",
            style: TextStyle(color: myColors("Purple"), fontSize: 12)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: Text(
            "Log In",
            style: TextStyle(
                color: myColors("Purple"),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        )
      ],
    );
  }
}
