import 'package:akshayaflutter/model_class/FarmerDetails_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SharedPreferencesHelper {
  static const String FARMER_DATA = '3fFarmerdata_data';
  static const String CataGories = 'categories';

  static Future<void> putBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

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

