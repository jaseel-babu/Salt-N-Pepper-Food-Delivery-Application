import 'package:get/get.dart';

class AddressChangerController extends GetxController {
  int _counter = 0;
  int get count => _counter;

  // ignore: always_declare_return_types, type_annotate_public_apis
  displayResult(int newValue) {
    _counter = newValue;
    update();
  }
}
