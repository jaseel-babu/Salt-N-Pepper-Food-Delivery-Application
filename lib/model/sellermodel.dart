import 'dart:convert';

class SellerModel {
  String? address;
  String? earnigs;
  String? lat;
  String? lng;
  String? phone;
  String? sellerName;
  String? sellerUID;
  String? shopName;
  String? status;
  SellerModel({
    this.address,
    this.earnigs,
    this.lat,
    this.lng,
    this.phone,
    this.sellerName,
    this.sellerUID,
    this.shopName,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'earnigs': earnigs,
      'lat': lat,
      'lng': lng,
      'phone': phone,
      'sellerName': sellerName,
      'sellerUID': sellerUID,
      'shopName': shopName,
      'status': status,
    };
  }

  factory SellerModel.fromMap(Map<String, String> map) {
    return SellerModel(
      address: map['address'],
      earnigs: map['earnigs'],
      lat: map['lat'],
      lng: map['lng'],
      phone: map['phone'],
      sellerName: map['sellerName'],
      sellerUID: map['sellerUID'],
      shopName: map['shopName'],
      status: map['status'],
    );
  }
}
