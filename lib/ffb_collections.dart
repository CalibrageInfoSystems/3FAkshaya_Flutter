import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:akshayaflutter/CommonUtils/Commonclass.dart';
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
      paidcollections,
      financialYearFrom,
      financialYearTo,
      fromDateStr,
      formattedDate,
      toDateStr,
      datefromapi,
      weightfromapi,nodata,
      u_colnidtext; // Declare selectedValue as a nullable String
  List<dynamic> dropdownItems = [];
  String fromFormattedDate = ''; // Declare fromFormattedDate
  String toFormattedDate = '';
  int? selectedPosition;
  Farmer? catagoriesList;
  bool isInfoVisible = false; // Initially, set it to false
  bool datesavaiablity = false;
  bool nodatavisibility = false;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  bool isLoading = false;
  List<Collection> collectionlist = [];

  //final url,request;
  @override
  void initState() {
    listofdetails();
    get30days();
  }

  String formatDate(String inputDate) {
    final originalFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final desiredFormat = DateFormat("dd/MM/yyyy");

    DateTime date = originalFormat.parse(inputDate);
    String formattedDate = desiredFormat.format(date);

    return formattedDate;
  }

  listofdetails() async {
    final loadedData = await SharedPreferencesHelper.getCategories();
    if (loadedData != null) {
      final farmerDetails = loadedData['result']['farmerDetails'];
      final loadedfarmercode = farmerDetails[0]['code'];
      setState(() {
        fc = loadedfarmercode;
        print('fcinplotdetails--$fc');
        selectedPosition = 0; // Initialize selectedPosition to 0
        callApiMethod(selectedPosition!);
        get30days();
      });
    }
  }

  String formatDateToApi(DateTime date) {
    final DateFormat apiDateFormat = DateFormat('yyyy-MM-dd');
    return apiDateFormat.format(date);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now(); // Default value

    if (controller == fromDateController && fromDate != null) {
      initialDate = fromDate!;
    } else if (controller == toDateController && toDate != null) {
      initialDate = toDate!;
    }

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900), // Adjust the starting date as needed
      lastDate: DateTime.now(), // Restrict future dates
    );

    if (selectedDate != null) {
      // Remove the time portion from the selected date
      final DateTime dateWithoutTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );

      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      final formattedDate = dateFormat.format(dateWithoutTime);

      setState(() {
        if (controller == fromDateController) {
          fromDate = dateWithoutTime;
          fromFormattedDate =
              formattedDate; // Store the formatted date for fromDate
          String formattedDateForApi =
              formatDateToApi(dateWithoutTime); // Format for API
          print(
              '--$fromFormattedDate'); // Print the formatted date for fromDate
          print('--$formattedDateForApi'); // Print the formatted date for API
        } else {
          toDate = dateWithoutTime;
          toFormattedDate =
              formattedDate; // Store the formatted date for toDate
          String formattedDateForApi =
              formatDateToApi(dateWithoutTime); // Format for API
          print('--$toFormattedDate'); // Print the formatted date for toDate
          print('--$formattedDateForApi'); // Print the formatted date for API
        }

        controller.text =
            formattedDate; // Format and set the selected date as a string
      });
    }
  }

  Future<void> callApiMethod(int position) async {
    // Implement your API call logic here
    setState(() {
      datesavaiablity = false;
      isInfoVisible = false;
      isLoading = true;
    });
    if (position == 0) {
      setState(() {
        datesavaiablity = false;
        isInfoVisible = true;
      });

      // Calculate the date range for the "Last 30 Days" option
      DateTime currentDate = DateTime.now();
      DateTime startDate = currentDate.subtract(Duration(days: 30));
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      startDateString = dateFormat.format(startDate);
      endDateString = dateFormat.format(currentDate);
      print('Start Date: $startDateString');
      print('End Date: $endDateString');

      get30days();
      isLoading = false;
      isInfoVisible = false;
      nodatavisibility = true;
    } else if (position == 1) {
      nodatavisibility = false;
      setState(() {
        datesavaiablity = false;
        isInfoVisible = true;
      });

      // Handle other dropdown positions
      DateTime currentDate = DateTime.now();
      int currentYear = currentDate.year;
      int currentMonth = currentDate.month;

      print('currentYear: $currentYear');
      print('currentMonth: $currentMonth');
      if (currentMonth < 4) {
        financialYearFrom = '${currentYear - 1}-04-01';
        financialYearTo = '$currentYear-03-31';
      } else {
        financialYearFrom = '$currentYear-04-01';
        financialYearTo = '${currentYear + 1}-03-31';
      }
      print('financialYearFrom: $financialYearFrom');
      print('financialYearTo: $financialYearTo');

      getfinancialyear();
      isLoading = false;
    } else if (position == 2) {
      nodatavisibility = false;
      isInfoVisible = false;
      datesavaiablity = true;
      isLoading = false;
      await getcustomcollections();

      setState(() {
        isInfoVisible = true;
        datesavaiablity = true;
        isLoading = false;
      });
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
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
                                borderRadius: BorderRadius.circular(6.0),
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
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Last 30 Days',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<int>(
                                    value: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Current Financial Year',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<int>(
                                    value: 2,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Select Time Period',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                dropdownColor: Colors.grey, // Set the dropdown background color to grey
                              ),
                            ),
                          ),
                        ),
                      ),
                    )


                    ,
                    SizedBox(
                      height: 10.0,
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Visibility(
                            visible: datesavaiablity,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 4.0, left: 12.0, right: 12.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        left: 12.0,
                                        right: 12.0,
                                        bottom: 10.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              print('clickedonfromdate');
                                              _selectDate(
                                                  context, fromDateController);
                                              // Handle From Date tap
                                            },
                                            child: TextField(
                                              controller: fromDateController,
                                              decoration: InputDecoration(
                                                hintText: 'From Date',
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                                enabled: false,
                                              ),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              // Handle To Date tap
                                              print('clickedontodate');
                                              _selectDate(
                                                  context, toDateController);
                                            },
                                            child: TextField(
                                              controller: toDateController,
                                              decoration: InputDecoration(
                                                hintText: 'To Date',
                                                hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                                enabled: false,
                                              ),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFFCCCCCC),
                                                Color(0xFFFFFFFF),
                                                Color(0xFFCCCCCC),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            border: Border.all(
                                              width: 2.0,
                                              color: Color(0xFFe86100),
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              print('Submit button is clicked');
                                              datevalidation();
                                            },
                                            child: Text(
                                              'Submit',
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
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),

                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Visibility(
                            visible: isInfoVisible,
                            child: Padding(
                                padding:
                                    EdgeInsets.only(left: 12.0, right: 12.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0x8D000000),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 10, 12, 0),
                                                    child: Text(
                                                      "Total Collections",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Text(
                                                      ":",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Text(
                                                      '$totalcollections',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 10, 12, 0),
                                                    child: Text(
                                                      "Total Net Weight",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Text(
                                                      ":",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Text(
                                                      '$totalnetweight',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 10, 0, 0),
                                                    child: Text(
                                                      "Unapid Collections Weight",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            4, 0, 0, 0),
                                                    child: Text(
                                                      ":",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 0, 0),
                                                    child: Text(
                                                      '$unpaidcollections',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            8, 10, 12, 5),
                                                    child: Text(
                                                      "Paid Collections Weight",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 5),
                                                    child: Text(
                                                      ":",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 5),
                                                    child: Text(
                                                      '$paidcollections',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'hind_semibold',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )))),
                    SizedBox(
                      height: 50.0,
                    ),
                    Visibility(
                      visible:nodatavisibility ,
                      child: Text(
                      " No Collection Data Found",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight:
                        FontWeight.bold,
                        fontFamily:
                        'hind_semibold',
                      ),
                    ),),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            flex: 3,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: collectionlist.length,
                              itemBuilder: (context, index) {
                                List<Color> cardColors = [Colors.white, Color(0xFFDFDFDF)];
                                Color backgroundColor = cardColors[index % cardColors.length];
                                Collection collect = collectionlist[index];
                                late Color textColor;
                                String status = "";
                                String formattedDate =
                                    collect.docDate.toString();
                                datefromapi = formatDate(formattedDate);
                                String weight =
                                    collect.quantity.toString() + "Kg";
                                status = collect.uApaystat.toString();
                                if (status == "Payment Pending") {
                                  textColor = Colors.red;
                                } else if (status == "Paid") {
                                  textColor = Colors.green;
                                }
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                  child: Card(
                                    color: backgroundColor,
                                    shadowColor: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 15.0),
                                                    child: Text(
                                                      '${collect.uColnid}',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xFFFB4110),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Calibri',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: -1,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          15,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                "Date",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'hind_semibold',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          40,
                                                                          15,
                                                                          5,
                                                                          0),
                                                              child: Text(
                                                                ":",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'hind_semibold',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          15,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '$datefromapi',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'hind_semibold',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.0),
                                                      Expanded(
                                                        flex: 0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          15,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                'Weight',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'hind_semibold',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          15,
                                                                          5,
                                                                          0),
                                                              child: Text(
                                                                ":",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'hind_semibold',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          15,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                '$weight',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'hind_semibold',
                                                                ),
                                                                //  controller: weightController, // Use a TextEditingController for weight
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    Expanded(
                                                      flex: -1,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 5, 0, 0),
                                                            child: Text(
                                                              "CC",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'hind_semibold',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 0,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(53, 5,
                                                                    5, 0),
                                                            child: Text(
                                                              ":",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'hind_semibold',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 5, 0, 0),
                                                            child: Text(
                                                              '${collect.whsName}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'hind_semibold',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                                  Row(children: [
                                                    Expanded(
                                                      flex: -1,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 5, 0, 0),
                                                            child: Text(
                                                              "Status",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'hind_semibold',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 0,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(32, 5,
                                                                    5, 0),
                                                            child: Text(
                                                              ":",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'hind_semibold',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 5, 0, 0),
                                                            child: Text(
                                                              '$status',
                                                              style: TextStyle(
                                                                color:
                                                                    textColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'hind_semibold',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0126, 0.244, 0.4444, 0.2],
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
          List<Collection> collections =
              (responseData['result']['collectioData'] as List)
                  .map((item) => Collection.fromJson(item))
                  .toList();
          CollectionCount collectionCount = CollectionCount.fromJson(
              responseData['result']['collectionCount'][0]);


          // Now, you can access the data within collections and collectionCount
          for (Collection collection in collections) {
            print('uColnid: ${collection.uColnid}');
            u_colnidtext = collection.uColnid.toString();
            String formattedDate = collection.docDate.toString();
            datefromapi = formatDate(formattedDate);
            print('u_colnidtext30days: ${u_colnidtext}');
            print('u_colniddatefromapi30days: ${formattedDate}');
            // Access other properties as needed
            setState(() {
              collectionlist = collections;
              datefromapi = formattedDate;
            });
          }

          // print('Collections Weight: ${collectionCount.collectionsWeight}');
          // print('Collections Count: ${collectionCount.collectionsCount}');
          // print('Paid Collections Weight: ${collectionCount.paidCollectionsWeight}');
          // print('Unpaid Collections Weight: ${collectionCount.unPaidCollectionsWeight}');
          totalcollections = '${collectionCount.collectionsCount}';
          totalnetweight = '${collectionCount.collectionsWeight} Kg';
          paidcollections = '${collectionCount.paidCollectionsWeight} Kg';
          unpaidcollections = ' ${collectionCount.unPaidCollectionsWeight}Kg';
          print('totalcollections-$totalcollections');
          print('totalnetweight-$totalnetweight');
          print('paidcollections-$paidcollections');
          print('unpaidcollections-$unpaidcollections');
        } else {
          print('Request was not successful');
          nodatavisibility = true;
        }
      } else {
        print(
            'Failed to send the request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getfinancialyear() async {
    collectionlist.clear();
    final url = Uri.parse(baseUrl + getcollection);
    print('url==>000: $url');
    final request = {
      "farmerCode": fc,
      "fromDate": financialYearFrom,
      "toDate": financialYearTo
    };
    print('request of the financialYear  : $request');
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
        print('responseDataFY: $responseData');
        if (responseData['result'] != null) {
          List<Collection> collections =
              (responseData['result']['collectioData'] as List)
                  .map((item) => Collection.fromJson(item))
                  .toList();
          CollectionCount collectionCount = CollectionCount.fromJson(
              responseData['result']['collectionCount'][0]);

          for (Collection collection in collections) {
            print('uColnid: ${collection.uColnid}');
            u_colnidtext = collection.uColnid.toString();
            print('u_colnidtextFY: ${u_colnidtext}');
            // Access other properties as needed
            setState(() {
              collectionlist = collections;
            });
          }
          totalcollections = '${collectionCount.collectionsCount}';
          totalnetweight = '${collectionCount.collectionsWeight} Kg';
          paidcollections = '${collectionCount.paidCollectionsWeight} Kg';
          unpaidcollections = ' ${collectionCount.unPaidCollectionsWeight}Kg';
          print('totalcollectionsFY-$totalcollections');
          print('totalnetweightFY-$totalnetweight');
          print('paidcollectionsFY-$paidcollections');
          print('unpaidcollectionsFY-$unpaidcollections');
        } else {
          print('Request was not successfulFY');
        }
      } else {
        print(
            'Failed to send the request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error FY: $e');
    }
  }

  void datevalidation() {
    if (fromDate == null || toDate == null) {
      showCustomToastMessageLong(
          "Please select both FromDate and ToDate", context, 1, 5);
    } else if (toDate!.compareTo(fromDate!) < 0) {
      showCustomToastMessageLong(
          "To Date is less than From Date", context, 1, 5);
    } else {
      // Your submit logic here

      showCustomToastMessageLong("You can hit the API", context, 0, 5);
      getcustomcollections();
      setState(() {
        isInfoVisible = true;
      });
    }
  }

  Future<void> getcustomcollections() async {
    collectionlist.clear();
    final url = Uri.parse(baseUrl + getcollection);
    print('url==>555: $url');
    final String fromFormattedDateApi = formatDateToApi(fromDate!);
    final String toFormattedDateApi = formatDateToApi(toDate!);
    print('fromFormattedDateApi: $fromFormattedDateApi');
    print('toFormattedDateApi: $toFormattedDateApi');
    final request = {
      "farmerCode": fc,
      "fromDate": fromFormattedDateApi,
      "toDate": toFormattedDateApi
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
        print('response_Customcollections: $responseData');
        if (responseData['result'] != null) {
          List<Collection> collections =
              (responseData['result']['collectioData'] as List)
                  .map((item) => Collection.fromJson(item))
                  .toList();
          CollectionCount collectionCount = CollectionCount.fromJson(
              responseData['result']['collectionCount'][0]);

          // Now, you can access the data within collections and collectionCount
          for (Collection collection in collections) {
            print('uColnid: ${collection.uColnid}');
            u_colnidtext = collection.uColnid.toString();
            print('u_colnidtextcustom: ${u_colnidtext}');
            // Access other properties as needed
            setState(() {
              collectionlist = collections;
            });
          }
          // print('Collections Weight: ${collectionCount.collectionsWeight}');
          // print('Collections Count: ${collectionCount.collectionsCount}');
          // print('Paid Collections Weight: ${collectionCount.paidCollectionsWeight}');
          // print('Unpaid Collections Weight: ${collectionCount.unPaidCollectionsWeight}');
          totalcollections = '${collectionCount.collectionsCount}';
          totalnetweight = '${collectionCount.collectionsWeight} Kg';
          paidcollections = '${collectionCount.paidCollectionsWeight} Kg';
          unpaidcollections = ' ${collectionCount.unPaidCollectionsWeight}Kg';
          print('totalcollections_custom-$totalcollections');
          print('totalnetweight_custom-$totalnetweight');
          print('paidcollections_custom-$paidcollections');
          print('unpaidcollections_custom-$unpaidcollections');
        } else {
          print('Request was not successful');
        }
      } else {
        print(
            'Failed to send the request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
