


// class FarmerDetails {
//   final List<Farmer> farmerDetails;
//   final List<Category> categoriesDetails;
//
//   FarmerDetails({
//     required this.farmerDetails,
//     required this.categoriesDetails,
//   });
//
//   factory FarmerDetails.fromJson(Map<String, dynamic> json) =>
//       _$FarmerDetailsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$FarmerDetailsToJson(this);
// }


class Farmer {
  final String code;
  final int id;
  final String title;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String guardianName;
  final String motherName;
  final String contactNumber;
  final String? mobileNumber;
  final String contactNumbers;
  final String dob;
  final int age;
  final String? email;
  final String villageName;
  final int pinCode;
  final String mandalName;
  final String districtName;
  final String stateName;
  final String stateCode;
  final int stateId;
  final int moduleTypeId;
  final String farmerPictureLocation;
  final String addressLine1;
  final String addressLine2;
  final String? addressLine3;
  final String landmark;
  final String address;
  final int clusterId;
  final String clusterName;
  final int villageId;
  final int districtId;
  final String name;
  final String teluguName;
  final String hindiName;
  final String remarks;
  final bool isActive;
  final int createdByUserId;
  final String createdDate;
  final int updatedByUserId;
  final String updatedDate;


  Farmer({
    required this.code,
    required this.id,
    required this.title,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.guardianName,
    required this.motherName,
    required this.contactNumber,
    this.mobileNumber,
    required this.contactNumbers,
    required this.dob,
    required this.age,
    this.email,
    required this.villageName,
    required this.pinCode,
    required this.mandalName,
    required this.districtName,
    required this.stateName,
    required this.stateCode,
    required this.stateId,
    required this.moduleTypeId,
    required this.farmerPictureLocation,
    required this.addressLine1,
    required this.addressLine2,
    this.addressLine3,
    required this.landmark,
    required this.address,
    required this.clusterId,
    required this.clusterName,
    required this.villageId,
    required this.districtId,
    required this.name,
    required this.teluguName,
    required this.hindiName,
    required this.remarks,
    required this.isActive,
    required this.createdByUserId,
    required this.createdDate,
    required this.updatedByUserId,
    required this.updatedDate,

  });

  // factory Farmer.fromJson(Map<String, dynamic> json) {
  //   return Farmer(
  //     code: json['code'],
  //     id: json['id'],
  //     title: json['title'],
  //     firstName: json['firstName'],
  //     middleName: json['middleName'],
  //     lastName: json['lastName'],
  //     guardianName: json['guardianName'],
  //     motherName: json['motherName'],
  //     contactNumber: json['contactNumber'],
  //     mobileNumber: json['mobileNumber'],
  //     contactNumbers: json['contactNumbers'],
  //     dob: json['dob'],
  //     age: json['age'],
  //     email: json['email'],
  //     villageName: json['villageName'],
  //     pinCode: json['pinCode'],
  //     mandalName: json['mandalName'],
  //     districtName: json['districtName'],
  //     stateName: json['stateName'],
  //     stateCode: json['stateCode'],
  //     stateId: json['stateId'],
  //     moduleTypeId: json['moduleTypeId'],
  //     farmerPictureLocation: json['farmerPictureLocation'],
  //     addressLine1: json['addressLine1'],
  //     addressLine2: json['addressLine2'],
  //     addressLine3: json['addressLine3'],
  //     landmark: json['landmark'],
  //     address: json['address'],
  //     clusterId: json['clusterId'],
  //     clusterName: json['clusterName'],
  //     villageId: json['villageId'],
  //     districtId: json['districtId'],
  //     name: json['name'],
  //     teluguName: json['title'],
  //     hindiName: json['firstName'],
  //     remarks: json['middleName'],
  //     isActive: json['lastName'],
  //     createdByUserId: json['guardianName'],
  //     createdDate: json['motherName'],
  //     updatedByUserId: json['contactNumber'],
  //     updatedDate: json['mobileNumber'],
  //
  //   );
  // }
  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      code: json['result']['farmerDetails'][0]['code'],
      id: json['result']['farmerDetails'][0]['id'],
      title: json['result']['farmerDetails'][0]['title'],
      firstName: json['result']['farmerDetails'][0]['firstName'],
      middleName: json['result']['farmerDetails'][0]['middleName'],
      lastName: json['result']['farmerDetails'][0]['lastName'],
      guardianName: json['result']['farmerDetails'][0]['guardianName'],
      motherName: json['result']['farmerDetails'][0]['motherName'],
      contactNumber: json['result']['farmerDetails'][0]['contactNumber'],
      mobileNumber: json['result']['farmerDetails'][0]['mobileNumber'],
      contactNumbers: json['result']['farmerDetails'][0]['contactNumbers'],
      dob: json['result']['farmerDetails'][0]['dob'],
      age: json['result']['farmerDetails'][0]['age'],
      email: json['result']['farmerDetails'][0]['email'],
      villageName: json['result']['farmerDetails'][0]['villageName'],
      pinCode: json['result']['farmerDetails'][0]['pinCode'],
      mandalName: json['result']['farmerDetails'][0]['mandalName'],
      districtName: json['result']['farmerDetails'][0]['districtName'],
      stateName: json['result']['farmerDetails'][0]['stateName'],
      stateCode: json['result']['farmerDetails'][0]['stateCode'],
      stateId: json['result']['farmerDetails'][0]['stateId'],
      moduleTypeId: json['result']['farmerDetails'][0]['moduleTypeId'],
      farmerPictureLocation: json['result']['farmerDetails'][0]['farmerPictureLocation'],
      addressLine1: json['result']['farmerDetails'][0]['addressLine1'],
      addressLine2: json['result']['farmerDetails'][0]['addressLine2'],
      addressLine3: json['result']['farmerDetails'][0]['addressLine3'],
      landmark: json['result']['farmerDetails'][0]['landmark'],
      address: json['result']['farmerDetails'][0]['address'],
      clusterId: json['result']['farmerDetails'][0]['clusterId'],
      clusterName: json['result']['farmerDetails'][0]['clusterName'],
      villageId: json['result']['farmerDetails'][0]['villageId'],
      districtId: json['result']['farmerDetails'][0]['districtId'],
      name: json['result']['categoriesDetails'][0]['name'],
      teluguName: json['result']['categoriesDetails'][0]['teluguName'],
      hindiName: json['result']['categoriesDetails'][0]['hindiName'],
      remarks: json['result']['categoriesDetails'][0]['remarks'],
      isActive: json['result']['categoriesDetails'][0]['isActive'],
      createdByUserId: json['result']['categoriesDetails'][0]['createdByUserId'],
      createdDate: json['result']['categoriesDetails'][0]['createdDate'],
      updatedByUserId: json['result']['categoriesDetails'][0]['updatedByUserId'],
      updatedDate: json['result']['categoriesDetails'][0]['updatedDate'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'id': id,
      'title': title,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'guardianName': guardianName,
      'motherName': motherName,
      'contactNumber': contactNumber,
      'mobileNumber': mobileNumber,
      'contactNumbers': contactNumbers,
      'dob': dob,
      'age': age,
      'email': email,
      'villageName': villageName,
      'pinCode': pinCode,
      'mandalName': mandalName,
      'districtName': districtName,
      'stateName': stateName,
      'stateCode': stateCode,
      'stateId': stateId,
      'moduleTypeId': moduleTypeId,
      'farmerPictureLocation': farmerPictureLocation,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'addressLine3': addressLine3,
      'landmark': landmark,
      'address': address,
      'clusterId': clusterId,
      'clusterName': clusterName,
      'villageId': villageId,
      'districtId': districtId,
      'name' :name,
      'teluguName': teluguName,
      'hindiName': hindiName,
      'remarks':remarks,
      'isActive': isActive,
      'createdByUserId': createdByUserId,
      'createdDate':createdDate,
      'updatedByUserId':updatedByUserId,
      'updatedDate':updatedDate


    };
  }

// factory Farmer.fromJson(Map<String, dynamic> json) => _$FarmerFromJson(toJson());
  //
  // Map<String, dynamic> toJson() => _$FarmerToJson(this);
}


// class Category {
//   final int id;
//   final String name;
//   final String teluguName;
//   final String hindiName;
//   final String remarks;
//   final bool isActive;
//   final int createdByUserId;
//   final String createdDate;
//   final int updatedByUserId;
//   final String updatedDate;
//   final String kannadaName;
//
//   Category({
//     required this.id,
//     required this.name,
//     required this.teluguName,
//     required this.hindiName,
//     required this.remarks,
//     required this.isActive,
//     required this.createdByUserId,
//     required this.createdDate,
//     required this.updatedByUserId,
//     required this.updatedDate,
//     required this.kannadaName,
//   });
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       name: json['name'],
//       teluguName: json['title'],
//       hindiName: json['firstName'],
//       remarks: json['middleName'],
//       isActive: json['lastName'],
//       createdByUserId: json['guardianName'],
//       createdDate: json['motherName'],
//       updatedByUserId: json['contactNumber'],
//       updatedDate: json['mobileNumber'],
//       kannadaName: json['contactNumbers'],
//
//     );
//   }
//   // factory Category.fromJson(Map<String, dynamic> json) =>
//   //     _$CategoryFromJson(json);
//   //
//   // Map<String, dynamic> toJson() => _$CategoryToJson(this);
// }

// Run 'flutter pub run build_runner build' to generate the code.
