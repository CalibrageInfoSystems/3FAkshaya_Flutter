class Service {
  final int id;
  final String stateCode;
  final String stateName;
  final int serviceTypeId;
  final int createdByUserId;
  final String createdDate;
  final String serviceType;
  final String createdBy;

  Service({
    required this.id,
    required this.stateCode,
    required this.stateName,
    required this.serviceTypeId,
    required this.createdByUserId,
    required this.createdDate,
    required this.serviceType,
    required this.createdBy,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
    //  plotcode: json['plotcode'],
      id: json['id'],
      stateCode: json['stateCode'],
      stateName: json['stateName'],
      serviceTypeId: json['serviceTypeId'],
      createdByUserId: json['createdByUserId'],
      createdDate: json['createdDate'],
      serviceType: json['serviceType'],
      createdBy: json['createdBy']
    );
  }
}
