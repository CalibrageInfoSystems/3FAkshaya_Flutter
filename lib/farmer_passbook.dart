



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class farmerpassbook extends StatefulWidget {
  @override
  _farmerpassbook createState() => _farmerpassbook();
}

class _farmerpassbook extends State<farmerpassbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFDB5D4B),
        title: Text("Farmer Passbook"),
        leading: IconButton(
          icon: Image.asset('assets/ic_left.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 450,
          child: Card(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image.asset('assets/ic_bank_white.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text("Your Card Content Here"),
                ),
              ],
            ),
          ),
        ),
      )

    );
  }



}