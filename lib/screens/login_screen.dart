import 'package:shopping_list/global.dart' as global;
import 'package:shopping_list/queries/family_list_queries.dart';
import 'package:shopping_list/queries/join_family_queries.dart';
import 'package:shopping_list/queries/my_list_queries.dart';
import 'package:shopping_list/queries/pantry_queries.dart';
import 'package:shopping_list/queries/scheduled_queries.dart';
import 'package:shopping_list/screens/dashboard_screen.dart';
import 'package:shopping_list/screens/home_screen.dart';
import 'package:shopping_list/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/color_utils.dart';
//this is a test

class EmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Please Enter Your Email' : null;
  }
}

class PasswordFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? 'Enter Valid Password' : null;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => EmailFieldValidator.validate(value!),
      /*{
        if (value!.isEmpty) {
          return ("Please enter email address");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Invalid email address");
        }
        return null;
      },*/
      onSaved: (value) {
        emailController.text = value!;
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
      controller: passwordController,
      obscureText: true,
      validator: (value) => PasswordFieldValidator.validate(value!),
      onSaved: (value) {
        passwordController.text = value!;
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

    final loginButton = Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: ElevatedButton(
        onPressed: () {
          signIn(emailController.text, passwordController.text);
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
          'LOG IN',
          style: TextStyle(
              color: myColors("White"),
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
    );
    return MaterialApp(
        home: Container(
            key: const Key('k'),
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
                resizeToAvoidBottomInset: false,
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
                              Column(
                                children: <Widget>[
                                  Text("Welcome",
                                      key: const Key('WelcomeText'),
                                      style: TextStyle(
                                          color: myColors("Purple"),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Image.asset("assets/essentials/logo.png",
                                      fit: BoxFit.fitWidth,
                                      width: 250,
                                      height: 50),
                                  const SizedBox(height: 40),
                                  emailField,
                                  const SizedBox(height: 15),
                                  passwordField,
                                  const SizedBox(height: 25),
                                  loginButton,
                                  signUpOption()
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ))));
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ",
            style: TextStyle(color: myColors("Purple"), fontSize: 12)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationScreen()));
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: myColors("Purple"),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        )
      ],
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) async => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  global.userId = uid.user?.uid,
                  print(global.userId),
                  await getFamilyID(global.userId),
                  await getMyListInfo(),
                  getFamilyListInfo(),
                  getMyPantryInfo(),
                  getMyScheduleInfo(),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const DashboardScreen())),
                  //getMyListItems()
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
            errorMessage = "Signing in with email and password is not enabled.";
            break;
          default:
            errorMessage = "An undefined error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        // ignore: avoid_print
        print(error.code);
      }
    }
  }
}
