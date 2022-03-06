import 'package:get/get.dart';
import 'package:user_side/model/global.dart';

class CartItemCounterController extends GetxController {
  int cartCounter = sharedPreferences!.getStringList("userCart")!.length - 1;
  int get count => cartCounter;

  Future<void> displayCartListCounter() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      update();
    });
  }
}
