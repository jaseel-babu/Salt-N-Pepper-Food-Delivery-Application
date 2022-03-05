import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/consts/sliderimages.dart';
import 'package:user_side/controller/apiservices.dart';
import 'package:user_side/controller/locationControll.dart';
import 'package:user_side/model/sellermodel.dart';
import 'package:user_side/view/menus/menus.dart';
import 'package:user_side/view/widgets/drawer.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ApiServices apiServices = ApiServices();

  final locationController = Get.put(LocationController());

  /// this is homescreen//////////////////////////////////////
  ///
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        excludeHeaderSemantics: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.format_align_left,
                size: 30,
              ),
              color: Colors.blue[900],
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          Icon(
            Icons.location_on_outlined,
            color: Colors.blue[900],
            size: 30,
          ),
          GetBuilder<LocationController>(
            builder: (locationController) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    locationController.currentAddress!,
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // flex: 1,
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: maxHeight * .3,
                        width: maxWidth * .3,
                        child: CarouselSlider(
                          items: sliderItems.map(
                            (index) {
                              return Builder(
                                builder: (context) {
                                  return SizedBox(
                                    width: maxWidth,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Image.asset(
                                        index,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            height: 500,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 500),
                            autoPlayCurve: Curves.decelerate,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      // color: Colors.blueAccent[100],
                      ),
                  // color: Colors.blue,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(30),
                        child: const TextField(
                          decoration: InputDecoration(
                            label: Text("Search Your Favourite Restaurent"),
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      StreamBuilder(
                        stream: apiServices.getStroreDetails(),
                        builder: (context, snapshot) {
                          List<SellerModel> data = [];
                          if (snapshot.hasData) {
                            // ignore: cast_nullable_to_non_nullable
                            data = snapshot.data as List<SellerModel>;

                            return ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => MenusPage(
                                        sellerModel: data[index],
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        Image.asset(
                                          sliderItems[
                                              sliderItems.length - 1 - index],
                                        ),
                                        Container(
                                          height: maxHeight * 0.1,
                                          width: maxWidth,
                                          color: Colors.black.withOpacity(0.6),
                                          child: Center(
                                            child: Text(
                                              data[index].shopName!,
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
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
