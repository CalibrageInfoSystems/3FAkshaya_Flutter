import 'dart:convert';

import 'package:akshayaflutter/model_class/FarmerDetails_Model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SharedPreferencesHelper.dart';

class homepage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<homepage> {
  int _currentIndex = 0;

 Farmer? catagoriesList; // Declare as nullable
 String? farmername;
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
      final categoriesDetails = loadedData['result']['categoriesDetails'];

// Now you can access individual properties within these arrays if needed
      final farmerId = farmerDetails[0]['id'];
      final farmerName = farmerDetails[0]['firstName'];

// Similarly, for categoriesDetails
      final category1Name = categoriesDetails[0]['name'];
      final category2Name = categoriesDetails[1]['name'];
      print('farmerName==$farmerName');
      print('category1Name==$category1Name');
      print('category2Name==$category2Name');
     // catagoriesList =
    } else {
      // No data found in SharedPreferences
      print('No data found in SharedPreferences');

    }
  }

  Widget buildPart1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.home, size: 48),
        Text('Home'),
        Icon(Icons.business, size: 48),
        Text('Business'),
        Icon(Icons.school, size: 48),
        Text('School'),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Four Parts App'),
      ),

      body: Column(
    children: [
    Expanded(
    flex: 2,
      child: Container(
        color: Colors.blue,
        child: _currentIndex == 0 ? buildPart1() : null,
      ),
    ),
    Expanded(
    flex: 2,
    child: Container(
    color: Colors.green,
    child: _currentIndex == 1 ? buildPart2And3() : null,
    ),
    ),
    Expanded(
    flex: 2,
    child: Container(
    color: Colors.orange,
    child: _currentIndex == 2 ? buildPart2And3() : null,
    ),
    ),
    Expanded(
    flex: 2,
    child: Container(
    color: Colors.red,
    child: _currentIndex == 3 ? buildPart1() : null,
    ),
    ),
    ],
    ),
      drawer: Drawer(
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
            InkWell(
              onTap: () {
                // Add your click listener logic here
                _loadFarmerResponse();

                print('Name: ${farmername}');
                print('Text Clicked');
              },
              child: Text(
                'Full Name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline, // Optional: Add underline for clickable text
                ),
              ),
            )
,
            Text(
              'Mobile Number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Address',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
              'assets/ic_home.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,

            ),
              title: Text('Home'),
              onTap: () {
                _loadFarmerResponse();
                // Implement the action when the Home item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Implement the action when the Profile item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('My3F'),
              onTap: () {
                // Implement the action when the My3F item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.request_page),
              title: Text('Requests'),
              onTap: () {
                // Implement the action when the Requests item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Care'),
              onTap: () {
                // Implement the action when the Care item is tapped
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
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
        selectedLabelStyle: TextStyle(color: Color(0xFFe86100)), // Set the selected label text color to blue

      ),
    );
  }

  Widget buildPart2And3() {
    // Replace this with your actual data
    List<Map<String, dynamic>> data = [
      {'icon': Icons.star, 'text': 'Item 1'},
      {'icon': Icons.favorite, 'text': 'Item 2'},
      {'icon': Icons.music_note, 'text': 'Item 3'},
      // Add more items as needed
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0, // Adjust this as needed for your item size
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data[index]['icon'], size: 48),
            Text(data[index]['text']),
          ],
        );
      },
    );
  }


}

