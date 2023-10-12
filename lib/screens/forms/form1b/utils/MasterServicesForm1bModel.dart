
class MasterServicesFormData {
  String? selectedServiceId;
  String domainId;

  MasterServicesFormData({
    required this.selectedServiceId,
    required this.domainId,
  });

  // Factory constructor to create an instance from a JSON Map
  factory MasterServicesFormData.fromJson(Map<String, dynamic> json) {
    return MasterServicesFormData(
      selectedServiceId: json['service_id'],
      domainId: json['domain_id'],
    );
  }

  // Method to convert the object to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'service_id': selectedServiceId,
      'domain_id': domainId,
    };
  }

  @override
  String toString() {
    return 'MasterServicesFormData {service_id: $selectedServiceId, domain_id: $domainId}';
  }
}
