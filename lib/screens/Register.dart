import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaperapp/modals/LocalUser.dart';
import 'package:wallpaperapp/constants/RegexValidators.dart';
import 'package:wallpaperapp/constants/constants.dart';
import 'package:wallpaperapp/screens/SignIn.dart';
import 'package:wallpaperapp/widgets/AuthenticationButton.dart';

import 'IntroPage.dart';
import 'LoadingPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool state = true;
  late String email;
  late String password;
  late String name;
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Register() async {

    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      var newuser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseFirestore.instance.collection('Users').add({
        'Name': name,
        "Email": email,
      }).then((value) => LocalUser.id = value.id);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      LocalUser.email = email;

      if (newuser != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoadingPage()),
                (route) => false);
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => IntroPage()),
            (route) => false);
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Stack(
              children: [Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1, vertical: size.height * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's sign you up.",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.006,
                    ),
                    Text(
                      "Hello there.",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.003,
                    ),
                    Text(
                      "We need you!",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Form(
                        key: _formKey,
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                                // color : Colors.white,
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    name = value.trim();
                                  },
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.left,
                                  decoration: kLogInInputDecoration.copyWith(
                                      hintText: "Full Name"),
                                  validator: usernameValidator,
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (value) {
                                    email = value.trim();
                                  },
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.left,
                                  decoration: kLogInInputDecoration.copyWith(
                                      hintText: "Email"),
                                  validator: emailChecker,
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                //SizedBox(height: 10),
                                Stack(
                                  children: [
                                    TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      onChanged: (value) {
                                        password = value.trim();
                                      },
                                      obscureText: state,
                                      cursorColor: Colors.white,
                                      textAlign: TextAlign.left,
                                      decoration: kLogInInputDecoration.copyWith(
                                          hintText: "Password"),
                                      validator: passwordValidator,
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 20,
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              state = !state;
                                            });
                                          },
                                          child: Icon(
                                            !state
                                                ? Icons.remove_red_eye
                                                : Icons.remove_red_eye_outlined,
                                            color: Colors.white,
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            )),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07, vertical: size.width * 0.07),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()),
                                (route) => false);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    AuthenticationButton(
                      label: "Register",
                      color: Colors.white,
                      onPressed: Register,
                      height: size.height * 0.075,
                    )
                  ],
                ),
              ),
          ],
        ),
                if (loading)
                  Center(
                      child: Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.black.withOpacity(0.5),
                        child: Container(),
                      ))
                else
                  Container(),
                if (loading)
                  Center(
                      child: Container(width: size.width*0.5,child: Lottie.asset("anim/loading.json")))
                else
                  Container(),],
            )),
      ),
    );
  }
}
