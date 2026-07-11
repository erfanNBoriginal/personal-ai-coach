class BusinessResponse {
  // final bool result;
  // final int status;
  final dynamic data;

  BusinessResponse({this.data});

// Map<String,dynamic> toMap(){}

  factory BusinessResponse.fromMap(dynamic map) {
    return BusinessResponse(
      data: map['choices'][0],
    );
  }
}
