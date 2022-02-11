import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/apiservices.dart';
import 'package:user_side/controller/controller.dart';
import 'package:user_side/model/catagorymodel.dart';
import 'package:user_side/model/sellermodel.dart';

class MenusPage extends StatelessWidget {
  MenusPage({Key? key, required this.sellerModel}) : super(key: key);
  SellerModel sellerModel;
  var controller = Get.put(LoginController());
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    print(sellerModel.sellerUID);
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: apiServices.getMenus(sellerModel.sellerUID!),
          builder: (context, snapshot) {
            List<CategoryModel> data = [];
            if (snapshot.hasData) {
              data = snapshot.data as List<CategoryModel>;
              print(data.first.title);
              return ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  controller.popularImages.add(data[index].thumbnail);
                  return Card(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        FadeInImage.assetNetwork(placeholder: "assets/slider/23.jpg", image: data[index].thumbnail!),
                        // Image.network(
                        //   data[index].thumbnail!,
                        // ),
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
