import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:user_side/model/itemmodel.dart';
import 'package:user_side/view/Address/address.dart';

// ignore: must_be_immutable
class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({Key? key, required this.itemDetail}) : super(key: key);
  ItemModel itemDetail;

  TextEditingController counterTextEditingController = TextEditingController();

  // addToCart(String foodItemID, BuildContext context, int itemCounter) {
  //   List<String>? tempList = sharedPreferences!.getStringList("userCart");
  //   tempList!.add("$foodItemID:$itemCounter");

  //   FirebaseFirestore.instance.collection("users").doc();
  //   sharedPreferences!.setString("UserCart", tempList.toString());
  // }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    final List sizeChart = itemDetail.size!.keys.toList();

    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(
          itemDetail.title.toString(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
              // size: 30,
              color: Colors.black,
            ),
          ),
          Stack(
            children: const [
              Icon(
                Icons.brightness_1,
                size: 20,
                color: Colors.black,
              ),
              Positioned(
                top: 3,
                right: 6,
                child: Center(
                  child: Text(
                    "0",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: maxWidth,
              height: maxHeight / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  // ignore: noop_primitive_operations
                  itemDetail.thumbnail!.toString(),
                  fit: BoxFit.cover,
                  frameBuilder: (
                    context,
                    child,
                    frame,
                    wasSynchronouslyLoaded,
                  ) =>
                      child,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // color: Colors.lightBlue,
                    // width: 60,
                    child: Text(
                      itemDetail.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...sizeChart.map(
                    (e) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹ ${itemDetail.size![e]}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    itemDetail.aboutItem.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    itemDetail.discription.toString(),
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 70,
                        width: 130,
                        child: NumberInputPrefabbed.roundedButtons(
                          scaleHeight: 0.7,
                          scaleWidth: 0.7,
                          widgetContainerDecoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          controller: counterTextEditingController,
                          incDecBgColor: Colors.white,
                          min: 1,
                          max: 9,
                          initialValue: 1,
                          buttonArrangement: ButtonArrangement.incRightDecLeft,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const AddressScreen());
                          // final int itemCounter =
                          //     int.parse(counterTextEditingController.text);
                          // addToCart(itemDetail.itemId!, context, itemCounter);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                        ),
                        child: const Text("Buy"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
