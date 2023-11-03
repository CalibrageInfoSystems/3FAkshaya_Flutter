import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class care extends StatefulWidget {
  @override
  _careState createState() => _careState();
}

class _careState extends State<care> {
  // int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    launchPhoneDialer('04023324733');
  }

  void launchPhoneDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the case where the user's device does not support phone calls or the URL cannot be launched.
      // You can show an error message or take another action.
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text('Navigating to dialer...'),
      ),
    );
  }
}

