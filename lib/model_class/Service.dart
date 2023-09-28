class Service {
  final int id;
  final String stateCode;
  final String stateName;
  final int serviceTypeId;
  final String createdDate;
  final String serviceType;
  final String createdBy;

  Service({
    required this.id,
    required this.stateCode,
    required this.stateName,
    required this.serviceTypeId,
    required this.createdDate,
    required this.serviceType,
    required this.createdBy,
  });

  // Create a factory method to parse JSON data into a Service object
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      stateCode: json['stateCode'],
      stateName: json['stateName'],
      serviceTypeId: json['serviceTypeId'],
      createdDate: json['createdDate'],
      serviceType: json['serviceType'],
      createdBy: json['createdBy'],
    );
  }
}