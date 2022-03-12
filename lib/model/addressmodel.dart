class Address {
  String? name;
  String? phoneNumber;
  String? flatNumber;
  String? city;
  String? state;
  String? fullAddress;
  String? lat;
  String? lng;

  Address({
    this.name,
    this.phoneNumber,
    this.flatNumber,
    this.city,
    this.state,
    this.fullAddress,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'flatNumber': flatNumber,
      'city': city,
      'state': state,
      'fullAddress': fullAddress,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Address.fromMap(Map<String, String> map) {
    return Address(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      flatNumber: map['flatNumber'],
      city: map['city'],
      state: map['state'],
      fullAddress: map['fullAddress'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}
