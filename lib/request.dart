import 'dart:convert';

import 'package:akshayaflutter/api_config.dart';
import 'package:akshayaflutter/model_class/Service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class request extends StatefulWidget {
  @override
  _requestState createState() => _requestState();
}

class _requestState extends State<request> {
  List<Service> Service_list = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getservicedetails('AP');
  }

  Future<Service?> getservicedetails(String sc) async {
    final url = Uri.parse(baseUrl + getServicesByStateCode + sc);
    print('$url');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('response==$responseData');
        final List<dynamic> appointmentsData = responseData['listResult'];
        setState(() {
          Service_list = appointmentsData
              .map((appointment) => Service.fromJson(appointment))
              .toList();
        });
        print('Service_list---${Service_list.length}');
      } else {
        throw Exception('Failed to show Service details list');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API $error');
    }
    return null;
  }

  Widget buildServiceImage(int serviceTypeId) {
    switch (serviceTypeId) {
      case 11:
        return Image.asset('assets/labour.png');
      case 12:
        return Image.asset('assets/fertilizers.png');
      case 10:
        return Image.asset('assets/equipment.png');
      case 13:
        return Image.asset('assets/quick_pay.png');
      case 14:
        return Image.asset('assets/visit.png');
      case 28:
        return Image.asset('assets/loan.png');
      case 107:
        return Image.asset(
            'assets/fertilizers.png'); // Change the image as needed
      default:
        return Image.asset(
            'assets/labour.png'); // A default image for unknown service types
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: Service_list.length,
              itemBuilder: (context, index) {
                final service = Service_list[index];
                return Container(
                  height: 70, // Set the desired height for each card
                  child: Card(
                    // margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Left side: Image based on service type
                          buildServiceImage(service.serviceTypeId),
                          // Use serviceTypeId from the API response
                          SizedBox(width: 16),
                          // Add some spacing between the image and text
                          // Right side: Text based on service type
                          Expanded(
                            child: Text(
                              service.serviceType,
                              // Use serviceTypeId from the API response
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
