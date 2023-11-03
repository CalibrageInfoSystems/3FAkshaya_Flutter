import 'dart:convert';
import 'package:akshayaflutter/CustomVectorWidget.dart';
import 'package:akshayaflutter/My3F.dart';
import 'package:akshayaflutter/care.dart';
import 'package:akshayaflutter/home_page.dart';
import 'package:akshayaflutter/profile.dart';
import 'CustomVectorWidget.dart';
import 'CustomVectorWidget.dart';
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


  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _loadFarmerResponse();

    super.initState();
  }


  void _loadFarmerResponse() async {
    final loadedData = await SharedPreferencesHelper.getCategories();

    if (loadedData != null) {
      final farmerDetails = loadedData['result']['farmerDetails'];
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

      print('No data found in SharedPreferences');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('3F Akshaya'),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     gradient: MyPainter().getGradient(), // Call your method to get the gradient
        //   ),
        // ),
          elevation: 0,

        flexibleSpace: Stack(
          children: [
            Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [Color(0xFFe56d5d),Color(0xFFe56d5d),
                ],
              ),
            ),
           ),
          ],
        ),

      ),
     // extendBodyBehindAppBar: true,
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
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
                   fit: BoxFit.fill,
                 ),
             ),
            )
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$farmerName',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'hind_semibold',
                    color: Colors.white,
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$address1',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: 'hind_semibold',
                    fontWeight: FontWeight.bold,
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
                  ),
                ),
              ],
            ),

        Container(
          height: 2.0,
          width: 10.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF4500),
                Color(0xFFA678EF),
                Color(0xFFFF4500),
              ],
              begin: Alignment.topLeft,
              end: Alignment.center,
            ),
          ),
        ),
            ListTile(
              leading: SvgPicture.asset(
              'assets/ic_home.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
                color: Colors.white,
            ),
              title: Text('Home', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/ic_home.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.white,

              ),
              title: Text('Choose Language', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/ic_myprofile.svg',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
              title: Text('Profile', style: TextStyle(
                color:Colors.white,
                //   fontSize: 16,
                fontFamily: 'hind_semibold',
              ),),
              onTap: () {
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
                fit: BoxFit.fill,
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
        return ProfilePage();
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
class MyPainter extends CustomPainter {
  LinearGradient getGradient() {
    return LinearGradient(
      colors: [
        Color(0xFFe56d5d),
       Color(0xFFe49e64),
      Color(0xFFE39A63),
      ],
      //begin: Alignment.topCenter, // You can adjust the start and end points as needed
     // end: Alignment.bottomCenter,
      // begin: Alignment(0, 0),
      // end: Alignment(0, 1),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    final paint = Paint()
      ..shader = getGradient().createShader(
        Rect.fromPoints(Offset(0, 0), Offset(0, size.height)),
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
