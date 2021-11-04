import 'package:flutter/material.dart';
import 'package:wallpaperapp/constants/RegexValidators.dart';
import 'package:wallpaperapp/constants/constants.dart';
import 'package:wallpaperapp/widgets/AuthenticationButton.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool state = true;
  late String email;
  late String password;

  // FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      "Don't have an account?",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {},
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
                  OnPressed: () {},
                  height: size.height * 0.075,
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
