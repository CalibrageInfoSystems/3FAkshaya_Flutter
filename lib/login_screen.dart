import 'dart:convert';
import 'package:akshayaflutter/Otp_Screen.dart';
import 'package:akshayaflutter/model_class/login_model_class.dart';
import 'package:akshayaflutter/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CommonUtils/Commonclass.dart';

class login extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<login> {
  TextEditingController _farmercodeController = TextEditingController();
  String farmercode = "";
  List<loginmodel> loginlist = [];
  bool isLoading = true;
  String? farmerMobileNumber;

  Future<loginmodel?> _onSubmit() async {
    farmercode = _farmercodeController.text;
    print("Entered text: $farmercode");
    farmerlogin(farmercode);
  }

  @override
  void dispose() {
    _farmercodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Image.asset(
                'assets/appbg.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                color: Color(0x8D000000),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/ic_user.png',
                        width: 200,
                        height: 150,
                      ),
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Color(0xFFFAF5F5F5),
                        fontSize: 25,
                        fontFamily: 'hind_semibold',
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                          top: 22.0, left: 22.0, right: 22.0),
                      child: TextFormField(
                        controller: _farmercodeController,
                        decoration: InputDecoration(
                          hintText: 'Enter Farmer Id',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .white, // Set the border line color to white
                            ),
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the border radius
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .white, // Set the border line color to white
                            ),
                            borderRadius: BorderRadius.circular(
                                10.0),
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xCBBEBEBE),
                            fontFamily: 'hind_semibold',
                            fontSize: 20, // Set the font size to 20
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          // Add padding to center the hint text
                          alignLabelWithHint:
                              true, // Center-align the hint text
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,

                          fontFamily: 'hind_semibold',

                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 22.0,
                          left: 22.0,
                          right: 22.0),
                      child: Container(
                        width: double.infinity,

                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFCCCCCC),
                              Color(0xFFFFFFFF),
                              Color(0xFFCCCCCC),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          // Adjust the border radius as needed
                          border: Border.all(
                            width: 2.0,
                            color: Color(0xFFe86100), // Your stroke color
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            bool validationSuccess = await isvalidations();
                            if (validationSuccess) {
                              _onSubmit();
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFFe86100),
                              fontSize: 16,
                              fontFamily: 'hind_semibold',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 22.0, right: 22.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFCCCCCC),
                              Color(0xFFFFFFFF),
                              Color(0xFFCCCCCC),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 2.0,
                            color: Color(0xFFe86100),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _scanQR();
                          },
                          child: Text(
                            'Scan QR',
                            style: TextStyle(
                              color: Color(0xFFe86100),
                              fontSize: 16,
                              fontFamily: 'hind_semibold',
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            elevation: 0,
                             shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Other Buttons
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _scanQR() async {
    // Request camera permission
    var status = await Permission.camera.request();
    if (status.isGranted) {
      try {
        String? cameraScanResult = await scanner.scan();
        setState(() {
          if (cameraScanResult != null) {
            _farmercodeController.text = cameraScanResult;
          }
        });
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      // Handle permission denied
      setState(() {
        _farmercodeController.text = "Camera permission denied";
      });
    }
  }

  Future<loginmodel?> farmerlogin(String fc) async {
    loginlist.clear();

    final url = Uri.parse(baseUrl + getfarmerlogin + "$fc" + "/null");
    print('farmerloginurl>>$url');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('==response$responseData');

        if (responseData["isSuccess"]) {
          print("Farmer Details added successfully.");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          String Farmercode = farmercode;

          farmerMobileNumber = responseData['result'];
          prefs.setString('result', farmerMobileNumber!);

          print('farmer_mobilenum==$farmerMobileNumber');
          // Replace with the actual user ID
          print('Farmercode==$Farmercode');
          prefs.setString('Farmercode', Farmercode); // Save the user ID
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Otp_screen(Farmercode: farmercode, farmerMobileNumber!),
              ));
        } else {
          print("Error: ${responseData["endUserMessage"]}");
          if (responseData["endUserMessage"] == "OTP Sent") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Otp_screen(Farmercode: farmercode, farmerMobileNumber!),
                ));
          } else {
            showCustomToastMessageLong(
                "${responseData["endUserMessage"]}", context, 1, 4);
          }
        }
      } else {
        throw Exception('Failed to Farmer list');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API$error');
    }
    return null;
  }

  Future<bool> isvalidations() async {
    bool isValid = true;

    if (_farmercodeController.text.isEmpty) {
      showCustomToastMessageLong('Please Enter Farmer Id', context, 1, 4);
      isValid = false;
    }
    return isValid; // Return true if validation is successful, false otherwise
  }
}
