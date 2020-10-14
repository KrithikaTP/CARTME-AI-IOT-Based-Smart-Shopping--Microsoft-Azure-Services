
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopasai/signin_comp.dart';
import 'package:shopasai/widget.dart';

import 'home_page.dart';
import 'menu.dart';

class signup_comp extends StatefulWidget {
  @override
  _signup_compState createState() => _signup_compState();
}

class _signup_compState extends State<signup_comp> {


  String text = '';
  TextEditingController idEditingController = new TextEditingController();
  TextEditingController compEditingController = new TextEditingController();

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  bool found = false;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async{
//    if (formKey.currentState.validate()) {
//
//      setState(() {
//        isLoading = true;
//      });
//
//      try {
//        WidgetsFlutterBinding.ensureInitialized();
//        await Firebase.initializeApp();
//
//        final firestoreInstance = Firestore.instance;
//
//
//        var ress;
//        var result = await firestoreInstance
//            .collection("company")
//            .where("id", isEqualTo: compEditingController.text)
//            .getDocuments();
//        result.documents.forEach((res) {
//
//          ress = res.get('name');
//
//
//
//          found = true;
//          firestoreInstance.collection("company").document("all_companies").collection(ress).document("Users").collection(emailEditingController.text).doc("details").set(
//              {
//                "email" : emailEditingController.text,
//
//
//              }).then((value){
//            //print(value.documentID);
//
//          });
//
//        });
//
//
//        if (found==true) {
//          final _auth = FirebaseAuth.instance;
//          final newUser = await _auth.createUserWithEmailAndPassword(
//              email: emailEditingController.text, password: passwordEditingController.text);
//          if (newUser != null) {
//            SharedPreferences prefs = await SharedPreferences.getInstance();
//            prefs.setString('comp', emailEditingController.text);
//            SharedPreferences pref = await SharedPreferences.getInstance();
//            prefs.setString('company_name', ress.toString());
//            Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(builder: (context) => menu_company()));
//          }
//        }
//        else{
//          setState(() {
//            isLoading = false;
//            text = 'Access id did not found!!';
//          });
//        }
//
//
//
//
//
//
//      } catch (e) {
//        print(e);
//        setState(() {
//          isLoading = false;
//          text = 'Account Does not found & password Did not match!!';
//        });
//      }
//
////
  //  }
  }



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
                      'Sign Up:',
                      textAlign: TextAlign.left,
                      style: signupTextstyle(40.0),
                    ),
                  ),
                ),

                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      'Enter your Email ID & Password to Sign Up!!',
                      textAlign: TextAlign.left,
                      style: signupTextstyle(18.0),
                    ),
                  ),
                ),





                Form(
                  key: formKey,

                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      children: [


                        SizedBox(height: 100,),

                        TextFormField(
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
                              hintText: 'Email ID',
                              hintStyle: TextStyle(color: Colors.black38),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6DD8D2))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black))),
                        ),
                        SizedBox(height: 50,),

                        TextFormField(
                          obscureText: true,


                          controller: passwordEditingController,

                          style: simpleTextStyle(),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 20),
                              prefixIcon: Padding(
                                padding:
                                EdgeInsets.only(top: 15, bottom: 10),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.black38),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff6DD8D2))),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            text,textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),

                        SizedBox(height: 50,),

                        FlatButton(
                          color: Colors.transparent,

                          onPressed: () {
                            //signIn();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()));
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
                                'Sign Up!!',
                                style: TextStyle(fontSize: 20)
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an Account? ",
                              style: simpleTextStyle(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            signin_comp()));
                              },
                              child: Text(
                                "Sign up.",
                                style:signin_uptextstyle(),
                              ),
                            ),
                            SizedBox(height: 125,),
                          ],
                        ),

                      ],
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