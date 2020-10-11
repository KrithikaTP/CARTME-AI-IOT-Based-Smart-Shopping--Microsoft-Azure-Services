import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cryptoutils/cryptoutils.dart';


class GenerateAuthToken {
  String verb = 'GET';
  String resourceType = 'docs';

  String date = HttpDate.format(DateTime.now());
  String masterKey =
      '<YOUR MASTER KEY(Cosmos DB)>';
  String keyType = "master";
  String tokenVersion = "1.0";
  String resourceId = '<Your Resoure Id>';

  Map<String,String> createToken() {

//    print(date);
    String payload = verb.toLowerCase() +
        '\n' +
        resourceType.toLowerCase() +
        '\n' +
        resourceId +
        '\n' +
        date.toLowerCase() +
        '\n' +
        '' +
        '\n';

    List<int> messageBytes = utf8.encode(payload);
    List<int> key = utf8.encode(masterKey);
    Hmac hmac = new Hmac(sha256, key);
    Digest digest = hmac.convert(messageBytes);
//    print(digest);
    String base64 = CryptoUtils.bytesToBase64(digest.bytes);
//    print(base64);
    String authToken = Uri.encodeComponent('type='+ keyType + '&ver=' + tokenVersion + '&sig=' + base64);
    return {'authToken':authToken,'date':date};

  }
}
