import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/model/catagorymodel.dart';
import 'package:user_side/model/itemmodel.dart';

import '../../controller/apiservices.dart';
import '../../model/sellermodel.dart';

class ItemsPage extends StatelessWidget {
  ItemsPage({Key? key, required this.data, required this.sellerId})
      : super(key: key);
  CategoryModel data;

  String? sellerId;
  //  var controller = Get.put(LoginController());
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: apiServices.getItems(sellerId!, data.menuID!),
          builder: (context, snapshot) {
            List<ItemModel> data = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              data = snapshot.data as List<ItemModel>;

              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // controller.popularImages.add(data[index].thumbnail);
                  return ListTile(
                      title: SizedBox(
                        width: 100,
                        child: Text(
                          data[index].title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 0.5),
                        ),
                      ),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "INR ${data[index].size!["full"]}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  " ${data[index].discription}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            )
                          ],
                          ),

                      // Card(
                      //   child: Stack(
                      //     alignment: AlignmentDirectional.bottomCenter,
                      //     children: [
                      //       Container(
                      //         width: maxWidth,
                      //         height: maxHeight * .5,
                      //         child: Image.network(
                      //           data[index].thumbnail!,
                      //           fit: BoxFit.fill,
                      //           frameBuilder: (
                      //             context,
                      //             child,
                      //             frame,
                      //             wasSynchronouslyLoaded,
                      //           ) =>
                      //               child,
                      //           loadingBuilder: (context, child, loadingProgress) {
                      //             if (loadingProgress == null) {
                      //               return child;
                      //             }
                      //             return const Center(
                      //               child: CircularProgressIndicator(),
                      //             );
                      //           },
                      //         ),
                      //       ),
                      //       Container(
                      //         height: maxHeight * 0.1,
                      //         width: maxWidth,
                      //         color: Colors.black.withOpacity(0.6),
                      //         child: Center(
                      //           child: Text(
                      //             data[index].title!,
                      //             style: const TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 22,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // );

                      );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
