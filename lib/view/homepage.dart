import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user_side/consts/sliderimages.dart';
import 'package:user_side/controller/apiservices.dart';
import 'package:user_side/controller/locationControll.dart';
import 'package:user_side/model/sellermodel.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ApiServices apiServices = ApiServices();
  final locationController = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // shrinkWrap: true,
          children: [
            ListTile(
              leading: Icon(
                Icons.format_align_left,
                color: Colors.blue[900],
                size: 30,
              ),
              trailing: GetBuilder<LocationController>(
                builder: (locationController) {
                  return Text(locationController.currentAddress!);
                },
              ),
            ),
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                      height: maxHeight * .5,
                      width: maxWidth * .3,
                      child: CarouselSlider(
                        items: sliderItems.map((index) {
                          return Builder(
                            builder: (context) {
                              return Container(
                                width: maxWidth,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                ),
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
                        }).toList(),
                        options: CarouselOptions(
                          height: 500,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                          autoPlayCurve: Curves.decelerate,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: const TextField(
                decoration: InputDecoration(
                  label: Text("Search Your Favourite Resturent"),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            StreamBuilder(
              stream: apiServices.getData(),
              builder: (context, snapshot) {
                List<SellerModel> data = [];
                if (snapshot.hasData) {
                  data = snapshot.data as List<SellerModel>;

                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
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
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
