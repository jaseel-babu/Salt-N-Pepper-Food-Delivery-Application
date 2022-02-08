import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Position? currentPosition;
  String? currentAddress = "";
  @override
  void onInit() {
    _currentPosition();
    super.onInit();
  }

  Future<Position> getPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return Geolocator.getCurrentPosition(
       desiredAccuracy : LocationAccuracy.bestForNavigation);
  }

  getAddress(double latitude, double longitude) async {
    try {
      final List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);
      final Placemark place = placemark[0];
      print(placemark[0]);
      update();
      currentAddress = place.locality;
    } catch (e) {
      print(e);
    }
  }

  _currentPosition() async {
    currentPosition = await getPosition();
    getAddress(currentPosition!.latitude, currentPosition!.longitude);
    update();
  }
}
