import 'package:flutter/material.dart';

import 'Screens/sign_in.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff2663E2),
          scaffoldBackgroundColor: Colors.white,
          accentColor: Color(0xff6DD8D2),
          fontFamily: "OverpassRegular",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignIn());
  }
}
