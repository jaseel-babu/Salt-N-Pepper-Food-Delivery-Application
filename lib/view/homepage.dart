import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              trailing: GetBuilder<LocationController>(
                builder: (locationController) {
                  return Text(locationController.currentAddress!);
                },
              ),
            ),
            StreamBuilder(
              stream: apiServices.getData(),
              builder: (context, snapshot) {
                List<SellerModel> data = [];
                if (snapshot.hasData) {
                  data = snapshot.data as List<SellerModel>;
                  print(data[0].sellerName);
                  return ListView.builder(shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Text(data[index].sellerName!);
                    },
                  );
                }
                return const Text('false');
              },
            )
          ],
        ),
      ),
    );
  }
}
