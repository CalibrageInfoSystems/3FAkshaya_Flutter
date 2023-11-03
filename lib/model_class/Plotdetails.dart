class PlotResponse {
  bool isSuccess;
  int affectedRecords;
  String endUserMessage;
  List<PlotResult> listResult;

  PlotResponse(
      {required this.isSuccess,
      required this.affectedRecords,
      required this.endUserMessage,
      required this.listResult});
//
// factory PlotResponse.fromJson(Map<String, dynamic> json) =>
//     _$PlotResponseFromJson(json);
//
// Map<String, dynamic> toJson() => _$PlotResponseToJson(this);
}

class PlotResult {
  String? plotcode;
  String? farmerCode;
  double? palmArea;
  double? plotArea;
  double? plotAreainAcres;
  double? palmAreainAcres;
  String? dateOfPlanting;
  String? landMark;
  int? villageId;
  String? villageCode;
  String? villageName;
  int? mandalId;
  String? mandalCode;
  String? mandalName;
  int? districtId;
  String? districtCoe;
  String? districtName;
  int? stateId;
  String? stateCode;
  String? stateName;
  int? statusTypeId;
  String? statusType;
  int? age;
  int? clusterId;
  String? clusterName;
  String? surveyNumber;
  String? farmerName;
  String? contactNumber;
  String? mobileNumber;
  dynamic interCrops;


  PlotResult(
      {required this.plotcode,
      required this.farmerCode,
      required this.palmArea,
      required this.plotArea,
      required this.plotAreainAcres,
      required this.palmAreainAcres,
      required this.dateOfPlanting,
      required this.landMark,
      required this.villageId,
      required this.villageCode,
      required this.villageName,
      required this.mandalId,
      required this.mandalCode,
      required this.mandalName,
      required this.districtId,
      required this.districtCoe,
      required this.districtName,
      required this.stateId,
      required this.stateCode,
      required this.stateName,
      required this.statusTypeId,
      required this.statusType,
      required this.age,
      required this.clusterId,
      required this.clusterName,
      required this.surveyNumber,
      required this.farmerName,
      this.contactNumber,
      this.mobileNumber,
      this.interCrops
      });

  factory PlotResult.fromJson(Map<String, dynamic> json) {
    return PlotResult(
      plotcode: json['plotcode'],
      farmerCode: json['farmerCode'],
      palmArea: json['palmArea'],
      plotArea: json['plotArea'],
      plotAreainAcres: json['plotAreainAcres'],
      palmAreainAcres: json['palmAreainAcres'],
      dateOfPlanting: json['dateOfPlanting'],
      landMark: json['landMark'],
      villageId: json['villageId'],
      villageCode: json['villageCode'],
      villageName:json['villageName'],
      mandalId: json['mandalId'],
      mandalCode: json['mandalCode'],
      mandalName: json['mandalName'],
      districtId: json['districtId'],
      districtCoe: json['districtCoe'],
      districtName: json['districtName'],
      stateId: json['stateId'],
      stateCode: json['stateCode'],
      stateName: json['stateName'],
      statusTypeId: json['statusTypeId'],
      statusType: json['statusType'],
      age: json['age'],
      clusterId: json['clusterId'],
      clusterName: json['clusterName'],
      surveyNumber: json['surveyNumber'],
      farmerName: json['farmerName'],
      contactNumber: json['contactNumber'],
      mobileNumber: json['mobileNumber'],
      interCrops: json['interCrops']
    );
  }
}
