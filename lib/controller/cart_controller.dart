import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/cart_item_counter.dart';
import 'package:user_side/model/global.dart';

final cartItemCounter = Get.put(CartItemCounterController());

final FirebaseAuth _auth = FirebaseAuth.instance;

// ignore: type_annotate_public_apis
void addToCart(String foodItemID, int itemCounter) {
  final List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add("$foodItemID : $itemCounter");

  // final Map<String, dynamic> cartItems = {"userCart": tempList};

  FirebaseFirestore.instance
      .collection("users")
      .doc(_auth.currentUser!.uid)
      .update({"userCart": tempList}).then((value) {
    Fluttertoast.showToast(msg: "Item added successfully");

    sharedPreferences!.setStringList("userCart", tempList);
    cartItemCounter.displayCartListCounter();
    cartItemCounter.update();
  });
  // sharedPreferences!.setString("UserCart", tempList.toString());
}

List<String> separateItemIDs() {
  final List<String> separateItemIDsList = [];

  List<String> defaultItemList = [];

  int i = 0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i = 0; i < defaultItemList.length; i++) {
    //56557657:7
    final String item = defaultItemList[i];
    final pos = item.lastIndexOf(":");

    //56557657
    final String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
  }
  cartItemCounter.update();
  print("\nThis is Items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}

separateItemQuantities() {
 final List<int> separateItemQuantityList = [];
  List<String> defaultItemList = [];
  int i = 1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for (i; i < defaultItemList.length; i++) {
    //56557657:7
    String item = defaultItemList[i].toString();

    //0=:
    //1=7
    //:7
    List<String> listItemCharacters = item.split(":").toList();

    //7
    var quanNumber = int.parse(listItemCharacters[1].toString());

    print("\nThis is Quantity Number = " + quanNumber.toString());

    separateItemQuantityList.add(quanNumber);
  }

  print("\nThis is Quantity List now = ");
  print(separateItemQuantityList);

  return separateItemQuantityList;
}
