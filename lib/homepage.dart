import 'dart:convert';
import 'package:akshayaflutter/My3F.dart';
import 'package:akshayaflutter/care.dart';
import 'package:akshayaflutter/home_page.dart';
import 'package:akshayaflutter/profile.dart';
import 'request.dart';
import 'package:akshayaflutter/model_class/FarmerDetails_Model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SharedPreferencesHelper.dart';

class homepage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<homepage> {
  int _currentIndex = 0;

 Farmer? catagoriesList; // Declare as nullable
  String? farmerName;
  String? farmerlastname;
  String? farmermobilenum;
  String? farmerMutliplemobilenum;
  String? address1;
  String? address2;


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _loadFarmerResponse();
    // Check if the farmerresponse is not null
    super.initState();
  }


  void _loadFarmerResponse() async {
    final loadedData = await SharedPreferencesHelper.getCategories();

    if (loadedData != null) {
      final farmerDetails = loadedData['result']['farmerDetails'];

      // Assuming you want to get the name of the first farmer in the list
      final loadedFarmerName = farmerDetails[0]['firstName'];
      final loadedlastFarmerName = farmerDetails[0]['lastName'];
      final loadedMobilenum = farmerDetails[0]['contactNumber'];
      final loadedmutipleMobilenum = farmerDetails[0]['contactNumbers'];
      final loadedaddress1 = farmerDetails[0]['addressLine1'];
      final loadedaddress2 = farmerDetails[0]['addressLine2'];
      setState(() {
        farmerName = loadedFarmerName;
        farmerlastname =loadedlastFarmerName;
        farmermobilenum =loadedMobilenum;
        farmerMutliplemobilenum= loadedmutipleMobilenum;
        address1 =loadedaddress1;
        address2 =loadedaddress2;
      });

      print('farmerName==$farmerName');
      print('Text Clicked');
    } else {
      // No data found in SharedPreferences
      print('No data found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('3F Akshaya'),
      ),


      drawer: Drawer(

        backgroundColor: Colors.black,
        child: ListView(
          children: [

            DrawerHeader(
              // child: Text('Side Navigation'),
             child: Container(
               width: 120.0,
               height: 120.0,
               decoration: BoxDecoration(
                 shape: BoxShape.circle,

               ),
               child: CircleAvatar(
                 backgroundColor: Colors.transparent,
                 child: Image.asset(
                   'assets/ic_user.png',
                   fit: BoxFit.fill, // You can adjust the BoxFit as per your preference
                 ),
               ),
             )

            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Adjust the alignment as needed
              children: [
                Text(
                  '$farmerName',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'hind_semibold',
                    color: Colors.white,
                    //decoration: TextDecoration.underline, // Optional: Add underline for clickable text
                  ),
                ),
                SizedBox(width: 10.0,),
                Text(
                  '$farmerlastname',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: 'hind_semibold',
                    fontWeight: FontWeight.bold,
                   // decoration: TextDecoration.underline, // Optional: Add underline for clickable text
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0,),

            // Text(
            //   '$farmermobilenum',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Adjust the alignment as needed
              children: [
                Text(
                  '$address1',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: 'hind_semibold',
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline, // Optional: Add underline for clickable text
                  ),
                ),
                SizedBox(width: 10.0,),
                Text(
                  '$address2',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: 'hind_semibold',
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline, // Optional: Add underline for clickable text
                  ),
                ),
              ],
            ),
      // Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         Color(0xFFFF4500), // Start color
      //         Colors.red,         // Middle color (same as the start color)
      //         Color(0xFFFA678E), // End color
      //       ],
      //       stops: [0.0, 0.5, 1.0],
      //       begin: Alignment.centerLeft,
      //       end: Alignment.centerRight,
      //     ),
      //   ),),

            SizedBox(height: 20.0,),
            ListTile(
              leading: SvgPicture.asset(
              'assets/ic_home.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
                color: Colors.white, // Set the icon color to white

            ),
              title: Text('Home', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {
                _loadFarmerResponse();
                // Implement the action when the Home item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/ic_home.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.white, // Set the icon color to white

              ),
              title: Text('Choose Language', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {
                // Implement the action when the Profile item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/ic_myprofile.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.white, // Set the icon color to white

              ),
              title: Text('Profile', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {
                // Implement the action when the My3F item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/ic_request.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.white, // Set the icon color to white

              ),
              title: Text('Request', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {
                // Implement the action when the My3F item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),

            ListTile(
              leading: SvgPicture.asset(
                'assets/ic_my.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.white, // Set the icon color to white

              ),
              title: Text('My3F',
                style: TextStyle(
                  color:Colors.white,
               //   fontSize: 16,
                  fontFamily: 'hind_semibold',
                ),),
              onTap: () {
                // Implement the action when the Requests item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/ic_home.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.white, // Set the icon color to white

              ),
              title: Text('Logout', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {
                // Implement the action when the Care item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),

      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/ic_home.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: _currentIndex == 0 ? Color(0xFFe86100): null,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/ic_myprofile.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: _currentIndex == 1 ? Color(0xFFe86100): null,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/ic_my.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: _currentIndex == 2 ? Color(0xFFe86100): null,
            ),
            label: 'My3F',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/ic_request.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: _currentIndex == 3 ? Color(0xFFe86100): null,
            ),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/ic_care.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: _currentIndex == 4 ? Color(0xFFe86100): null,
            ),
            label: 'Care',
          ),
        ],
        selectedItemColor: Color(0xFFe86100), // Color for selected items

      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return home_page();
      case 1:
        return profile();
      case 2:
        return My3f();
      case 3:
        return request();
      case 4:
        return care();
      default:
        return Container();
    }
  }

}

