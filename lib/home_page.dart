import 'dart:convert';
import 'package:akshayaflutter/CommonUtils/Commonclass.dart';
import 'package:akshayaflutter/CustomVectorWidget.dart';
import 'package:akshayaflutter/api_config.dart';
import 'package:akshayaflutter/model_class/BannerModel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'model_class/Service.dart';

class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  // int _currentIndex = 0;
  bool isLoading = false;
  List<BannerModel> imageList = [];
  int currentIndex = 0;
  String? description="";
  final CarouselController carouselController = CarouselController();
  List<Service> services = []; // Initialize as an empty list
  @override
  void initState() {
    super.initState();
     _fetchServices();

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



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child:
            Container(
              color: Colors.blue, // Replace with your desired color
              child: Row(
                children: [
                 // CustomVectorWidget(), // Add the CustomVectorWidget here

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/ffb_collection.png', width: 48, height: 48),
                        Text('FFB Collections', style: TextStyle(color: Colors
                            .white)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/passbook.png', width: 48, height: 48),
                        Text('Farmer Passbook', style: TextStyle(color: Colors
                            .white)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/main_visit.png', width: 48, height: 48),
                        Text('Crop Maintenance', style: TextStyle(color: Colors.white)),
                       // Text('Visits', style: TextStyle(color: Colors.white)),

                        // Text('Visits', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                 // CustomVectorWidget(), // Add the CustomVectorWidget here

                ],
              ),
            ),

          ),
          Expanded(
            child: Container(
              color: Colors.green, // Replace with your desired color
              child: Center(
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    IconData iconData;

                    // Determine the icon based on serviceType
                    switch (service.serviceType) {
                      case "Fertilizer Request":
                        iconData = Icons.agriculture;
                        break;
                      case "Pole Request":
                        iconData = Icons.settings_input_component;
                        break;
                      case "Labour Request":
                        iconData = Icons.people;
                        break;
                      case "QuickPay Request":
                        iconData = Icons.payment;
                        break;
                      case "Visit Request":
                        iconData = Icons.place;
                        break;
                      case "Loan Request":
                        iconData = Icons.monetization_on;
                        break;
                      case "Transport Request":
                        iconData = Icons.local_shipping;
                        break;
                      default:
                        iconData = Icons.category; // Default icon
                        break;
                    }

                    return ListTile(
                      leading: Icon(iconData), // Set the icon based on serviceType
                      title: Text(service.serviceType),
                      subtitle: Text("Created by: ${service.stateName}"),
                      // You can customize the appearance of each list item as needed
                    );
                  },
                ),
              ),
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.orange, // Replace with your desired color
              child: Center(
              child:  ElevatedButton(
                  onPressed: () async {
                    fetchImages('AP');
                  },
                  child: Text(
                    'Login',
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
          ),
          SizedBox(height: 5.0,),
          Container(
            height: 20, // Set your desired height
            width: MediaQuery.of(context).size.width, // Set your desired width
            child: Marquee(
              text: 'this is only for empty string',
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0, // Adjust the blank space between each scroll
              velocity: 50.0, // Adjust the scrolling speed (pixels per second)
              pauseAfterRound: Duration(seconds: 1), // Pause for 1 second after each round
              showFadingOnlyWhenScrolling: false,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                CarouselSlider(
                  items: imageList.map((item) => Image.network(
                    item.imageName,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  )).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 11 / 9,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry) {
                      final index = entry.key;
                      return buildIndicator(index);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );

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

    final url = Uri.parse(baseUrl2 + getbanners + statecode);
    print('url==>127: $url');
    String desc = ''; // Initialize an empty string

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Request isSuccess $jsonData');
        List<BannerModel> bannerImages = [];

        for (var item in jsonData['ListResult']) {
          bannerImages.add(BannerModel(id: item['id'], imageName: item['imageName'],
              description: item['description'], stateCode: item['statecode'], isActive: item['isActive']));

          // Concatenate the description values
          desc = '${item['description']}, '; // You can adjust the separator as needed
        }

        setState(() {
          imageList = bannerImages;
          description =desc;
          print('Request failed with status: $imageList');
        });

        // Remove the trailing comma and space
     //   descriptions = descriptions.isNotEmpty ? descriptions.substring(0, descriptions.length - 2) : descriptions;
      } else {
        // Handle error if the API request was not successful
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exception that occurred during the API call
      print('Error: $error');
    }

// Now, 'descriptions' contains a comma-separated string of description names
    print('Descriptions: $desc');
  }


  Future<List<Service>> getServicesByStateCode(String s) async {
    final String baseUrl = 'https://3fakshaya.com/api/StateService/';
      final response = await http.get(Uri.parse('$baseUrl/GetServicesByStateCode/$s'));

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
  }

