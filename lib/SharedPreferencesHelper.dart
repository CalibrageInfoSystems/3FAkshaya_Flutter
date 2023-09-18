import 'package:akshayaflutter/model_class/FarmerDetails_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SharedPreferencesHelper {
  static const String CHURCH_DATA = 'church_data';
  static const String CataGories = 'categories';

  static Future<void> saveCategories(Farmer farmerModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = farmerModel.toJson(); // Assuming you have a toJson method in your model
    if (prefs != null) {
      final jsonString = jsonEncode(json); // Encode the farmerModel instead
      await prefs.setString(CataGories, jsonString);
      print('Model class saved to SharedPreferences: $jsonString'); // Add this print statement

    }
  }
}

