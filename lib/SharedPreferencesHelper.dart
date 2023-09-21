import 'package:akshayaflutter/model_class/FarmerDetails_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SharedPreferencesHelper {
  static const String CHURCH_DATA = 'church_data';
  static const String CataGories = 'categories';

  // static Future<void> saveCategories(Farmer farmerModel) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final json = farmerModel.toJson(); // Assuming you have a toJson method in your model
  //   if (prefs != null) {
  //     final jsonString = jsonEncode(json); // Encode the farmerModel instead
  //     await prefs.setString(CataGories, jsonString);
  //     print('Model class saved to SharedPreferences: $jsonString'); // Add this print statement
  //
  //   }
  // }

  static Future<void> saveCategories(Map<String, dynamic> jsonResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(jsonResponse);
    await prefs.setString('response_key', jsonString); // Replace 'response_key' with your desired key
    print('Response saved to SharedPreferences: $jsonString');
  }

  static Future<Map<String, dynamic>?> getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('response_key'); // Replace 'response_key' with your desired key
    if (jsonString != null && jsonString.isNotEmpty) {
      final jsonMap = jsonDecode(jsonString);
      return jsonMap;
    } else {
      return null; // Return null if no data is found
    }
  }
  // Define a method to load the Farmer model from SharedPreferences
  // static Future<Farmer?> getCategories() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final jsonString = prefs.getString(CataGories);
  //
  //   if (jsonString != null && jsonString.isNotEmpty) {
  //     final jsonMap = jsonDecode(jsonString);
  //     final farmerModel = Farmer.fromJson(jsonMap); // Assuming you have a fromJson method in your model
  //     return farmerModel;
  //   } else {
  //     return null; // Return null if no data is found
  //   }
  // }
}

