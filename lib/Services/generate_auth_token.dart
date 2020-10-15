import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cryptoutils/cryptoutils.dart';


class GenerateAuthToken {
  final String verb;
  final String resourceType;

  String date = HttpDate.format(DateTime.now());
  String masterKey =
      '<YOUR MASTER KEY(Cosmos DB)>';
  String keyType = "master";
  String tokenVersion = "1.0";
  final String resourceId;

  GenerateAuthToken({this.verb, this.resourceType, this.resourceId});

  Map<String,String> createToken() {

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
    String base64 = CryptoUtils.bytesToBase64(digest.bytes);
    String authToken = Uri.encodeComponent('type='+ keyType + '&ver=' + tokenVersion + '&sig=' + base64);
    return {'authToken':authToken,'date':date};

  }
}
