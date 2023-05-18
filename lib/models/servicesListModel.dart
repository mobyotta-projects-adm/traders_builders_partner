import 'dart:convert';

ServicesListModel servicesListModelFromJson(String str) => ServicesListModel.fromJson(json.decode(str));

String servicesListModelToJson(ServicesListModel data) => json.encode(data.toJson());

class ServicesListModel {
  ServicesListModel({
    required this.serviceId,
    required this.serviceName,
  });

  final String serviceId;
  final String serviceName;

  factory ServicesListModel.fromJson(Map<String, dynamic> json) => ServicesListModel(
    serviceId: json["service_id"],
    serviceName: json["service_name"],
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "service_name": serviceName,
  };

  String? getServiceName(String id) {
    return serviceId == id ? serviceName : null;
  }
}
