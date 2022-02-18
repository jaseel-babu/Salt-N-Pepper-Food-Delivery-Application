import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_side/model/catagorymodel.dart';
import 'package:user_side/model/itemmodel.dart';
import 'package:user_side/model/sellermodel.dart';

class ApiServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  //////////Fetch Store Details//////
  
  Stream getStroreDetails() {
    return firebaseFirestore
        .collection("sellers")
        .snapshots()
        .map(storeDetails);
  }
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
 //////////Fetch Menu Items//////
  Stream getMenus(String uid) {
    return firebaseFirestore
        .collection("sellers")
        .doc(uid)
        .collection("menus")
        .snapshots()
        .map(menuItems);
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
   //////////Fetch Items//////
    Stream getItems(String uid,String MenuId) {
    return firebaseFirestore
        .collection("sellers")
        .doc(uid)
        .collection("menus").doc(MenuId).collection("items")
        .snapshots()
        .map(items);
  }List<ItemModel> items(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (e) {
        return ItemModel(discription: (e.data() as dynamic)["discription"].toString() ,
          aboutItem: (e.data() as dynamic)["aboutItem"].toString(),
          itemId: (e.data() as dynamic)["itemID"].toString(),
          publishedDate: (e.data() as dynamic)["publishedDate"].toString(),
          sellerUID: (e.data() as dynamic)["sellerUID"].toString(),
          thumbnail: (e.data() as dynamic)["thumbnail"].toString(),
          status: (e.data() as dynamic)["status"].toString(),
          title: (e.data() as dynamic)["title"].toString(),
          size: (e.data() as dynamic)["size"]as Map,
        );
      },
    ).toList();
  }

}
