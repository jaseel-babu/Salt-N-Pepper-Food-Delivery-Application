import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.grey[100],
      // extendBodyBehindAppBar: true,

      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded(
              //   // flex: 1,
              //   child: CustomScrollView(
              //     shrinkWrap: true,
              //     slivers: [
              //       SliverToBoxAdapter(
              //         child: Padding(
              //           padding: const EdgeInsets.all(10.0),
              //           child: SizedBox(
              //             height: maxHeight * .3,
              //             width: maxWidth * .3,
              //             child: CarouselSlider(
              //               items: sliderItems.map(
              //                 (index) {
              //                   return Builder(
              //                     builder: (context) {
              //                       return SizedBox(
              //                         width: maxWidth,
              //                         child: Padding(
              //                           padding: const EdgeInsets.all(2.0),
              //                           child: Image.asset(
              //                             index,
              //                             fit: BoxFit.cover,
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   );
              //                 },
              //               ).toList(),
              //               options: CarouselOptions(
              //                 height: 500,
              //                 autoPlay: true,
              //                 autoPlayInterval: const Duration(seconds: 3),
              //                 autoPlayAnimationDuration:
              //                     const Duration(milliseconds: 500),
              //                 autoPlayCurve: Curves.decelerate,
              //                 enlargeCenterPage: true,
              //               ),
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),😋🍔
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey.shade400),
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(4.0, 4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 2.0,
                          spreadRadius: 1.0,
                        )
                      ],
                    ),
                    child: Builder(
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(
                            Icons.format_align_left,
                            size: 23,
                          ),
                          color: Colors.blue[900],
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue[900],
                        size: 23,
                      ),
                      GetBuilder<LocationController>(
                        builder: (locationController) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                locationController.currentAddress!,
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(right: 95, top: 20),
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                      ),
                      Text(
                        'Heyyo Foodiee . . !',
                        style: GoogleFonts.aBeeZee(
                          color: Colors.teal.shade300,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Be proud to be a \nFoodaholic. . .",
                        style: TextStyle(
                          color: Colors.teal.shade300,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyan.shade100,
                        offset: const Offset(4.0, 4.0),
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                      )
                    ],
                  ),
                  child: const TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      label: Text("Search Your Favourite Restaurent"),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Image.asset(
                                  sliderItems[sliderItems.length - 1 - index],
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
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   alignment: Alignment.center,
      //   height: 70,
      //   width: 240,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     color: Colors.grey[100],
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.blueGrey.shade300,
      //         offset: const Offset(4.0, 4.0),
      //         blurRadius: 15.0,
      //         spreadRadius: 1.0,
      //       ),
      //       const BoxShadow(
      //         color: Colors.white,
      //         offset: Offset(-4.0, -4.0),
      //         blurRadius: 5.0,
      //         spreadRadius: 1.0,
      //       )
      //     ],
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         height: 40,
      //         width: 90,
      //         decoration: BoxDecoration(
      //           gradient: const LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //             colors: [
      //               Color(0xff333399),
      //               Color(0xffC33764),
      //             ],
      //           ),
      //           borderRadius: BorderRadius.circular(4),
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: const [
      //             Icon(
      //               Icons.home_outlined,
      //               color: Colors.white,
      //             ),
      //             VerticalDivider(
      //               color: Colors.white,
      //               thickness: 1,
      //               indent: 10,
      //               endIndent: 10,
      //             ),
      //             Text(
      //               "Home",
      //               style: TextStyle(color: Colors.white),
      //             )
      //           ],
      //         ),
      //       ),
      //       Container(
      //         alignment: Alignment.center,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             IconButton(
      //               onPressed: () {},
      //               icon: IconButton(
      //                 color: Colors.grey.shade700,
      //                 icon: const Icon(
      //                   Icons.shopify_sharp,
      //                 ),
      //                 onPressed: () {},
      //               ),
      //             ),
      //             IconButton(
      //               onPressed: () {},
      //               icon: Icon(
      //                 Icons.settings,
      //                 color: Colors.grey.shade700,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
