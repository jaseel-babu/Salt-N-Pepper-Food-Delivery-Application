import 'dart:convert';

class SellerModel {
  String? address;
  String? earnigs;
  String? lat;
  String? lng;
  String? phone;
  String? sellerName;
  String? sellerUid;
  String? shopName;
  String? status;
  SellerModel({
    this.address,
    this.earnigs,
    this.lat,
    this.lng,
    this.phone,
    this.sellerName,
    this.sellerUid,
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
      'sellerUid': sellerUid,
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
      sellerUid: map['sellerUid'],
      shopName: map['shopName'],
      status: map['status'],
    );
  }
}
