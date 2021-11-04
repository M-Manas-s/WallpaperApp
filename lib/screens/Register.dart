import 'package:flutter/material.dart';
import 'package:wallpaperapp/constants/RegexValidators.dart';
import 'package:wallpaperapp/constants/constants.dart';
import 'package:wallpaperapp/screens/SignIn.dart';
import 'package:wallpaperapp/widgets/AuthenticationButton.dart';

import 'IntroPage.dart';

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

  // FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Register() async {
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
            child: Column(
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
                                        validator: emailChecker,
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
                                            cursorColor: Theme.of(context).accentColor,
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
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInPage()), (route) => false);
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
                        onPressed: () {},
                        height: size.height * 0.075,
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
