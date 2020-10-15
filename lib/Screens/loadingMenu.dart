import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopasai/Services/azure_cosmos.dart';
import 'package:shopasai/Services/product_detail.dart';

import 'home_page.dart';

class LoadingMenu extends StatefulWidget {
  final String customerId;

  LoadingMenu({this.customerId});

  @override
  _LoadingMenuState createState() => _LoadingMenuState();
}

class _LoadingMenuState extends State<LoadingMenu> {
  bool showSpinner = true;
  void loadMenu() async {
    AzureCosmosDB cosmosDB = AzureCosmosDB();
    List<ProductDetail> listOfProducts = await cosmosDB.products();
    List<String> productName = [];
    for (ProductDetail detail in listOfProducts) {
      productName.add(detail.name);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          productName: productName,
          listOfProducts: listOfProducts,
          customerId: widget.customerId,
        ),
      ),
    );
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    loadMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
