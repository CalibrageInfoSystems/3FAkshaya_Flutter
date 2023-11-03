import 'dart:convert';
import 'package:akshayaflutter/CommonUtils/Commonclass.dart';
import 'package:akshayaflutter/CustomVectorWidget.dart';
import 'package:akshayaflutter/api_config.dart';
import 'package:akshayaflutter/model_class/BannerModel.dart';
import 'package:akshayaflutter/model_class/learning_Services.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'ffb_collections.dart';
import 'model_class/Service.dart';

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  // int _currentIndex = 0;
  bool _loading = false;
  bool isLoading = false;
  List<BannerModel> imageList = [];
  int currentIndex = 0;
  String? description = "";
  late String asset_Path;
  String? bannerimage = "";
  final CarouselController carouselController = CarouselController();
  List<Service> services = []; // Initialize as an empty list
  List<learning> learningservices = [];

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    asset_Path = "";
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false; // Set isLoading to false when data is loaded
      });
    });
    _fetchServices();
    fetchImages('AP');
    _fetchlearningServices();
    getlearningservices();
    getServicesByStateCode('AP');
  }

  Future<void> _fetchServices() async {
    try {
      setState(() {
        isLoading = true; // Add a isLoading boolean to track loading state
      });

      final services = await getServicesByStateCode('AP');

      setState(() {
        this.services = services;
      });
    } catch (e) {
      // Handle errors here, e.g., show an error message to the user
      print('Error fetching services: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchlearningServices() async {
    try {
      setState(() {
        isLoading = true; // Add a isLoading boolean to track loading state
      });

      final services = await getlearningservices();
      setState(() {
        this.learningservices = services;
      });
    } catch (e) {
      // Handle errors here, e.g., show an error message to the user
      print('Error fetching learning services: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: isLoading
            ? Center(
                child:
                    CircularProgressIndicator(),
              )
            : Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFe56d5d),
                        Color(0xFFe56d5d),
                        Color(0xFFE39A63),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.111, 0.4,0.4],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                        child: Text(
                          'Views',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          // Align the first column to the start
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                print('clickedonffbcollections');
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ffb_collections()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/ffb_collection.png', width: 48, height: 48),
                                  Text('FFB Collections', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),


                          SizedBox(width: 10),

                          // Align the second column in the center
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/passbook.png',
                                    width: 48, height: 48),
                                Text('Farmer Passbook',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),


                          SizedBox(width: 10),

                          // Align the third column at the end
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 15.0),
                                Image.asset('assets/main_visit.png',
                                    width: 48, height: 48),
                                Text('Crop Maintenance',
                                    style: TextStyle(color: Colors.white)),
                                Text('Visits',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white, // Add a background color
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0), // Adjust the padding as needed
                          child: Text(
                            'Request Services',
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(), // Display the progress bar while loading
                          )
                        : Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 0.0,
                                          mainAxisSpacing: 0.0,
                                          mainAxisExtent: 110.0),
                                  itemCount: services.length,
                                  itemBuilder: (context, index) {
                                    final service = services[index];
                                    late String assetPath;
                                    switch (service.serviceType) {
                                      case "Fertilizer Request":
                                        assetPath = "assets/fertilizers.png";
                                        break;
                                      case "Pole Request":
                                        assetPath = "assets/equipment.png";
                                        break;
                                      case "Labour Request":
                                        assetPath = "assets/fertilizers.png";
                                        break;
                                      case "QuickPay Request":
                                        assetPath = "assets/labour.png";
                                        break;
                                      case "Visit Request":
                                        assetPath = "assets/quick_pay.png";
                                        break;
                                      case "Loan Request":
                                        assetPath = "assets/visit.png";
                                        break;
                                      case "Transport Request":
                                        assetPath = "assets/loan.png";
                                        break;
                                      default:
                                        break;
                                    }
                                    return Card(
                                      elevation: 2.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            assetPath,
                                            width: 50,
                                            height:
                                                50,
                                          ),
                                          // Set the icon based on serviceType and adjust size
                                          SizedBox(height: 8),
                                          // Add some spacing between icon and text

                                          Text(
                                            service.serviceType,
                                            textAlign: TextAlign.center,
                                            // Center-align the text
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFFDFDFDF), // Add a background color
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 5.0,
                              bottom: 5.0), // Adjust the padding as needed
                          child: Text(
                            'Learning',
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(), // Display the progress bar while loading
                          )
                        : Expanded(
                            child: Container(
                              color: Color(0xFFDFDFDF),
                              // Replace with your desired color
                              child: Center(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 0.0,
                                          mainAxisSpacing: 0.0,
                                          mainAxisExtent: 110.0),
                                  itemCount: learningservices.length,
                                  itemBuilder: (context, index) {
                                    final servic = learningservices[index];
                                    switch (servic.name) {
                                      case "Fertilizers":
                                        asset_Path = "assets/fertilizers.png";
                                        break;
                                      case "Harvesting":
                                        asset_Path = "assets/harvesting.png";
                                        break;
                                      case "Pests and Diseases":
                                        asset_Path = "assets/pest.png";
                                        break;
                                      case "Oil Palm Management":
                                        asset_Path = "assets/oilpalm.png";
                                        break;
                                      case "General":
                                        asset_Path = "assets/general.png";
                                        break;
                                      case "Loan Request":
                                        asset_Path = "assets/ic_lernin.png";
                                        break;
                                      // case "Transport Request":
                                      //   assetPath = "assets/loan.png";
                                      //   break;
                                      default:
                                        break;
                                    }

                                    return Card(
                                      elevation: 2.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          Image.asset(
                                            asset_Path,
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            servic.name,
                                            textAlign: TextAlign.center,
                                            // Center-align the text
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                    isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(),
                          )
                        : Container(
                            height: 20,
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            child: Marquee(
                              text: '$description',
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              blankSpace: 20.0,
                              velocity: 30.0,
                              pauseAfterRound: Duration(seconds: 1),
                              showFadingOnlyWhenScrolling: false,
                              fadingEdgeStartFraction: 0.1,
                              fadingEdgeEndFraction: 0.1,
                            ),
                          ),
                    Expanded(
                      child: Stack(
                        children: [
                          CarouselSlider(
                            items: imageList
                                .map((item) => Image.network(
                                      item.imageName,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                    ))
                                .toList(),
                            carouselController: carouselController,
                            options: CarouselOptions(
                              scrollPhysics: const BouncingScrollPhysics(),
                              autoPlay: true,
                              aspectRatio: 19.7 / 7,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                  //print('$index');
                                });
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              // Adjust the value (20.0) to move it up as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    imageList.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  return buildIndicator(index);
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]));
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == currentIndex ? Colors.orange : Colors.grey,
      ),
    );
  }

  Future<void> fetchImages(String statecode) async {
    // final baseUrl = 'http://example.com/';
    // final getbanners = 'getbanners';

    final url = Uri.parse(baseUrl + getbanners + statecode);
    print('url==>127: $url');
    String desc = ""; // Initialize an empty string
    String imagename = "";
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Request isSuccess $jsonData');

        if (jsonData["isSuccess"]) {
          print('itisisSuccess');

          if (jsonData['listResult'] != null &&
              jsonData['listResult'].isNotEmpty != 0) {
            print('itisListResult');

            List<BannerModel> bannerImages = [];
            for (var item in jsonData['listResult']) {
              print('itisbannerImages');

              bannerImages.add(BannerModel(
                id: item['id'],
                imageName: item['imageName'],
                description: item['description'],
                stateCode: item['statecode'],
                isActive: item['isActive'],
              ));
              print('itiscompletedloop');

              //    Print the imageName
              print('Image Name: ${item['imageName']}');
              desc = item['description'];
              // Concatenate the description values
              //    imagename='${item['imageName']}';
            }
            setState(() {
              imageList = bannerImages;
              description = desc;
              bannerimage = imagename;
              print('Descriptions: $description');
              print('imagename: $bannerimage');
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
      // Handle any exception that occurred during the API call
      print('Error: $error');
    }
  }

  Future<List<Service>> getServicesByStateCode(String s) async {
    final String baseUrl = 'https://3fakshaya.com/api/StateService';
    final response =
        await http.get(Uri.parse('$baseUrl/GetServicesByStateCode/$s'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final List<dynamic> serviceListData = jsonData['listResult'];
      services = serviceListData.map((data) => Service.fromJson(data)).toList();

      print('services==>${services.length}');

      return serviceListData.map((data) => Service.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<List<learning>> getlearningservices() async {
    final String baseUrl = 'https://3fakshaya.com/api/';
    final response = await http.get(Uri.parse('${baseUrl + getlearning}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final List<dynamic> learningListData = jsonData['listResult'];
      learningservices =
          learningListData.map((data) => learning.fromJson(data)).toList();

      print('learningservicesservices==>${learningservices.length}');

      return learningListData.map((data) => learning.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }
}
