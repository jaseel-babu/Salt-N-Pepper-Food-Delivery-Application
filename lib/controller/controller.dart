import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool? userIsAlreadyLogin;
  String verificationId = "";
  List popularImages = [];
  @override
  void onInit() {
    checkLoginOrNot();
    super.onInit();
  }

  checkLoginOrNot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userIsAlreadyLogin = prefs.getBool("login");
    update();
  }
}
