class ItemModel {
  String? aboutItem;
  String? discription;
  String? itemId;
  String? publishedDate;
  String? sellerUID;
  Map? size;
  String? status;
  String? thumbnail;
  String? title;
  ItemModel({
    this.aboutItem,
    this.discription,
    this.itemId,
    this.publishedDate,
    this.sellerUID,
    this.size,
    this.status,
    this.thumbnail,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'aboutItem': aboutItem,
      'discription': discription,
      'itemId': itemId,
      'publishedDate': publishedDate,
      'sellerUID': sellerUID,
      'size': size,
      'status': status,
      'thumbnail': thumbnail,
      'title': title,
    };
  }

  factory ItemModel.fromMap(Map<String, String> map) {
    return ItemModel(
      aboutItem: map['aboutItem'].toString(),
      discription: map['discription'],
      itemId: map['itemId'],
      publishedDate: map['publishedDate'],
      sellerUID: map['sellerUID'],
      // ignore: cast_nullable_to_non_nullable
      size: map['size'] as Map,
      status: map['status'],
      thumbnail: map['thumbnail'],
      title: map['title'],
    );
  }
}
