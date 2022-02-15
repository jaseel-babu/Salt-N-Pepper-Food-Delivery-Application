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
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2),
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  List sizeChart = data[index].size!.keys.toList();
                  // controller.popularImages.add(data[index].thumbnail);
                  return Container(
                    margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: Colors.blue[50],
                    ),
                    width: maxWidth,
                    height: maxHeight * .8,
                    child: Column(
                      //  alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            alignment: Alignment.center,
                            height: maxHeight * .45,
                            width: maxWidth * .45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10.0, 10.0),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    color: Colors.blue.shade100),
                                BoxShadow(
                                    offset: Offset(-10.0, -10.0),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    color: Colors.blue.shade100),
                              ],
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SizedBox(
                              width: maxWidth * .4,
                              height: maxHeight * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  data[index].thumbnail!,
                                  fit: BoxFit.cover,
                                  frameBuilder: (
                                    context,
                                    child,
                                    frame,
                                    wasSynchronouslyLoaded,
                                  ) =>
                                      child,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
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
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            data[index].title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,),
                          ),
                        ),
                      ],
                    ),
                  );
                  //  ListTile(
                  //   title: SizedBox(
                  //     width: 100,
                  //     child: Text(
                  //       data[index].title!,
                  //       maxLines: 1,
                  //       overflow: TextOverflow.ellipsis,
                  //       style: const TextStyle(
                  //           fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  //     ),
                  //   ),
                  //   subtitle: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       ...sizeChart.map(
                  //         (e) {
                  //           return Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 e.toString(),
                  //                 style: const TextStyle(color: Colors.black),
                  //               ),
                  //               Text(
                  //                 " ${data[index].size![e]}",
                  //                 style: const TextStyle(color: Colors.black),
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       )
                  //     ],
                  //   ),
                  //   leading: SizedBox(
                  //     width: 50,
                  //     height: 50,
                  //     child: ClipRRect(
                  //       child: Image.network(
                  //         data[index].thumbnail!,
                  //         fit: BoxFit.fill,
                  //         frameBuilder: (
                  //           context,
                  //           child,
                  //           frame,
                  //           wasSynchronouslyLoaded,
                  //         ) =>
                  //             child,
                  //         loadingBuilder: (context, child, loadingProgress) {
                  //           if (loadingProgress == null) {
                  //             return child;
                  //           }

                  //           return const Center(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),

                  // );
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
