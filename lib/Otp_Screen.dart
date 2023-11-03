import 'dart:convert';

import 'package:akshayaflutter/SharedPreferencesHelper.dart';
import 'package:akshayaflutter/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:akshayaflutter/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sms_autofill/sms_autofill.dart';

import 'CommonUtils/Commonclass.dart';
import 'CommonUtils/Constants.dart';
import 'api_config.dart';
import 'model_class/FarmerDetails_Model.dart';
import 'model_class/login_model_class.dart';

class Otp_screen extends StatefulWidget{
  final String Farmercode;
  final String farmermobilenumber;


  Otp_screen( this.farmermobilenumber, {required this.Farmercode});
  @override
  _otpScreenState createState() => _otpScreenState();
}

class _otpScreenState extends State<Otp_screen> {

  late String newNumber="";
   String enteredOTP='';
   List<Farmer> otplist = [];
  @override
  void initState() {
    super.initState();
    //enteredOTP = "";
    newNumber=widget.farmermobilenumber;
    List<String> numbers = newNumber.split(',');
    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i].length >= 6) {
        String hiddenPart = numbers[i].substring(6);
        String asterisks = '*' * 6;
        String replacedNumber = asterisks + hiddenPart;
        numbers[i] = replacedNumber;
      }
    }
    newNumber = numbers.join(', ');
    print("PHONE_NUMBER_HIDDEN: $newNumber");
    print("FinalNumber:$newNumber");
    print('Farmercodeotp_screen>>${widget.Farmercode}');
    print('Farmermobilenumotp_screen>>${widget.farmermobilenumber}');
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
              Container(
                color: Color(0x8D000000),
              ),
              Container(
                child: Column(
                  children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 80.0),
                        child: Text(
                          'Enter the 6 Digits Code Sent your Registered',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 0.0),
                      child:  Text(
                          'Mobile Number(s) $newNumber',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        ) ],
                    ),

                    SizedBox(height: 15.0),
                    OtpTextField(
                      numberOfFields: 6,
                      textStyle: TextStyle(color: Color(0xFFFFFFFF)),
                      fillColor: Colors.white.withOpacity(0.0),
                      filled: true,
                      onSubmit: (String otp) {
                        // Update the corresponding stringotp variables

                          enteredOTP = otp;
                          print('Concatenated OTP: $enteredOTP');





                      },

                    )

                    ,

                    SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 22.0, right: 22.0),
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
                          onPressed: () async {
                            // Submit button logic
                            // bool validationSuccess = await isvalidations();
                            // if( validationSuccess){
                            //   getOtp(enteredOTP);
                            // }

                            getOtp(enteredOTP);





                          },
                          child: Text(
                            'SUBMIT',
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
                      padding: EdgeInsets.only(top: 20.0, right: 28.0), // Add padding to the right
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Implement your logic for resending OTP here
                            farmerlogin(widget.Farmercode);
                            print('RESEND OTP clicked');
                            // Add code to resend OTP
                          },
                          child: Text(
                            'RESEND OTP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

   Future<Farmer?> getOtp(String otp) async {
     otplist.clear();
     final url = Uri.parse(baseUrl + getfarmerotp + widget.Farmercode + "/" + otp);
     print('farmerotpurl>>$url');
     try {
       final response = await http.get(url);
       if (response.statusCode == 200) {
         final Map<String, dynamic>? responseData = jsonDecode(response.body);
         print('==response$responseData');

         if (responseData != null && responseData.containsKey("isSuccess") && responseData["isSuccess"]) {
           print("Farmer Otp Sented successfully.");
           await SharedPreferencesHelper.saveCategories(responseData);
           SharedPreferencesHelper.putBool(Constants.IS_LOGIN, true);
           Navigator.push(context, MaterialPageRoute(builder: (context) => homepage(),));
           // Parse the JSON response into a Farmer object
           Farmer farmer = Farmer.fromJson(responseData);
           SharedPreferences prefs            = await SharedPreferences.getInstance();

           // Save the Farmer object to SharedPreferences

           final loadedData = await SharedPreferencesHelper.getCategories();
           print('loadedData==$loadedData');
           String Farmercode = widget.Farmercode; // Replace with the actual user ID
           print('Farmercode==$Farmercode');
           prefs.setString('Farmercode', Farmercode); // Save the user ID

         }

         else if (responseData != null && responseData.containsKey("endUserMessage")) {
           print("Error: ${responseData["endUserMessage"]}");
           if (responseData["endUserMessage"] == "OTP Validated") {
             // Navigator.push(context, MaterialPageRoute(builder: (context) => Otp_screen(Farmercode: farmercode),));
             Navigator.push(context, MaterialPageRoute(builder: (context) => homepage(),));
           } else {
             showCustomToastMessageLong("${responseData["endUserMessage"]}", context, 1, 4);
           }
         } else {
           print("Error: Unexpected response format");
         }
       } else {
         throw Exception('Failed to fetch Farmer data');
       }
     } catch (error) {
       throw Exception('Failed to connect to the API: $error');
     }

     return null;
   }

   Future<loginmodel?> farmerlogin(String fc) async{
     otplist.clear();
     final url = Uri.parse(baseUrl+getfarmerlogin +"$fc"+ "/null");
     print('farmerloginurl>>$url');
     try {
       final response = await http.get(url);
       if (response.statusCode == 200) {
         final Map<String, dynamic> responseData = jsonDecode(response.body);
         print('==response$responseData');

         if (responseData["isSuccess"]) {
           print("Farmer Details added successfully.");
           // SharedPreferences prefs = await SharedPreferences.getInstance();
           // prefs.setBool('isLoggedIn', true);
           // String farmercode = Farmercode ; // Replace with the actual user ID
           // print('Farmercode==$farmercode');
           // prefs.setString('Farmercode', farmercode); // Save the user ID
           // Navigator.push(context, MaterialPageRoute(builder: (context) => Otp_screen(Farmercode: farmercode),));
         } else {
           print("Error: ${responseData["endUserMessage"]}");
           // if(responseData["endUserMessage"] == "OTP Sent"){
           //   Navigator.push(context, MaterialPageRoute(builder: (context) => Otp_screen(Farmercode: farmercode),));
           // }
           // else{
           //   showCustomToastMessageLong("${responseData["endUserMessage"]}", context, 1, 4);
           // }

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

     if (enteredOTP!=null) {
       showCustomToastMessageLong('Please Enter OTP', context, 1, 4);
       isValid = false;
     }
     return isValid; // Return true if validation is successful, false otherwise
   }
}
