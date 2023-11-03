class ResponseModel {
  Result result;
  bool isSuccess;
  int affectedRecords;
  String endUserMessage;
  List<dynamic> validationErrors;
  dynamic exception;

  ResponseModel({
    required this.result,
    required this.isSuccess,
    required this.affectedRecords,
    required  this.endUserMessage,
    required  this.validationErrors,
    required   this.exception,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      result: Result.fromJson(json['result']),
      isSuccess: json['isSuccess'],
      affectedRecords: json['affectedRecords'],
      endUserMessage: json['endUserMessage'],
      validationErrors: json['validationErrors'],
      exception: json['exception'],
    );
  }
}

class Result {
  ImportantContacts importantContacts;
  ImportantPlaces importantPlaces;

  Result({
    required this.importantContacts,
    required  this.importantPlaces,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      importantContacts: ImportantContacts.fromJson(json['importantContacts']),
      importantPlaces: ImportantPlaces.fromJson(json['importantPlaces']),
    );
  }
}

class ImportantContacts {
  String clusterOfficerName;
  String clusterOfficerContactNumber;
  String clusterOfficerManagerName;
  String clusterOfficerManagerContactNumber;
  String stateHeadName;

  ImportantContacts({
    required this.clusterOfficerName,
    required  this.clusterOfficerContactNumber,
    required  this.clusterOfficerManagerName,
    required this.clusterOfficerManagerContactNumber,
    required  this.stateHeadName,
  });

  factory ImportantContacts.fromJson(Map<String, dynamic> json) {
    return ImportantContacts(
      clusterOfficerName: json['clusterOfficerName'],
      clusterOfficerContactNumber: json['clusterOfficerContactNumber'],
      clusterOfficerManagerName: json['clusterOfficerManagerName'],
      clusterOfficerManagerContactNumber: json['clusterOfficerManagerContactNumber'],
      stateHeadName: json['stateHeadName'],
    );
  }
}

class ImportantPlaces {
  List<CollectionCenter> collectionCenters;
  List<Godown> godowns;
  List<Nursery> nurseries;

  ImportantPlaces({
    required this.collectionCenters,
    required this.godowns,
    required this.nurseries,
  });

  factory ImportantPlaces.fromJson(Map<String, dynamic> json) {
    return ImportantPlaces(
      collectionCenters: (json['collectionCenters'] as List)
          .map((e) => CollectionCenter.fromJson(e))
          .toList(),
      godowns: (json['godowns'] as List)
          .map((e) => Godown.fromJson(e))
          .toList(),
      nurseries: (json['nurseries'] as List)
          .map((e) => Nursery.fromJson(e))
          .toList(),
    );
  }
}

class CollectionCenter {
  int id;
  String collectionCenter;
  String villageName;
  String mandalName;
  String districtName;
  double latitude;
  double longitude;
  bool isMill;

  CollectionCenter({
    required this.id,
    required this.collectionCenter,
    required this.villageName,
    required this.mandalName,
    required this.districtName,
    required this.latitude,
    required this.longitude,
    required this.isMill,
  });

  factory CollectionCenter.fromJson(Map<String, dynamic> json) {
    return CollectionCenter(
      id: json['id'],
      collectionCenter: json['collectionCenter'],
      villageName: json['villageName'],
      mandalName: json['mandalName'],
      districtName: json['districtName'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      isMill: json['isMill'],
    );
  }
}

class Godown {
  String godown;
  String location;
  String address;
  double latitude;
  double longitude;
  String code;
  int godownId;

  Godown({
    required this.godown,
    required this.location,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.code,
    required this.godownId,
  });

  factory Godown.fromJson(Map<String, dynamic> json) {
    return Godown(
      godown: json['godown'],
      location: json['location'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      code: json['code'],
      godownId: json['godownId'],
    );
  }
}

class Nursery {
  String nurseryCode;
  String nurseryName;
  String village;
  String mandal;
  String district;
  double latitude;
  double longitude;
  int nurseryId;

  Nursery({
    required this.nurseryCode,
    required this.nurseryName,
    required this.village,
    required this.mandal,
    required this.district,
    required this.latitude,
    required this.longitude,
    required this.nurseryId,
  });

  factory Nursery.fromJson(Map<String, dynamic> json) {
    return Nursery(
      nurseryCode: json['nurseryCode'],
      nurseryName: json['nurseryName'],
      village: json['village'],
      mandal: json['mandal'],
      district: json['district'],
      latitude: json['latitude'] != null ? json['latitude'].toDouble() : null,
      longitude: json['longitude'] != null ? json['longitude'].toDouble() : null,
      nurseryId: json['nurseryId'],
    );
  }
}
