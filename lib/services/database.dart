// import 'dart:io';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http_parser/http_parser.dart';

//Access to firebase
class DatabaseMethods {
  static Future<void> addUserDetails(
      Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  static Future addProducts(
      Map<String, dynamic> userInfoMap, String categoryname) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  static Future<Stream<QuerySnapshot>> getProducts(String categoryname) async {
    return FirebaseFirestore.instance.collection(categoryname).snapshots();
  }
}


// //Access to Mongodb
// class MOngoDatabase {
//   static Future uploadToMongo(String name, String category, File image) async {
//     final bytes = image.readAsBytesSync();
//     final base64Image = base64Encode(bytes);
//     final uri = Uri.parse(
//         "www:localhost/backend-url");
//     final res = await http.post(
//       uri,
//       headers: {"Content-Type": "application/json"},
//       body: json.encode({
//         "name": name,
//         "category": category,
//         "image": base64Image,
//       }),
//     );
//     return res;
//   }
// }
