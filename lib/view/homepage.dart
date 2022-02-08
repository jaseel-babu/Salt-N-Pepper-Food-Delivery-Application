import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/locationControll.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

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
          ],
        ),
      ),
    );
  }
}
