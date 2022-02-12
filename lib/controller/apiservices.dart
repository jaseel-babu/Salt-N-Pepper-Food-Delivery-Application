import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_side/model/catagorymodel.dart';
import 'package:user_side/model/sellermodel.dart';

class ApiServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<SellerModel> storeDetails(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return SellerModel(
        address: (e.data() as dynamic)["address"].toString(),
        earnigs: (e.data() as dynamic)["earnigs"].toString(),
        lat: (e.data() as dynamic)["lat"].toString(),
        lng: (e.data() as dynamic)["lng"].toString(),
        phone: (e.data() as dynamic)["phone"].toString(),
        sellerName: (e.data() as dynamic)["sellerName"].toString(),
        sellerUID: (e.data() as dynamic)["sellerUID"].toString(),
        shopName: (e.data() as dynamic)["shopName"].toString(),
        status: (e.data() as dynamic)["status"].toString(),
      );
    }).toList();
  }

  List<CategoryModel> menuItems(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (e) {
        return CategoryModel(
          aboutMenu: (e.data() as dynamic)["aboutMenu"].toString(),
          menuID: (e.data() as dynamic)["menuID"].toString(),
          publishedDate: (e.data() as dynamic)["publishedDate"].toString(),
          sellerUID: (e.data() as dynamic)["sellerUID"].toString(),
          thumbnail: (e.data() as dynamic)["thumbnail"].toString(),
          status: (e.data() as dynamic)["status"].toString(),
          title: (e.data() as dynamic)["title"].toString(),
        );
      },
    ).toList();
  }

  Stream getStroreDetails() {
    return firebaseFirestore
        .collection("sellers")
        .snapshots()
        .map(storeDetails);
  }

  Stream getMenus(String uid) {
    return firebaseFirestore
        .collection("sellers")
        .doc(uid)
        .collection("menus")
        .snapshots()
        .map(menuItems);
  }
}
