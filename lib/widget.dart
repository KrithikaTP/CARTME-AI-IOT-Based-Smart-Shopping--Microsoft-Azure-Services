import 'package:flutter/material.dart';
import 'package:shopasai/constants.dart';

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      contentPadding:EdgeInsets.only(top:20),
      prefixIcon: Padding(
        padding: EdgeInsets.only(top:15),

        child: Icon(Icons.account_circle,color: Colors.black,),

      ),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black54),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffA68445))),

      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)));

}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 15);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 17);
}

TextStyle signupTextstyle(fontsize){
  return TextStyle(
      fontFamily: 'roboto',
      fontSize: fontsize,
      color:kDoctorPrimaryColor,
      fontWeight: FontWeight.bold);
}
InputDecoration inputdecoration(hinttext) {
  String hinttext;
  return InputDecoration(
      contentPadding: EdgeInsets.only(top: 20),
      prefixIcon: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 10),
      ),
      hintText: hinttext,
      hintStyle: TextStyle(color: Colors.black54),
      focusedBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: Color(0xffA68445))),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black)));
}
TextStyle signin_uptextstyle(){
  return TextStyle(
      color: Color(0xff657C86),
      fontSize: 14,
      decoration: TextDecoration.underline);
}
