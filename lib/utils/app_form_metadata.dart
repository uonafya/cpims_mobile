class AppFormMetaData {
  final String? formId;
  final String? location_lat;
  final String? location_long;
  final String? startOfInterview;
  final String? endOfInterview;
  final String? formType;
  final String? device_id;
  const AppFormMetaData({
    this.formId,
    this.location_lat,
    this.location_long,
    this.startOfInterview,
    this.endOfInterview,
    this.formType,
    this.device_id,
  });

  factory AppFormMetaData.fromJson(Map<String, dynamic> json) {
    return AppFormMetaData(
      formId: (json['form_id']  ?? "")as String,
      location_lat: (json['location_lat'] ?? "") as String,
      location_long: (json['location_long'] ?? "") as String,
      startOfInterview: (json['start_of_interview'] ?? "") as String,
      endOfInterview: (json['end_of_interview'] ?? "") as String,
      formType: (json['form_type'] ?? "") as String,
      device_id: (json['device_id'] ?? "") as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId,
      'location_lat': location_lat,
      'location_long': location_long,
      'start_of_interview': startOfInterview,
      'end_of_interview': endOfInterview,
      'form_type': formType,
      'device_id': device_id,
    };
  }

  @override
  String toString() {
    return 'AppFormMetaData{formId: $formId, location_lat: $location_lat, location_long: $location_long, startOfInterview: $startOfInterview, endOfInterview: $endOfInterview, formType: $formType}';
  }
}
