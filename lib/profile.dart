
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopasai/menu.dart';

String _comp = '';
String _companyname='';
class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  getUserInfogetChats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _comp = prefs.getString('comp');
    _companyname =prefs.getString('company_name');
    //print(Constants.myName);

    setState(() {
      _comp = (prefs.getString('comp') ?? '');
      _companyname = (prefs.getString('company_name') ?? '');
      print('companyyy');
      print(_companyname);
    });
  }

  @override
  void initState() {

    super.initState();
    getUserInfogetChats();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/sign.png'),
                  fit: BoxFit.cover),
            ),
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQuIM2Kwi_1IOCBHfB3z2CZWpjl7igvaMpYZw&usqp=CAU'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(80.0),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Text(
                  'Karthikeyan',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 400.0,
                  height: 1.0,
                  child: const DecoratedBox(
                    decoration:
                    const BoxDecoration(color: Colors.black87),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'ktv0303@gmail.com',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '15,gandhi nagar chennai',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),Text(
                  '123456789',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 400.0,
                  height: 1.0,
                  child: const DecoratedBox(
                    decoration:
                    const BoxDecoration(color: Colors.black87),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    prefs.remove('comp');
                    SharedPreferences pref =
                    await SharedPreferences.getInstance();
                    prefs.remove('company_name');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => menu()));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.exit_to_app)),
                ),
                Text(
                  'Signout',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 400.0,
                  height: 1.0,
                  child: const DecoratedBox(
                    decoration:
                    const BoxDecoration(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
