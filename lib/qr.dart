import 'package:flutter/material.dart';

class QR_Code extends StatefulWidget {
  @override
  _QR_CodeState createState() => _QR_CodeState();
}

class _QR_CodeState extends State<QR_Code> {
  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                'Scan me',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              Image(
                  image: AssetImage('image/CUS149.jpeg')),
              SizedBox(
                height: 15,
              ),
              Text(
                'Start you shopping,\n with the Scan',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );

  }
}
