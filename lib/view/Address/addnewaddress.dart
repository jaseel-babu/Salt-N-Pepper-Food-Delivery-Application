import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:user_side/model/addressmodel.dart';
import 'package:user_side/model/global.dart';
import 'package:user_side/view/Address/text_field.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Position? position;
  List<Placemark>? placemarks;
  String fullAddress = "";

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position = newPosition;

    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    final Placemark pMark = placemarks![0];

    fullAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} , ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    _locationController.text = fullAddress;
    _flatNumber.text =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
    _city.text =
        '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
    _state.text = '${pMark.country}';
    _completeAddress.text = fullAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          "Add New Address",
        ),
        centerTitle: true,
        // actions: [
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 6,
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.black,
                  size: 35,
                ),
                title: SizedBox(
                  width: 250,
                  child: TextField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: _locationController,
                    decoration: const InputDecoration(
                      hintText: "What's your address?",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              ElevatedButton.icon(
                label: const Text(
                  "Get my Location",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  getCurrentLocation();
                },
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                      hint: "Name",
                      controller: _name,
                    ),
                    MyTextField(
                      hint: 'Phone Number',
                      controller: _phoneNumber,
                    ),
                    MyTextField(
                      hint: 'City',
                      controller: _city,
                    ),
                    MyTextField(
                      hint: 'State / Country',
                      controller: _state,
                    ),
                    MyTextField(
                      hint: 'Address Line',
                      controller: _flatNumber,
                    ),
                    MyTextField(
                      hint: 'Complete Address',
                      controller: _completeAddress,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Save"),
        backgroundColor: Colors.red[900],
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final model = Address(
              name: _name.text.trim(),
              state: _state.text.trim(),
              fullAddress: _completeAddress.text.trim(),
              phoneNumber: _phoneNumber.text.trim(),
              flatNumber: _flatNumber.text.trim(),
              city: _city.text.trim(),
              lat: position!.latitude.toString(),
              lng: position!.longitude.toString(),
            ).toJson();

            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set(model)
                .then((value) {
              Fluttertoast.showToast(msg: "New Address added !");
              formKey.currentState!.reset();
            });
          }
        },
      ),
    );
  }
}