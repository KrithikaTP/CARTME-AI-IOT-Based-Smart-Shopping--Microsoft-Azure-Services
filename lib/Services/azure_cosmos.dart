import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopasai/Services/cart_items.dart';
import 'package:shopasai/Services/check_list_info.dart';
import 'package:shopasai/Services/product_detail.dart';

import 'generate_auth_token.dart';

class AzureCosmosDB {
  String data;

  Future<List<ProductDetail>> products() async {
    List<ProductDetail> productsList = [];
//    GenerateAuthToken authToken = GenerateAuthToken();
//    Map<String, String> authentication = authToken.createToken();
//    print(authentication['authToken']);
    //Get All Documents
    Map<String, String> httpHeader = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
          'type%3Dmaster%26ver%3D1.0%26sig%3DBka5NDZj%2BMabtoa1QtYQhJUTySZT71AY0N4cwwJom7U%3D',
      'x-ms-date': 'Mon, 12 Oct 2020 17:02:19 GMT',
//      'x-ms-documentdb-partitionkey': '["$userId"]'
    };
    try {
      var response = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/products/docs',
          headers: httpHeader);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        int totalProducts = decodeData['_count'];
        for (int i = 0; i < totalProducts; i++) {
          ProductDetail productDetail = ProductDetail(
              id: decodeData['Documents'][i]['id'],
              name: decodeData['Documents'][i]['name'],
              imageUrl: decodeData['Documents'][i]['imageUrl'],
          price: decodeData['Documents'][i]['price']);
//              print(decodeData['Documents'][i]['id'] + ' ' +decodeData['Documents'][i]['name'] + ' ' +decodeData['Documents'][i]['imageUrl']);
          productsList.add(productDetail);
        }
        return productsList;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addToCheckList({String customerId, String productId}) async {
    //Get Document
    Map<String, String> httpHeaderGet = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
          'type%3Dmaster%26ver%3D1.0%26sig%3DyVsEU9ZQfItoJ%2BW7xvq%2B63bH2baDb3CxBZKkBLChTpc%3D',
      'x-ms-date': 'Sun, 11 Oct 2020 14:33:33 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'
    };
    //Put Document
    Map<String, String> httpHeaderPut = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
          'type%3Dmaster%26ver%3D1.0%26sig%3D1sj%2BgwU4husdr12MFR4UBwyZrq59jgDQWTF0DLrHf6s%3D',
      'x-ms-date': 'Sun, 11 Oct 2020 14:34:08 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'
    };

    try {
      var responseGet = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/customers/docs/$customerId',
          headers: httpHeaderGet);
      if (responseGet.statusCode == 200) {
        var decodeData = jsonDecode(responseGet.body);
        List<dynamic> presentCheckList = decodeData['checkList'];
        presentCheckList.add(productId);
        decodeData['checkList'] = presentCheckList;
        var responsePut = await http.put(
            'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/customers/docs/$customerId',
            headers: httpHeaderPut,
            body: jsonEncode(decodeData));
        print('hI');
        print(responsePut.statusCode);
      } else {
        print('no');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<CartItems>> displayCart({String customerId}) async {
    List<CartItems> cart = [];
    Map<dynamic, int> map = {};
    //Get Document
    Map<String, String> httpHeaderCustomer = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
          'type%3Dmaster%26ver%3D1.0%26sig%3DPjcpv6CsOJ5BHOPElpdoUbSLRl9OylSxGo1zNF%2FZb54%3D',
      'x-ms-date': 'Sun, 11 Oct 2020 18:35:12 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'
    };
    //Get All documents
    Map<String, String> httpHeader = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
      'type%3Dmaster%26ver%3D1.0%26sig%3DvV8TZs8nh9zWK6KDHglVh9bAnb8whW7VR2FSVm0gAKk%3D',
      'x-ms-date': 'Sun, 11 Oct 2020 18:36:00 GMT',
//      'x-ms-documentdb-partitionkey': '["$userId"]'
    };
    try {
      var response = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/products/docs',
          headers: httpHeader);
      var data = jsonDecode(response.body);
      var responseCustomer = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/customers/docs/$customerId',
          headers: httpHeaderCustomer);
      if (responseCustomer.statusCode == 200) {
        var decodeData = jsonDecode(responseCustomer.body);
        List<dynamic> cartItems = decodeData['cart'];
        print(cartItems);
        cartItems
            .forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));
        if (cartItems.length > 0) {
          for (var item in map.keys) {
            for (int i = 0; i < data['_count']; i++) {
              if (data['Documents'][i]['id'] == item.toString()) {
                CartItems info = CartItems(
                  name: data['Documents'][i]['name'],
                  imageUrl: data['Documents'][i]['imageUrl'],
                  id: data['Documents'][i]['id'],
                  price: map[item] * data['Documents'][i]['price'],
                  quantity: map[item]
                );
                cart.add(info);
                break;
              }
            }
          }
        }
        return cart;
      } else {
        print('No');
        return cart;
      }
    } catch (e) {
      print(e);
      return cart;
    }
  }

  Future<List<CheckListInfo>> checkListDisplay({String customerId}) async {
    List<CheckListInfo> allCheckListItems = [];
    Map<dynamic, int> mapCart = {};
    Map<dynamic, int> mapCheckList = {};
    //Get Document
    Map<String, String> httpHeaderCustomer = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
          'type%3Dmaster%26ver%3D1.0%26sig%3DtIIsqrkwdDalh7awZphQ190KHSqGGN9t8fv%2F4n6JfkU%3D',
      'x-ms-date': 'Mon, 12 Oct 2020 17:10:45 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'
    };
    //Get all Documents
    Map<String, String> httpHeader = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
          'type%3Dmaster%26ver%3D1.0%26sig%3DBka5NDZj%2BMabtoa1QtYQhJUTySZT71AY0N4cwwJom7U%3D',
      'x-ms-date': 'Mon, 12 Oct 2020 17:02:19 GMT',
//      'x-ms-documentdb-partitionkey': '["$userId"]'
    };
    try {
      var response = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/products/docs',
          headers: httpHeader);
      var data = jsonDecode(response.body);
      var responseCustomer = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/customers/docs/$customerId',
          headers: httpHeaderCustomer);
      if (responseCustomer.statusCode == 200) {
        var decodeData = jsonDecode(responseCustomer.body);
        List<dynamic> cartItems = decodeData['cart'];
        List<dynamic> checkListItems = decodeData['checkList'];
        cartItems.forEach((x) =>
            mapCart[x] = !mapCart.containsKey(x) ? (1) : (mapCart[x] + 1));
        checkListItems.forEach((x) => mapCheckList[x] =
            !mapCheckList.containsKey(x) ? (1) : (mapCheckList[x] + 1));
        for (var checkListItem in mapCheckList.keys) {
          try{
          if (mapCart[checkListItem] == mapCheckList[checkListItem]) {
            for (int i = 0; i < data['_count']; i++) {
              if (data['Documents'][i]['id'] == checkListItem.toString()) {
                CheckListInfo info = CheckListInfo(
                    id: data['Documents'][i]['id'],
                    name: data['Documents'][i]['name'],
                    count: mapCheckList[checkListItem],
                    isChecked: true);
                allCheckListItems.add(info);
                break;
              }
            }
          }
          else {
            for (int i = 0; i < data['_count']; i++) {
              if (data['Documents'][i]['id'] == checkListItem.toString()) {
                CheckListInfo info = CheckListInfo(
                    id: data['Documents'][i]['id'],
                    name: data['Documents'][i]['name'],
                    count: mapCheckList[checkListItem],
                    isChecked: false);
                allCheckListItems.add(info);
                break;
              }
            }
          }}
          catch(e){
            for (int i = 0; i < data['_count']; i++) {
              if (data['Documents'][i]['id'] == checkListItem.toString()) {
                CheckListInfo info = CheckListInfo(
                    id: data['Documents'][i]['id'],
                    name: data['Documents'][i]['name'],
                    count: mapCheckList[checkListItem],
                isChecked: false);
                allCheckListItems.add(info);
                break;
              }
            }
          }
        }
        return allCheckListItems;
      }
      else{
        print('No');
        return allCheckListItems;
      }
    } catch (e) {
      print(e);
      return allCheckListItems;
    }
  }
}

//void main() async {
//  AzureCosmosDB cosmosDB = AzureCosmosDB();
//  List<CartItems> list = await cosmosDB.displayCart(customerId: 'CUS149');
//  for(CartItems info in list){
//    print(info.id);
//    print(info.name);
//    print(info.price);
//    print(info.quantity);
//  }
//}
