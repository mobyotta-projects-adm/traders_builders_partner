class BookingDetails {
  final String bookingId;
  final String customerEmail;
  final String customerPhone;
  final String serviceName;
  final String dateFrom;
  final String dateTo;
  final String addressLineOne;
  final String addressLineTwo;
  final String city;
  final String postalCode;
  final String bookingStatus;
  final String creationDatetime;
  final String bookingCode;
  final String description;

  BookingDetails({
    required this.bookingId,
    required this.customerEmail,
    required this.customerPhone,
    required this.serviceName,
    required this.dateFrom,
    required this.dateTo,
    required this.addressLineOne,
    required this.addressLineTwo,
    required this.city,
    required this.postalCode,
    required this.bookingStatus,
    required this.creationDatetime,
    required this.bookingCode,
    required this.description,
  });

  factory BookingDetails.fromJson(Map<String, dynamic> json) {
    return BookingDetails(
      bookingId: json['booking_id'],
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'],
      serviceName: json['service_name'],
      dateFrom: json['date_from'],
      dateTo: json['date_to'],
      addressLineOne: json['address_line_one'],
      addressLineTwo: json['address_line_two'],
      city: json['city'],
      postalCode: json['postal_code'],
      bookingStatus: json['booking_status'],
      creationDatetime: json['creationdatetime'],
      bookingCode: json['booking_code'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'customer_email': customerEmail,
      'customer_phone': customerPhone,
      'service_name': serviceName,
      'date_from': dateFrom,
      'date_to': dateTo,
      'address_line_one': addressLineOne,
      'address_line_two': addressLineTwo,
      'city': city,
      'postal_code': postalCode,
      'booking_status': bookingStatus,
      'creationdatetime': creationDatetime,
      'booking_code': bookingCode,
      'description': description,
    };
  }
}
