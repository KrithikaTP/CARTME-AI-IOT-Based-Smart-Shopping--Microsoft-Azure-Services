import 'package:flutter/material.dart';

const kFormTitleTextStyle = TextStyle(
    color: Color(0xFF7A8191), fontSize: 24.0, fontWeight: FontWeight.w600,decoration: TextDecoration.none);

const kFilterFormTitleTextStyle = TextStyle(
    color: kDoctorPrimaryColor, fontSize: 24.0, fontWeight: FontWeight.w600,decoration: TextDecoration.none,fontFamily: 'Ubuntu');

const kDoctorPrimaryColor = Color(0xFF0e165c);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const List<String> kSpecializations = [
  'Cradiology',
  'Critical_Care',
  'Diabetology',
  'Odontology',
  'Emergency_medicine',
  'Endocrinology',
  'Genral&laparascopic_surgy',
  'Neurology',
  'Ophthalmolopgy',
  'Orthopedics',
  'Rheumatology',
  'Urology'
];
const kSpecializationDropDown = [
  DropdownMenuItem(
    child: Text('Cradiology'),
    value: 'Cardiology',
  ),
//  DropdownMenuItem(
//    child: Text('Critical_Care'),
//    value: 'Critical_Care',
//  ),
  DropdownMenuItem(
    child: Text('Diabetology'),
    value: 'Diabetology',
  ),
  DropdownMenuItem(
    child: Text('Rheumatology'),
    value: 'Rheumatology',
  ),
  DropdownMenuItem(
    child: Text('Odontology'),
    value: 'Odontology',
  ),
  DropdownMenuItem(
    child: Text('Endocrinology'),
    value: 'Endocrinology',
  ),
  DropdownMenuItem(
    child: Text('Genral&laparascopic_surgy'),
    value: 'Genral&laparascopic_surgy',
  ),
  DropdownMenuItem(
    child: Text('Neurology'),
    value: 'Neurology',
  ),
  DropdownMenuItem(
    child: Text('Ophthalmolopgy'),
    value: 'Ophthalmolopgy',
  ),
  DropdownMenuItem(
    child: Text('Orthopedics'),
    value: 'Orthopedics',
  ),
  DropdownMenuItem(
    child: Text('Urology'),
    value: 'Urology',
  ),

];
