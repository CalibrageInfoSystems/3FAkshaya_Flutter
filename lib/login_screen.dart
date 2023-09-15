import 'dart:convert';
import 'package:akshayaflutter/model_class/login_model_class.dart';
import 'package:akshayaflutter/api_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
class login extends StatefulWidget{
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<login> {
  TextEditingController _farmercodeController = TextEditingController();
  String farmercode ="";
  List<loginmodel> loginlist = [];
  bool isLoading = true;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //
  //   String farmercode = _farmercodeController.text;
  //   print('loginscreenfarmercode$farmercode');
  //   super.initState();
  // }
  void _onSubmit() {
    // Access the entered text
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
              // Background Image
              Image.asset(
                'assets/appbg.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              // Background Color with Opacity
              Container(
                color: Color(0x8D000000),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 170.0), // Adjust the top padding as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // Align children to the start (top) of the column
                  children: [
                    // User Icon
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/ic_user.png',
                        width: 200,
                        height: 150,
                      ),
                    ),
                    // Text
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Color(0xFFFAF5F5F5),
                        fontSize: 25,
                        fontFamily: 'hind_semibold',
                      ),
                    ),

                    // Text Form Field
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0,left: 22.0,right: 22.0),
                      child: TextFormField(
                        controller: _farmercodeController,
                        decoration: InputDecoration(
                          hintText: 'Enter Farmer Id',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white, // Set the border line color to white
                            ),
                            borderRadius: BorderRadius.circular(10.0), // Set the border radius
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white, // Set the border line color to white
                            ),
                            borderRadius: BorderRadius.circular(10.0), // Set the border radius
                          ),
                          hintStyle: TextStyle(
                            color: Color(0xCBBEBEBE), // Set the hint text color to CBBEBEBE
                            fontFamily: 'hind_semibold',
                            fontSize: 20, // Set the font size to 20
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15), // Add padding to center the hint text
                          alignLabelWithHint: true, // Center-align the hint text
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                          fontFamily: 'hind_semibold', // You can set the font family here if needed
                          fontSize: 20, // You can set the font size here if needed
                        ),
                      ),
                    ),




                    // Button below TextFormField

                    Padding(
                      padding: const EdgeInsets.only(top: 22.0,left: 22.0,right: 22.0), // Add padding to the buttons
                      child: Container(
                        width: double.infinity, // Make the Container expand horizontally
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFCCCCCC), // Start color
                              Color(0xFFFFFFFF), // Center color
                              Color(0xFFCCCCCC), // End color
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                          border: Border.all(
                            width: 2.0,
                            color: Color(0xFFe86100), // Your stroke color
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _onSubmit();
                          farmerlogin(farmercode);

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
                            primary: Colors.transparent, // Set the button's background color to transparent
                            elevation: 0, // Remove the button's elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Match the border radius in the BoxDecoration
                            ),
                          ),
                        ),
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child:  Container(
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
                      padding: const EdgeInsets.only(top: 10.0,left: 22.0,right: 22.0), // Add padding to the buttons
                      child: Container(
                        width: double.infinity, // Make the Container expand horizontally
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFCCCCCC), // Start color
                              Color(0xFFFFFFFF), // Center color
                              Color(0xFFCCCCCC), // End color
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                          border: Border.all(
                            width: 2.0,
                            color: Color(0xFFe86100), // Your stroke color
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
                            primary: Colors.transparent, // Set the button's background color to transparent
                            elevation: 0, // Remove the button's elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Match the border radius in the BoxDecoration
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Other Buttons
                    // You can add other buttons here if needed.
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

  void farmerlogin(String fc) async{
loginlist.clear();
final url = Uri.parse(baseUrl+getfarmerlogin +"$fc"+ "/null");
print('farmerloginurl>>$url');
try {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    if (responseData['ListResult'] != null) {
      final List<dynamic> logindata = responseData['ListResult'];
      setState(() {
        loginlist = logindata
            .map((loginlistdata) => loginmodel.fromJson(loginlistdata))
            .toList();

      });
      print('Send OTP');
    } else {


//      print('$loginmodel');
    }
  } else {
    throw Exception('Failed to Farmer list');
  }
} catch (error) {
  throw Exception('Failed to connect to the API');
}

  }
}


