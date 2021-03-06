import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/apiservices.dart';
import 'package:user_side/controller/controller.dart';
import 'package:user_side/model/catagorymodel.dart';
import 'package:user_side/model/sellermodel.dart';
import 'package:user_side/view/items/items.dart';

// ignore: must_be_immutable
class MenusPage extends StatelessWidget {
  MenusPage({Key? key, required this.sellerModel}) : super(key: key);
  SellerModel sellerModel;
  LoginController controller = Get.put(LoginController());
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            sellerModel.shopName!,
            style: TextStyle(color: Colors.blue[900], fontSize: 20),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
          stream: apiServices.getMenus(sellerModel.sellerUID!),
          builder: (context, snapshot) {
            List<CategoryModel> data = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              data = snapshot.data as List<CategoryModel>;

              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  controller.popularImages.add(data[index].thumbnail);
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ItemsPage(
                          datas: data[index],
                          sellerId: sellerModel.sellerUID,
                        ),
                      );
                    },
                    child: Card(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          SizedBox(
                            width: maxWidth,
                            height: maxHeight * .3,
                            child: Image.network(
                              data[index].thumbnail!,
                              fit: BoxFit.fill,
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
                          Container(
                            height: maxHeight * 0.1,
                            width: maxWidth,
                            color: Colors.black.withOpacity(0.6),
                            child: Center(
                              child: Text(
                                data[index].title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
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
