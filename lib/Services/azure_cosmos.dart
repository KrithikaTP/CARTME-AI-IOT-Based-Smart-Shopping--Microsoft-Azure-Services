import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopasai/Services/cart_items.dart';
import 'package:shopasai/Services/check_list_info.dart';
import 'package:shopasai/Services/product_detail.dart';
import 'package:shopasai/Services/user_info.dart';

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
          'type%3Dmaster%26ver%3D1.0%26sig%3Dii%2Bim3M0Y446f4Rt9CAdl7%2FiP23LIWtsouA4RYHWULs%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:11:32 GMT',
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
      'type%3Dmaster%26ver%3D1.0%26sig%3DkVosWHxgRJl5vvzTfFVm%2FMXUDvwvcmEVRllo79Y9hgg%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:13:54 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'
    };
    //Put Document
    Map<String, String> httpHeaderPut = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
          'type%3Dmaster%26ver%3D1.0%26sig%3Dd5udjBC2YkkMhKzi%2B8C2ZEXPPWjiY4ED94juXCKSias%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:15:55 GMT',
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
      'type%3Dmaster%26ver%3D1.0%26sig%3DkVosWHxgRJl5vvzTfFVm%2FMXUDvwvcmEVRllo79Y9hgg%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:13:54 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'
    };
    //Get All documents
    Map<String, String> httpHeader = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
      'type%3Dmaster%26ver%3D1.0%26sig%3Dii%2Bim3M0Y446f4Rt9CAdl7%2FiP23LIWtsouA4RYHWULs%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:11:32 GMT',
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
      'type%3Dmaster%26ver%3D1.0%26sig%3DkVosWHxgRJl5vvzTfFVm%2FMXUDvwvcmEVRllo79Y9hgg%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:13:54 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'
    };
    //Get all Documents
    Map<String, String> httpHeader = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
      'type%3Dmaster%26ver%3D1.0%26sig%3Dii%2Bim3M0Y446f4Rt9CAdl7%2FiP23LIWtsouA4RYHWULs%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:11:32 GMT',
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

  Future<UserInfo> getUserDetails({String customerId}) async{
    Map<String, String> httpHeaderGet = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
      'type%3Dmaster%26ver%3D1.0%26sig%3DkVosWHxgRJl5vvzTfFVm%2FMXUDvwvcmEVRllo79Y9hgg%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:13:54 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'

    };
    try{
      var responseGet = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/customers/docs/$customerId',
          headers: httpHeaderGet);
      if (responseGet.statusCode == 200) {
        print(200);
        var decodeData = jsonDecode(responseGet.body);
        print(decodeData['Name']);
        print(decodeData['phone']);
        print(decodeData['email']);
        return  UserInfo(
          name: decodeData['Name'],
          phNumber: decodeData['phone'],
          email: decodeData['email'],
        );
      }else{
        return UserInfo();
      }
    }catch(e){
      return UserInfo();
    }
  }

  Future<bool> checkUserAuthentication({String customerId}) async{
    Map<String, String> httpHeaderGet = {
      'Accept': 'application/json',
      'x-ms-version': '2016-07-11',
      'Authorization':
      'type%3Dmaster%26ver%3D1.0%26sig%3DkVosWHxgRJl5vvzTfFVm%2FMXUDvwvcmEVRllo79Y9hgg%3D',
      'x-ms-date': 'Tue, 13 Oct 2020 17:13:54 GMT',
      'x-ms-documentdb-partitionkey': '["$customerId"]'

    };
    try{
      var responseGet = await http.get(
          'https://shopasai.documents.azure.com:443/dbs/ShopAsAI/colls/customers/docs/$customerId',
          headers: httpHeaderGet);
      if (responseGet.statusCode == 200) {
        print(200);
        return  true;
      }else{
        print('No');
        return false;
      }
    }catch(e){
      return false;
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
