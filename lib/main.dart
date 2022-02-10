import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/controller.dart';
import 'package:user_side/view/homepage.dart';
import 'package:user_side/view/login/loginPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var controlller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    print(controlller.userIsAlreadyLogin);
    return GetBuilder<LoginController>(
     
      builder: (controller) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: controlller.userIsAlreadyLogin == true ? HomePage() : LoginPage(),
        );
      },
    );
  }
}
