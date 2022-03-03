import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/controller.dart';
import 'package:user_side/view/login/verification.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  var controller = Get.put(LoginController());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  PhoneVerificationCompleted? verificationCompleted;
  PhoneVerificationFailed? verificationFailed;
  PhoneCodeAutoRetrievalTimeout? codeAutoRetrievalTimeout;
  PhoneCodeSent? codeSent;
  final TextEditingController mobileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async {
      UserCredential a = await _auth.signInWithCredential(phoneAuthCredential);
    };

    codeSent = (String? verificationId, [int? forceResendingToken]) async {
      // print("check your phone");
      controller.verificationId = verificationId!;
      Get.off(() => Verification());
      // print(controller.verificationId);///
    };

    verificationFailed = (FirebaseAuthException authException) {
      Get.snackbar(
        "Failed",
        "Please Enter valid Mobile Number",
        snackPosition: SnackPosition.BOTTOM,
      );
      // print(authException.message);
    };

    codeAutoRetrievalTimeout = (String verificationId) {
      controller.verificationId = verificationId;
      // print(controller.verificationId);
    };

    final oriantion = MediaQuery.of(context).orientation;
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: oriantion == Orientation.portrait || maxWidth <= 650
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: maxWidth,
                  height: maxHeight,
                  child: ListView(
                    children: [
                      // loginimg(maxHeight / 2),
                      field(context, maxWidth),
                    ],
                  ),
                ),
              )
            : Row(
                children: [
                  loginimg(maxHeight),
                  Expanded(
                    child: SizedBox(
                      height: maxHeight / 1.2,
                      child: field(context, maxWidth),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  ListView field(BuildContext context, double maxWidth) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "ENTER YOUR MOBILE NUMBER",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.grey,
              child: TextFormField(
                controller: mobileNoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Your Mobile Number";
                  } else if (value.length != 10) {
                    return "Enter Valid Mobile Number";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: maxWidth / 1.4,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String number = ("+91" + mobileNoController.text);
                try {
                  await _auth.verifyPhoneNumber(
                    phoneNumber: number,
                    timeout: const Duration(seconds: 5),
                    verificationCompleted: verificationCompleted!,
                    verificationFailed: verificationFailed!,
                    codeSent: codeSent!,
                    codeAutoRetrievalTimeout: codeAutoRetrievalTimeout!,
                  );
                } catch (e) {
                  print("Failed to Verify Phone Number: ${e}");
                }
              }
            },
            child: const Text("Login With Otp"),
          ),
        )
      ],
    );
  }

  SizedBox loginimg(double maxHeight) {
    return SizedBox(
      height: maxHeight,
      child: Image.asset(
        "assets/images/Mobile login-bro (1).png",
      ),
    );
  }
}
