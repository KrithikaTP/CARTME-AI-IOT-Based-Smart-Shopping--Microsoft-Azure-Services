import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopasai/Screens/paytym_payment.dart';
import 'package:shopasai/Services/azure_cosmos.dart';
import 'package:shopasai/Services/cart_items.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CartPage extends StatefulWidget {
  final String customerId;

  CartPage({this.customerId});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalBill = 0;
  AzureCosmosDB cosmosDB = AzureCosmosDB();
  bool showSpinner = true;
  List<CartItems> cartItems = [];
  Widget appBarTitle = new Text(
    "CartMe",
    style: TextStyle(
        color: Colors.white, fontFamily: 'Viga', fontWeight: FontWeight.w700),
  );
  void loadCart() async {
    cartItems = await cosmosDB.displayCart(customerId: widget.customerId);
    for (CartItems item in cartItems) {
      totalBill += item.price;
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    loadCart();
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
//                Color(0xff611cdf),
              ],
            ),
          ),
        ),
        title: appBarTitle,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1A2980),
                        Color(0xFF26D0CE),
//                Color(0xff611cdf),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Your Cart",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'CarterOne'),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 30.0,
                      )
                    ],
                  ),
                ),
              ),
              // ignore: missing_return
              Expanded(
                flex: 9,
                child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image(
                                      image: NetworkImage(
                                          cartItems[index].imageUrl),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItems[index].name,
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Ubuntu',
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Text(
                                        'Rs. ' +
                                            cartItems[index].price.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Viga',
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                      radius: 15.0,
                                      backgroundColor: Colors.green,
                                      child: Text(
                                        cartItems[index].quantity.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      )),
                                )
                              ],
                            ),
                            Container(
                              height: 0.3,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPaytym(
                          costTotal: totalBill,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 15.0,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      color: Colors.deepOrange,
                      height: 60,
                      width: double.infinity,
                      child: Text(
                        'Total: Rs.$totalBill',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CarterOne',
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
