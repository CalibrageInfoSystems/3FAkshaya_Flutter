import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:akshayaflutter/model_class/Contact_tinfo.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'api_config.dart';
import 'model_class/3finfo_model.dart';

class My3f extends StatefulWidget {
  @override
  _my3fState createState() => _my3fState();
}

class _my3fState extends State<My3f> {
  late WebViewController _controller;
  bool isLoading = false;
  String htmlContent = "";
  late Uri dataUri;
  List<Contactinfo> contacts_infolist = [];
  final String mimeType = "text/html";
  final String encoding = "UTF-8";
   late String Wedviewapi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Wedviewapi = "";

    dataUri = Uri.dataFromString(Wedviewapi!,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getcontactinfodetails('APWGBDAB00010001', 'AP');
    getimpcontactdetails('APWGBDAB00010001', 'AP');
  }

  Future<Contactinfo?> getcontactinfodetails(String fc, String sc) async {
    final url = Uri.parse(baseUrl + getContactInfo + fc + "/" + sc);
    print('Contactinfoapi-$url');
    String? wedviewapi;
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Request isSuccess $jsonData');

        if (jsonData["isSuccess"]) {
          print('itisisSuccess');

          if (jsonData['listResult'] != null) {
            print('itisListResult');

            List<Contactinfo> contactinfo = [];
            for (var item in jsonData['listResult']) {
              print('itisContactinfo');

              contactinfo.add(Contactinfo(
                id: item['id'],
                description: item['description'],
                contactInfo: item['contactInfo'],
                createdByUserId: item['createdByUserId'],
                createdDate: DateTime.tryParse(item['createdDate'] ?? "") ?? DateTime.now(),
                updatedByUserId: item['updatedByUserId'] ,
                updatedDate: DateTime.tryParse(item['updatedDate'] ?? "") ?? DateTime.now(),
                createdBy: item['createdBy'],
                updatedBy: item['updatedBy'],
                stateCode: item['stateCode'],
              ));
              print('itiscompletedloop');
              print('description: ${item['description']}');
              wedviewapi = item['description'];

            }
            setState(() {
              Wedviewapi = wedviewapi!;
              print('Wedviewapi: $Wedviewapi');

            });
          } else {
            print('error ');
          }
        } else {
          print("Error: ${jsonData["endUserMessage"]}");
        }
      } else {
        // Handle error if the API request was not successful
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API $error');
    }
    return null;
  }


  Future<void> getimpcontactdetails(String fc, String sc) async {
    final url = Uri.parse(baseUrl + getContactInfo + fc + "/" + sc);
    print('impcontactdetail-$url');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Request isSuccess $jsonData');

        //if (jsonData["isSuccess"]) {
          print('it is Success');

          final result = jsonData['result'];
          if (result != null) {
            final importantContacts = result['importantContacts'];
            final importantPlaces = result['importantPlaces'];

            if (importantContacts != null) {
              print('Important Contacts:');
              print('Cluster Officer Name: ${importantContacts['clusterOfficerName']}');
              print('Cluster Officer Contact Number: ${importantContacts['clusterOfficerContactNumber']}');
              print('Cluster Officer Manager Name: ${importantContacts['clusterOfficerManagerName']}');
              print('Cluster Officer Manager Contact Number: ${importantContacts['clusterOfficerManagerContactNumber']}');
              print('State Head Name: ${importantContacts['stateHeadName']}');
            }

            if (importantPlaces != null) {
              print('Important Places:');
              final collectionCenters = importantPlaces['collectionCenters'];
              if (collectionCenters != null) {
                print('Collection Centers:');
                for (var center in collectionCenters) {
                  print('Collection Center: ${center['collectionCenter']}');
                  print('Village Name: ${center['villageName']}');
                  print('Mandal Name: ${center['mandalName']}');
                  print('District Name: ${center['districtName']}');
                  print('Latitude: ${center['latitude']}');
                  print('Longitude: ${center['longitude']}');
                  print('Is Mill: ${center['isMill']}');
                }
              }

              final godowns = importantPlaces['godowns'];
              if (godowns != null) {
                print('Godowns:');
                for (var godown in godowns) {
                  print('Godown: ${godown['godown']}');
                  print('Location: ${godown['location']}');
                  print('Address: ${godown['address']}');
                  print('Latitude: ${godown['latitude']}');
                  print('Longitude: ${godown['longitude']}');
                  print('Code: ${godown['code']}');
                  print('Godown ID: ${godown['godownId']}');
                }
              }

              final nurseries = importantPlaces['nurseries'];
              if (nurseries != null) {
                print('Nurseries:');
                for (var nursery in nurseries) {
                  print('Nursery Code: ${nursery['nurseryCode']}');
                  print('Nursery Name: ${nursery['nurseryName']}');
                  print('Village: ${nursery['village']}');
                  print('Mandal: ${nursery['mandal']}');
                  print('District: ${nursery['district']}');
                  print('Latitude: ${nursery['latitude']}');
                  print('Longitude: ${nursery['longitude']}');
                }
              }
            }
          } else {
            print('Error: No result found');
          }
        //}
      // else {
      //     print("Error: ${jsonData["endUserMessage"]}");
      //   }
      } else {
        // Handle error if the API request was not successful
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: null,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE39A63), Color(0xFFDB5D4B)],
                    ),
                    // color: Color(
                    //     0xFFe86100),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: TabBar(
                    labelColor: Color(0xFFe86100),
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                    ),
                    tabs: [
                      Tab(text: 'Basic Info'),
                      Tab(text: 'Important Contacts'),
                      Tab(text: 'Important Places'),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(children: [
                     Container(
                       child: Center(
                         child:  WebView(

                        javascriptMode: JavascriptMode.disabled,
                        onWebResourceError: (WebResourceError error) {
                          if (error.errorCode == 10) {
                            // This error code (10) corresponds to ERR_NAME_NOT_RESOLVED
                            // Display an error message to the user or take appropriate action.
                            // For example, you can show an error page or a snackbar.
                            print("Web Resource Error: net::ERR_NAME_NOT_RESOLVED");
                            // Add your error handling logic here.
                          }
                        },
                      ),

                    ),
                  ),
                  Container(),
                  Container(),
                ]))
              ]),
      ),

      // @override
      // Widget build(BuildContext context) {
      //   return Scaffold(
      //     appBar: null,
      //     body: Center(
      //     child:  WebView(
      //         initialUrl: 'https://www.google.com/',
      //         javascriptMode: JavascriptMode.unrestricted,
      //         onWebViewCreated: (WebViewController webViewController) {
      //           _controller = webViewController;
      //         },
      //       ),
      //     )
      //
      //
      //
      //   );
      // }
    );
  }
}
