import 'package:get/get.dart';

class AddressChangerController extends GetxController {
  int _counter = 0;
  int get count => _counter;

   displayResult(int newValue)
  {
    _counter = newValue;
    update();
  }
}
