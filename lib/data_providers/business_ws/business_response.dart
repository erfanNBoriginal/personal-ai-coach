class BusinessResponse {
  final bool result;
  final int status;
  final dynamic data;

  BusinessResponse({required this.result, required this.status, this.data});

  factory BusinessResponse.fromMap(dynamic map) {
    return BusinessResponse(
      result: map['result'],
      status: map['status'],
      data: map['data'],
    );
  }
}
