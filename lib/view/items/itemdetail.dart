import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:user_side/controller/cart_controller.dart';
import 'package:user_side/controller/cart_item_counter.dart';
import 'package:user_side/model/itemmodel.dart';
import 'package:user_side/view/Address/address.dart';
import 'package:user_side/view/Cart/items_in_cart.dart';

// ignore: must_be_immutable
class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({Key? key, required this.itemDetail, this.menuID})
      : super(key: key);
  ItemModel itemDetail;
  String? menuID;

  TextEditingController counterTextEditingController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final cartItemCounter = Get.put(CartItemCounterController());

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    final List sizeChart = itemDetail.size!.keys.toList();

    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          itemDetail.title.toString(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => ViewCartItems(
                  sellerUID: itemDetail.sellerUID,
                  itemModel: itemDetail,
                  menuID: menuID,
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
              // size: 30,
              color: Colors.black,
            ),
          ),
          GetBuilder<CartItemCounterController>(
            id: const ["counter"],
            builder: (_controller) {
              return Stack(
                children: [
                  const Icon(
                    Icons.brightness_1,
                    size: 25,
                    color: Colors.black,
                  ),
                  Positioned(
                    top: 5,
                    right: 9,
                    child: Center(
                      child: Text(
                        _controller.count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        // child: Center(
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(33),
        //             color: Colors.blueAccent.shade200,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.blueAccent.shade100,
        //                 offset: const Offset(5.0, 5.0),
        //                 blurRadius: 25.0,
        //                 spreadRadius: 1.0,
        //               ),
        //               BoxShadow(
        //                 color: Colors.blueAccent.shade100,
        //                 offset: const Offset(-4.0, -4.0),
        //                 blurRadius: 6.0,
        //                 spreadRadius: 1.0,
        //               )
        //             ],
        //           ),
        //           child: ClipPath(
        //             clipper: BackgroundClipper(),
        //             child: Container(
        //               // alignment: Alignment.center,
        //               width: MediaQuery.of(context).size.width * 0.8,
        //               height: MediaQuery.of(context).size.height * 0.6,
        //               decoration: BoxDecoration(
        //                 color: Colors.blue.shade100,
        //               ),
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(10),
        //                 child: Image.network(
        //                   // ignore: noop_primitive_operations
        //                   itemDetail.thumbnail!.toString(),
        //                   fit: BoxFit.fitWidth,
        //                   frameBuilder: (
        //                     context,
        //                     child,
        //                     frame,
        //                     wasSynchronouslyLoaded,
        //                   ) =>
        //                       child,
        //                   loadingBuilder: (context, child, loadingProgress) {
        //                     if (loadingProgress == null) {
        //                       return child;
        //                     }

        //                     return const Center(
        //                       child: CircularProgressIndicator(),
        //                     );
        //                   },
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
                  fit: BoxFit.fill,
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
                    style: TextStyle(
                      color: Colors.blue.shade900,
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
                        height: 50,
                        width: 130,
                        child: NumberInputPrefabbed.roundedButtons(
                          scaleHeight: 0.7,
                          scaleWidth: 0.7,
                          widgetContainerDecoration: BoxDecoration(
                            color: Colors.blue[900],
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
                          final int itemCounter =
                              int.parse(counterTextEditingController.text);

                          final List<String> separateItemIDsList =
                              separateItemIDs();

                          print("seperated$separateItemIDsList");
                          print("current${itemDetail.itemId}");

                          if (separateItemIDsList.contains(itemDetail.itemId)) {
                            Fluttertoast.showToast(
                              msg: "item already exist in cart",
                            );
                          } else {
                            addToCart(itemDetail.itemId!, itemCounter);
                          }

                          separateItemIDsList
                                  .where(
                                    (element) => element == itemDetail.itemId,
                                  )
                                  .isEmpty
                              ? addToCart(itemDetail.itemId!, itemCounter)
                              : Fluttertoast.showToast(
                                  msg: "item already exist in cart",
                                );

                          separateItemIDsList.contains(itemDetail.itemId)
                              ? Fluttertoast.showToast(
                                  msg: "Item Already Exist",
                                )
                              : addToCart(
                                  itemDetail.itemId!,
                                  itemCounter,
                                );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                        ),
                        child: const Text("Add to cart"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const AddressScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade900,
                        ),
                        child: const Text("Check Out"),
                      ),
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
