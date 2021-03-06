import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/apiservices.dart';
import 'package:user_side/model/catagorymodel.dart';
import 'package:user_side/model/itemmodel.dart';
import 'package:user_side/view/items/itemdetail.dart';

// ignore: must_be_immutable
class ItemsPage extends StatelessWidget {
  ItemsPage({Key? key, required this.datas, required this.sellerId})
      : super(key: key);
  CategoryModel datas;

  String? sellerId;
  //  var controller = Get.put(LoginController());
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Itemsss",
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: apiServices.getItems(sellerId!, datas.menuID!),
          builder: (context, snapshot) {
            // print( "hyyyyyyyyyyyyyyyyy $snapshot.data");
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
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => ItemDetailPage(
                          itemDetail: data[index],
                          menuID: datas.menuID,
                        ),
                      );
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 40, right: 40, top: 20),
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
                                    offset: const Offset(10.0, 10.0),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    color: Colors.blue.shade100,
                                  ),
                                  BoxShadow(
                                    offset: const Offset(-10.0, -10.0),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    color: Colors.blue.shade100,
                                  ),
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
                          Text(
                            data[index].title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            data[index].aboutItem!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
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
