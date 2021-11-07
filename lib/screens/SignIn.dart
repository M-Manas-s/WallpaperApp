import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaperapp/modals/LocalUser.dart';
import 'package:wallpaperapp/constants/RegexValidators.dart';
import 'package:wallpaperapp/constants/constants.dart';
import 'package:wallpaperapp/widgets/AuthenticationButton.dart';

import 'IntroPage.dart';
import 'LoadingPage.dart';
import 'Register.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool state = true;
  late String email;
  late String password;
  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  SignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        var user = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        LocalUser.email = email;

        if (user != null) {
          setState(() {
            loading = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoadingPage()),
              (route) => false);
        }
      } on Exception {
        setState(() {
          loading = false;
        });
        showFlash(
          context: context,
          duration: Duration(milliseconds: 1300),
          builder: (context, controller) {
            return Flash(
              controller: controller,
              behavior: FlashBehavior.floating,
              position: FlashPosition.bottom,
              boxShadows: kElevationToShadow[4],
              horizontalDismissDirection: HorizontalDismissDirection.horizontal,
              child: FlashBar(
                content: Text("Wrong Email/Password"),
              ),
            );
          },
        );
      }
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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.07),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's sign you in.",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.006,
                      ),
                      Text(
                        "Welcome back.",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.003,
                      ),
                      Text(
                        "You've been missed!",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
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
                                      decoration: kLogInInputDecoration
                                          .copyWith(hintText: "Password"),
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
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.07,
                      vertical: size.width * 0.07),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 17, color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                  (route) => false);
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      AuthenticationButton(
                        label: "Sign In",
                        color: Colors.white,
                        onPressed: SignIn,
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
              Container(),
          ],
        )),
      ),
    );
  }
}
