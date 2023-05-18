class TraderDetails {
  final int id;
  final String name;
  final String email;
  final String address;
  final String postalCode;
  final String photo;
  final List<String> serviceNames;

  TraderDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.postalCode,
    required this.photo,
    required this.serviceNames,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'postalCode': postalCode,
      'photo': photo,
      'serviceNames': serviceNames,
    };
  }

  factory TraderDetails.fromMap(Map<String, dynamic> map) {
    return TraderDetails(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      postalCode: map['postalCode'],
      photo: map['photo'],
      serviceNames: List<String>.from(map['serviceNames']),
    );
  }

  factory TraderDetails.fromJson(Map<String, dynamic> json) {
    return TraderDetails(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      postalCode: json['postalCode'],
      photo: json['photo'],
      serviceNames: List<String>.from(json['serviceNames']),
    );
  }

}