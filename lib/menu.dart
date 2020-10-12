import 'dart:async';


import 'package:flutter/material.dart';
import 'package:shopasai/signin_comp.dart';
import 'package:shopasai/signup_comp.dart';
import 'package:shopasai/widget.dart';


class menu extends StatefulWidget {
  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        backgroundColor: Colors.transparent,

          body:Container(


        decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/Slice.png'),
                  fit: BoxFit.cover
              ) ,
            ),
            padding:EdgeInsets.all(15.0),
            child:Column(
          children: [

            SizedBox(height: 100,),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  'Log In:',
                  textAlign: TextAlign.left,

                  style: signupTextstyle(40.0),
                ),
              ),
            ),

            SizedBox(height: 280),





            FlatButton(
              color: Colors.transparent,

              onPressed: () {

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => signin_comp()));
              },
              child: Container(
                decoration:  BoxDecoration(

                  border: new Border.all(

                      color: Color(0xff00ffaa), width: 1),
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xff6DD8D2),
                      Color(0xff6DD8D2),
                      Color(0xff6DD8D2),
                    ],
                  ),
                ),
                padding:EdgeInsets.all(10.0),
                child: const Text(
                    '      Sign In      ',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),

            SizedBox(height: 30,),

            FlatButton(
              color: Colors.transparent,

              onPressed: () {

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => signup_comp()));
              },
              child: Container(
                decoration:  BoxDecoration(

                  border: new Border.all(

                      color: Color(0xff00ffaa), width: 1),
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xff6DD8D2),
                      Color(0xff6DD8D2),
                      Color(0xff6DD8D2),
                    ],
                  ),
                ),
                padding:EdgeInsets.all(10.0),
                child: const Text(
                    '       Sign Up       ',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ),



            SizedBox(height: 30,),


          ],
          ),
  ),
        ),
    );
  }
}
