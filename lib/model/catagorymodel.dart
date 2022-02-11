import 'dart:convert';

class CategoryModel {
  String? aboutMenu;
  String? menuID;
  String? publishedDate;
  String? sellerUID;
  String? status;
  String? thumbnail;
  String? title;
  CategoryModel({
    this.aboutMenu,
    this.menuID,
    this.publishedDate,
    this.sellerUID,
    this.status,
    this.thumbnail,
    this.title,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'aboutMenu': aboutMenu,
      'menuID': menuID,
      'publishedDate': publishedDate,
      'sellerUID': sellerUID,
      'status': status,
      'thumbnail': thumbnail,
      'title': title,
    };
  }

  factory CategoryModel.fromMap(Map<String, String> map) {
    return CategoryModel(
      aboutMenu: map['aboutMenu'],
      menuID: map['menuID'],
      publishedDate: map['publishedDate'],
      sellerUID: map['sellerUID'],
      status: map['status'],
      thumbnail: map['thumbnail'],
      title: map['title'],
    );
  }

  
}
