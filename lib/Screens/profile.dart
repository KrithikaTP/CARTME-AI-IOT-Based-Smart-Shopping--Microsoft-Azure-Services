import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopasai/Services/user_info.dart';
import '../Services/azure_cosmos.dart';

class Profile extends StatefulWidget {
  final String customerId;

  Profile({this.customerId});

  @override
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<Profile> {
  bool showSpinner = true;
  String name;
  String email;
  int phNumber;

  AzureCosmosDB cosmosDB = AzureCosmosDB();
  void loadDetails() async {
    UserInfo info =
        await cosmosDB.getUserDetails(customerId: widget.customerId);
    print(info.name);
    print(info.email);
    print(info.phNumber);
    name = info.name;
    email = info.email;
    phNumber = info.phNumber;
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('image/sign.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
            ),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: Text(
                    phNumber.toString(),
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                )),
            Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    email,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro'),
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
