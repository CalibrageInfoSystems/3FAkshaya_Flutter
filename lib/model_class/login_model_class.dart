
class loginmodel {
  final String result;
  final bool isSuccess;
  final int affectedRecords;
  final String endUserMessage;
  final List<dynamic> validationErrors;
  final dynamic exception;

  loginmodel({
    required this.result,
    required this.isSuccess,
    required this.affectedRecords,
    required this.endUserMessage,
    required this.validationErrors,
    required this.exception,
  });

  factory loginmodel.fromJson(Map<String, dynamic> json) {
    return loginmodel(
      result: json['result'],
      isSuccess: json['isSuccess'],
      affectedRecords: json['affectedRecords'],
      endUserMessage: json['endUserMessage'],
      validationErrors: json['validationErrors'],
      exception: json['exception'],

    );
  }
}
