
import 'package:flutter/material.dart';
import 'package:shopasai/Screens/loadingMenu.dart';


import 'package:shopasai/menu.dart';
import 'Services/azure_cosmos.dart';
import 'widget.dart';

class signin_comp extends StatefulWidget {
  @override
  _signin_compState createState() => _signin_compState();
}

class _signin_compState extends State<signin_comp> {
  AzureCosmosDB cosmosDB = AzureCosmosDB();


  String text = '';
  TextEditingController emailEditingController = new TextEditingController();


  bool found = false;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String customerId;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => menu()));
            },
          ),
        ),
        extendBodyBehindAppBar: true,

        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('image/sign.png'),
                fit: BoxFit.cover
            ) ,
          ),
          padding:EdgeInsets.all(15.0),
          child: isLoading
              ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              :Container
            (
            child:Column(

              children: [

                SizedBox(height: 110,),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      'Sign In:',
                      textAlign: TextAlign.left,
                      style: signupTextstyle(40.0),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: formKey,

                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: TextFormField(
                      onChanged: (value){
                        customerId = value;
                      },
                      validator: (val) {
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: emailEditingController,

                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 20),
                          prefixIcon: Padding(
                            padding:
                            EdgeInsets.only(top: 15, bottom: 10),
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.black87,
                              size: 30.0,
                            ),
                          ),
                          hintText: 'Customer ID',
                          hintStyle: TextStyle(color: Colors.black38),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff6DD8D2))),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.black))),
                    ),
                  )

                ),
                SizedBox(
                  height: 20.0
                ),
                GestureDetector(
                  onTap: () async{
                    bool isAuthenticated = await cosmosDB.checkUserAuthentication(customerId: customerId);
                    if(isAuthenticated){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingMenu(customerId: customerId,)));
                    }
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
                        'Sign In and Cart Me!!',
                        style: TextStyle(fontSize: 20)
                    ),
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