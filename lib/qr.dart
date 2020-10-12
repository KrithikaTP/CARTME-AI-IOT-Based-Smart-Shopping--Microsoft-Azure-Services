import 'package:flutter/material.dart';

class qr extends StatefulWidget {
  @override
  _qrState createState() => _qrState();
}

class _qrState extends State<qr> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        title: Text(
        'Scan me',
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

    padding: EdgeInsets.all(15.0),
    child: Column(
    children: [
    SizedBox(
    height: 90,
    ),

    SizedBox(
    height: 30,
    ),
   Image(image: NetworkImage('https://www.qr-code-generator.com/wp-content/themes/qr/new_structure/markets/core_market_full/generator/dist/generator/assets/images/websiteQRCode_noFrame.png')),
    SizedBox(
    height: 15,
    ),

    Text(
    'Scan this to an cart!',
    style: TextStyle(
    fontSize: 25.0,
    color: Colors.black54,
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
