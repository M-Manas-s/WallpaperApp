import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaperapp/modals/LocalUser.dart';
import 'package:wallpaperapp/screens/IntroPage.dart';
import 'package:wallpaperapp/screens/LoadingPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin{
  double w = 0;
  double z = 0;
  double y = 0;
  String label = "Pour";
  late String email;

  loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('email'); // Uncommend this to always reach Auth Page
    email = prefs.getString('email')??"";
    if ( email!="" )
        LocalUser.email = email;
  }

  void startAnim() async {
    const int start = 700;
    Future.delayed(const Duration(milliseconds: start), () {
      setState(() {
        w = 1;
      });
    });

    Future.delayed(const Duration(milliseconds: start + 700), () {
      setState(() {
        w = 0;
      });
    });

    Future.delayed(const Duration(milliseconds: start + 1200), () {
      setState(() {
        z=1;
        label = "Vous";
      });
    });

    Future.delayed(const Duration(milliseconds: start + 1900), () {
      setState(() {
        w=0;
        z=0;
      });
    });

    Future.delayed(const Duration(milliseconds: start + 2400), () {
      setState(() {
        y=1;
        label = "Monsieur";
      });
    });

    Future.delayed(const Duration(milliseconds: start + 3200), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => (email==""?IntroPage():LoadingPage())));
    });

  }

  @override
  void initState() {
    loadPrefs();
    super.initState();
    startAnim();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black)
                ),
                child: SizedBox(
                  width: size.width * 0.7,
                  height: size.height * 0.1,
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 42.0, fontFamily: 'Horizon', letterSpacing: 3),
                    ),
                  ),
                ),
              )),
          Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black,width: 5)
                ),
                child: SizedBox(
                  width: (size.width * 0.7)*0.95,
                  height: (size.height * 0.1)*0.83,
                ),
              )),
          Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: y==1 ? 1000 : 500),
              color: Colors.black,
              curve: Curves.decelerate,
              width: size.width * 0.7,
              height: size.height * 0.3,
              margin: EdgeInsets.only(left : size.width*w,right: size.width*z, bottom: size.height*y),
            ),
          ),
        ],
      ),
    );
  }
}
