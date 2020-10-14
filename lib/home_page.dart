import 'package:flutter/material.dart';
import 'package:shopasai/Screens/cart_page.dart';
import 'package:shopasai/Screens/tobuy_list.dart';
import 'package:shopasai/Services/product_detail.dart';
import 'package:shopasai/constants.dart';
import 'package:shopasai/profile.dart';
import 'package:shopasai/qr.dart';

import 'Services/azure_cosmos.dart';

class HomePage extends StatefulWidget {
  final String customerId;
  final List<String> productName;
  final List<ProductDetail> listOfProducts;

  HomePage({this.productName, this.listOfProducts, this.customerId});

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> tabs = [];
  List<String> productName;
  List<ProductDetail> listOfProducts;
//  final tabs =
  Widget appBarTitle = new Text(
    "CartMe",
    style: TextStyle(
        color: Colors.white, fontFamily: 'Viga', fontWeight: FontWeight.w700),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();

  bool _IsSearching;
  String _searchText = "";

  _HomePageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }
  Widget chooseBody(bool isSearching, int index) {
    if (isSearching) {
      return ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _buildSearchList(),
      );
    } else {
      return tabs[index];
    }
  }

  @override
  void initState() {
    productName = widget.productName;
    listOfProducts = widget.listOfProducts;
    tabs = [
      ToBuyList(
        customerId: widget.customerId,
      ),
      QR_Code(),
      profile()
    ];
    super.initState();
    _IsSearching = false;
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context, widget.customerId),
      body: chooseBody(_IsSearching, _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner, color: Colors.blue),
              title: Text(
                'Scan',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.blue),
              title: Text(
                'Profile',
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<ChildItem> _buildSearchList() {
    List<ChildItem> items = [];
    if (_searchText.isEmpty) {
      for (int i = 0; i < productName.length; i++) {
        ChildItem item = ChildItem(
          name: productName[i],
          index: i,
          listOfProducts: listOfProducts,
          customerId: widget.customerId,
        );
        items.add(item);
      }

      return items;
    } else {
      List<String> _searchList = List();
      for (int i = 0; i < productName.length; i++) {
        String name = productName.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
          ChildItem item = ChildItem(
            name: name,
            index: i,
            listOfProducts: listOfProducts,
            customerId: widget.customerId,
          );
          items.add(item);
        }
      }

      return items;
    }
  }

  Widget buildBar(BuildContext context, String customerId) {
    return new AppBar(
        leading: IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          iconSize: 30.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(
                  customerId: customerId,
                ),
              ),
            );
          },
        ),
        centerTitle: true,
        elevation: 0.0,
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
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "CartMe",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class ChildItem extends StatelessWidget {
  final String customerId;
  final String name;
  final int index;
  final List<ProductDetail> listOfProducts;
  ChildItem({this.name, this.index, this.listOfProducts, this.customerId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(index);
      },
      child: Container(
        color: Colors.white,
        height: 100,
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: NetworkImage(listOfProducts[index].imageUrl),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listOfProducts[index].name,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        'Rs. ' + listOfProducts[index].price.toString(),
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
                  child: GestureDetector(
                    onTap: () {
                      AzureCosmosDB cosmosDB = AzureCosmosDB();
                      cosmosDB.addToCheckList(
                          customerId: customerId,
                          productId: listOfProducts[index].id);
                    },
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 0.3,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
