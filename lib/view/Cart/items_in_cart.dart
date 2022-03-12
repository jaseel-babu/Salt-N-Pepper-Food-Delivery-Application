import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_side/controller/cart_controller.dart';
import 'package:user_side/model/global.dart';
import 'package:user_side/model/itemmodel.dart';

class ViewCartItems extends StatefulWidget {
  String? menuID;
  String? sellerUID;
  ItemModel? itemModel;
  ViewCartItems({Key? key, this.sellerUID, this.itemModel, this.menuID})
      : super(key: key);

  @override
  State<ViewCartItems> createState() => _ViewCartItemsState();
}

class _ViewCartItemsState extends State<ViewCartItems> {
  List<int>? separateItemQuantityList;
  num totalAmount = 0;
  @override
  void initState() {
    // TODO: implement initState
    separateItemQuantityList = separateItemQuantities() as List<int>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text(widget.itemModel!.title.toString())),

      // body: CustomScrollView(
      //   slivers: [
      //     //overall total amount

      //     //display cart items with quantity number
      //     Expanded(
      //       flex: 2,
      //       child: StreamBuilder<QuerySnapshot>(
      //         stream: FirebaseFirestore.instance
      //             // .collection("sellers")
      //             // .doc(widget.sellerUID)
      //             // .collection("menus")
      //             // .doc(widget.menuID)
      //             .collection("items")
      //             .where("itemID", whereIn: separateItemIDs())
      //             .orderBy("publishedDate", descending: true)
      //             .snapshots(),
      //         builder: (context, snapshot) {
      //           print(" jjjjjjjjjjjjjjjjjjjjjjj $snapshot.data");
      //           return !snapshot.hasData
      //               ? const SliverToBoxAdapter(
      //                   child: Center(
      //                     child: CircularProgressIndicator(),
      //                   ),
      //                 )
      //               : snapshot.data!.docs.isEmpty
      //                   ? //startBuildingCart()
      //                   Container()
      //                   : SliverList(
      //                       delegate: SliverChildBuilderDelegate(
      //                         (context, index) {
      //                           final ItemModel model = ItemModel.fromMap(
      //                             snapshot.data!.docs[index].data()!
      //                                 as Map<String, String>,
      //                           );
      //                           print(model.title);
      //                           return Text(
      //                             model.title.toString(),
      //                             style: const TextStyle(
      //                               color: Colors.red,
      //                               fontSize: 30,
      //                             ),
      //                           );
      //                           // CartDesign(
      //                           //   itemModel: model,
      //                           //   // context: context,
      //                           //   quantityNo: separateItemQuantityList![index],
      //                           // );
      //                         },
      //                         // childCount: snapshot.hasData
      //                         //     ? snapshot.data!.docs.length
      //                         //     : 0,
      //                       ),
      //                     );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      //////////////////////////////////////////////
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
              child: Container(
                alignment: Alignment.center,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(4.0, 4.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fastfood_sharp,
                      color: Colors.grey,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "My Cart",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("menus")
                  .doc(widget.menuID)
                  .collection("items")
                  .where("itemID", whereIn: separateItemIDs())
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot.data);
                // print(snapshot.data!.docs.length);
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : snapshot.data!.docs.isEmpty
                        ? //startBuildingCart()
                        Container()
                        : ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              final ItemModel model = ItemModel.fromMap(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, String>,
                              );
                              print(model);
                              print(model.title);
                              return Container(
                                color: Colors.red,
                                height: 30,
                                width: 100,
                              );
                            },
                            itemCount: snapshot.hasData
                                ? snapshot.data!.docs.length
                                : 0,
                          );
              },
            ),
      //       //       // StreamBuilder(
      //       //       //   stream: ApiServices().getCartItems(
      //       //       //     widget.sellerUID!,
      //       //       //     widget.menuID,
      //       //       //     widget.itemModel,
      //       //       //   ),
      //       //       //   builder: (context, snapshot) {
      //       //       //     print("hyyyyyyyyyyyyyyyyy $snapshot.data");
      //       //       //     Map<String, dynamic> data = {};
      //       //       //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       //       //       return const Center(
      //       //       //         child: CircularProgressIndicator(),
      //       //       //       );
      //       //       //     }
      //       //       //     if (snapshot.hasData) {
      //       //       //       // data = snapshot.data as Map<String,dynamic>;
      //       //       //       // ignore: cast_nullable_to_non_nullable
      //       //       //       return ListView.builder(
      //       //       //         // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       //       //         //     crossAxisCount: 2),
      //       //       //         physics: const ScrollPhysics(),
      //       //       //         shrinkWrap: true,
      //       //       //         itemCount: data.length,
      //       //       //         itemBuilder: (context, index) {
      //       //       //           // controller.popularImages.add(data[index].thumbnail);
      //       //       //           return CartDesign(
      //       //       //             itemModel: widget.itemModel,
      //       //       //             quantityNo: separateItemQuantityList![index],
      //       //       //           );
      //       //       //           print("sucesssssssssss");
      //       //       //           print(data.length);
      //       //       //         },
      //       //       //       );
      //       //       //     }
      //       //       //     return Container();
      //       //       //   },
      //       //       // ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: const Text(
                "Clear Cart",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.cyan,
              icon: const Icon(Icons.clear_all),
              onPressed: () {},
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: const Text(
                "Check Out",
                style: TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.cyan,
              icon: const Icon(Icons.navigate_next),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
