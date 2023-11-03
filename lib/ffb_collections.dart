import 'dart:convert';

import 'package:akshayaflutter/SharedPreferencesHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'model_class/CollectionResponse.dart';
import 'model_class/FarmerDetails_Model.dart';

class ffb_collections extends StatefulWidget {
  @override
  _ffb_collectionsState createState() => _ffb_collectionsState();
}

class _ffb_collectionsState extends State<ffb_collections> {
  String? selectedValue,
      startDateString,
      fc,
      endDateString,
      totalcollections,
      totalnetweight,
      unpaidcollections,
      paidcollections; // Declare selectedValue as a nullable String
  List<dynamic> dropdownItems = [];
  int? selectedPosition;
  Farmer? catagoriesList;
   //final url,request;
  @override
  void initState() {
    // TODO: implement initState
    callApiMethod(selectedPosition!);
    get30days();
    listofdetails();
    super.initState();

  }
  CollectionResponse parseCollectionResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    print('parsed$parsed');
    return CollectionResponse.fromJson(parsed);
  }



  listofdetails() async {
    final loadedData = await SharedPreferencesHelper.getCategories();
    if (loadedData != null) {
      final farmerDetails = loadedData['result']['farmerDetails'];
      final loadedfarmercode = farmerDetails[0]['code'];
      setState(() {
        fc = loadedfarmercode;
        print('fcinplotdetails--$fc');
      });
    }
  }

  void callApiMethod(int position) async{
    // Implement your API call logic here
    if (position == 0) {
      // Calculate the date range for the "Last 30 Days" option
      DateTime currentDate = DateTime.now();
      DateTime startDate = currentDate.subtract(Duration(days: 100));
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      startDateString = dateFormat.format(startDate);
      endDateString = dateFormat.format(currentDate);
      print('Start Date: $startDateString');
      print('End Date: $endDateString');
      get30days();
    } else {
      // Handle other dropdown positions
      print('Selected position: $position');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FFB Collections"),
          leading: IconButton(
            icon: Image.asset('assets/ic_left.png'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [1.0, 0.4],
                colors: [Color(0xFFDB5D4B), Color(0xFFE39A63)],
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            // Wrap the contents in a Column
            children: [
              Container(
                width: double.infinity,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: DropdownButton<int>(
                          value: selectedPosition ?? 0,
                          iconSize: 22,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (position) {
                            setState(() {
                              selectedPosition = position;
                              print('selectedposition $selectedPosition');
                            });

                            // Now, call your API method based on the selected position
                            callApiMethod(selectedPosition!);
                          },
                          items: [
                            DropdownMenuItem<int>(
                              value: 0,
                              child: Text('Last 30 Days'),
                            ),
                            DropdownMenuItem<int>(
                              value: 1,
                              child: Text('Current Financial Year'),
                            ),
                            DropdownMenuItem<int>(
                              value: 2,
                              child: Text('Select Time Period'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              // Add the Row below the dropdown
              Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x8D000000), // Background color
                        borderRadius:
                            BorderRadius.circular(20.0), // Circular radius
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(8, 10, 12, 0),
                                      child: Text(
                                        "Total Collections",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        ":",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        '$totalcollections',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(8, 10, 12, 0),
                                      child: Text(
                                        "Total Net Weight",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        ":",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        '$totalnetweight',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                                      child: Text(
                                        "Unapid Collections Weight",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                                      child: Text(
                                        ":",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      child: Text(
                                        '$unpaidcollections',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(8, 10, 12, 5),
                                      child: Text(
                                        "Paid Collections Weight",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Text(
                                        ":",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      child: Text(
                                        '$paidcollections',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'hind_semibold',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )))
            ],
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.021, 0.144, 0.3444, 0.2],
              colors: [
                Color(0xFFDB5D4B),
                Color(0xFFE39A63),
                Color(0xFFE39A63),
                Color(0xFFFFFFF)
              ],
            ),
          ),
        ));
  }
  Future<void> get30days() async {
    final url = Uri.parse(baseUrl + getcollection);
    print('url==>890: $url');
    final request = {
      "farmerCode": fc,
      "fromDate": startDateString,
      "toDate": endDateString
    };
    print('request of the 30 days: $request');
    try {
      final response = await http.post(
        url,
        body: json.encode(request),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('responseData: $responseData');
        if (responseData['result'] != null) {
          List<Collection> collections = (responseData['result']['collectioData'] as List)
              .map((item) => Collection.fromJson(item))
              .toList();
          CollectionCount collectionCount = CollectionCount.fromJson(
              responseData['result']['collectionCount'][0]);

          // Now, you can access the data within collections and collectionCount
          for (Collection collection in collections) {
            print('uColnid: ${collection.uColnid}');
            // Access other properties as needed
          }
          // print('Collections Weight: ${collectionCount.collectionsWeight}');
          // print('Collections Count: ${collectionCount.collectionsCount}');
          // print('Paid Collections Weight: ${collectionCount.paidCollectionsWeight}');
          // print('Unpaid Collections Weight: ${collectionCount.unPaidCollectionsWeight}');
          totalcollections = '${collectionCount.collectionsWeight}';
          totalnetweight='${collectionCount.collectionsCount}';
          paidcollections ='${collectionCount.paidCollectionsWeight}';
          unpaidcollections =' ${collectionCount.unPaidCollectionsWeight}';
          print('totalcollections-$totalcollections');
          print('totalnetweight-$totalnetweight');
          print('paidcollections-$paidcollections');print('unpaidcollections-$unpaidcollections');

        } else {
          print('Request was not successful');
        }
      } else {
        print('Failed to send the request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }



    // await fetchData();
  }
// Define the fetchData method outside of get30days
//   Future<void> fetchData() async {
//
//   }



}
