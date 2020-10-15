import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paytm/paytm.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import '../Services/constants.dart';

void main() => runApp(PaymentPaytym());

class PaymentPaytym extends StatefulWidget {
  final int costTotal;

  PaymentPaytym({this.costTotal});

  @override
  _PaymentPaytymState createState() => _PaymentPaytymState();
}

class _PaymentPaytymState extends State<PaymentPaytym> {
  String payment_response = null;
  Widget appBarTitle = new Text(
    "CartMe",
    style: TextStyle(
        color: Colors.white, fontFamily: 'Viga', fontWeight: FontWeight.w700),
  );
  //Live
  String mid = "LIVE_MID_HERE";
  String PAYTM_MERCHANT_KEY = "LIVE_KEY_HERE";
  String website = "DEFAULT";
  bool testing = false;



  double amount = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF1A2980),
                Color(0xFF26D0CE),
              ],
            ),
          ),
        ),
        title: appBarTitle,
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text('Your Total Rs.(${widget.costTotal})',style: TextStyle(color: kDoctorPrimaryColor,wordSpacing: 1.0,fontSize: 40.0,fontFamily: 'CarterOne'),),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                payment_response != null
                    ? new HtmlView(data: payment_response)
                    : Container(),

                RaisedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(0);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Pay using Wallet",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(1);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Pay using Net Banking",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(2);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Pay using UPI",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    //Firstly Generate CheckSum bcoz Paytm Require this
                    generateTxnToken(3);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Pay using Credit Card",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  void generateTxnToken(int mode) async {
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
        ? 'https://securegw-stage.paytm.in'
        : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode({
      "mid": mid,
      "key_secret": PAYTM_MERCHANT_KEY,
      "website": website,
      "orderId": orderId,
      "amount": amount.toString(),
      "callbackUrl": callBackUrl,
      "custId": "122",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
      });

      var paytmResponse = Paytm.payWithPaytm(
          mid, orderId, txnToken, amount.toString(), callBackUrl, testing);

      paytmResponse.then((value) {
        print(value);
        setState(() {
          loading = false;
          payment_response = value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }
}