import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_side/model/global.dart';

separateItemIDs()
{
  List<String> separateItemIDsList=[], defaultItemList=[];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    //56557657:7
    String item = defaultItemList[i].toString();
    var pos = item.lastIndexOf(":");

            //56557657
    String getItemId = (pos != -1) ? item.substring(0, pos) : item;

    print("\nThis is itemID now = " + getItemId);

    separateItemIDsList.add(getItemId);
  }

  print("\nThis is Items List now = ");
  print(separateItemIDsList);

  return separateItemIDsList;
}

    final FirebaseAuth _auth = FirebaseAuth.instance;

 addToCart(String foodItemID,  context, int itemCounter) {
    List<String>? tempList = sharedPreferences!.getStringList("userCart");
    tempList!.add("$foodItemID : $itemCounter");

    Map<String, dynamic> cartItems = {"userCart": tempList};

    FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .update(cartItems)
        .then((value) {
      Fluttertoast.showToast(msg: "Item added successfully");

      sharedPreferences!.setStringList("userCart", tempList);
    });
    // sharedPreferences!.setString("UserCart", tempList.toString());
  }
  
