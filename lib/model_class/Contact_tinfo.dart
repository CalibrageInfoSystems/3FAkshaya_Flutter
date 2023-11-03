import 'dart:convert';



class Contactinfo {
  int id;
  String? description;
  String? contactInfo;
  int createdByUserId;
  DateTime createdDate;
  int updatedByUserId;
  DateTime updatedDate;
  String createdBy;
  String updatedBy;
  String stateCode;

  Contactinfo({
    required this.id,
    this.description,
    this.contactInfo,
    required this.createdByUserId,
    required this.createdDate,
    required this.updatedByUserId,
    required this.updatedDate,
    required this.createdBy,
    required this.updatedBy,
    required this.stateCode,
  });

  factory Contactinfo.fromJson(Map<String, dynamic> json) {
    return Contactinfo(
      id: json['id'] ?? 0,
      description: json['description'],
      contactInfo: json['contactInfo'],
      createdByUserId: json['createdByUserId'] ?? 0,
      createdDate: DateTime.tryParse(json['createdDate'] ?? "") ?? DateTime.now(),
      updatedByUserId: json['updatedByUserId'] ?? 0,
      updatedDate: DateTime.tryParse(json['updatedDate'] ?? "") ?? DateTime.now(),
      createdBy: json['createdBy'] ?? "",
      updatedBy: json['updatedBy'] ?? "",
      stateCode: json['stateCode'] ?? "",
    );
  }


}
