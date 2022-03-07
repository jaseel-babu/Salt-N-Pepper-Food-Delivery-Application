import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_side/controller/apiservices.dart';
import 'package:user_side/controller/cart_controller.dart';
import 'package:user_side/model/itemmodel.dart';
import 'package:user_side/view/Cart/cart_design.dart';

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
            StreamBuilder(
              stream: ApiServices().getCartItems(
                widget.sellerUID!,
                widget.menuID,
                widget.itemModel,
              ),
              builder: (context, snapshot) {
                List<ItemModel> data = [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  // ignore: cast_nullable_to_non_nullable
                  data = snapshot.data as List<ItemModel>;
                  return ListView.builder(
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      // controller.popularImages.add(data[index].thumbnail);
                      return CartDesign(
                        itemModel: widget.itemModel,
                        quantityNo: separateItemQuantityList![index],
                      );
                      print("sucesssssssssss");
                      print(data.length);
                    },
                  );
                }
                return Container();
              },
            ),
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
