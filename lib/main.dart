
import 'package:flutter/material.dart';
import 'package:shopasai/Screens/loadingMenu.dart';
import 'package:shopasai/home_page.dart';
import 'package:shopasai/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SplashScreen.dart';

void main() => runApp(MyApp());


String _comp;
String _idpat;
String _iddoc;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _comp = prefs.getString('comp');
    SharedPreferences pref= await SharedPreferences.getInstance();
    _idpat = pref.getString('idpat');
    SharedPreferences pre= await SharedPreferences.getInstance();
    _iddoc = pref.getString('iddoc');


    setState(() {
      _comp = prefs.getString('comp');
      _idpat = prefs.getString('idpat');
      _iddoc = prefs.getString('iddoc');
    });
  }


  Widget fun(){
//    if (_comp==null && _idpat==null && _iddoc==null){
//      return SplashScreen();
//    }
//    else if(_idpat==null && _iddoc==null){
//      return menu_company();
//    }
//    else if(_comp==null && _iddoc==null){
//      //return menu_patient();
//      return LoadingMenu();
//    }
//    else if(_comp==null && _idpat==null){
//      return menu_hospital();
//    }
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
        //home: _email == null ? SplashScreen() : menu_teacher());

        home: LoadingMenu());
    //home: fun());
  }
}
