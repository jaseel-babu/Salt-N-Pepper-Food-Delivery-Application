import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/view/Homepage/homepage.dart';
import 'package:user_side/view/login/loginpage.dart';
import 'package:user_side/view/widgets/test.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: RichText(
              text: const TextSpan(
                text: "Salt",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  letterSpacing: 0.5,
                ),
                children: [
                  TextSpan(
                    text: " N ",
                    style: TextStyle(color: Colors.red),
                  ),
                  TextSpan(
                    text: "Pepper",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.home,
                      color: Colors.blueGrey[900],
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(() => const ClippingSample());
                  },
                  leading: Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.blueGrey[900],
                  ),
                  title: Text(
                    "My Earnings",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                 
                  },
                  leading: Icon(
                    Icons.delivery_dining_rounded,
                    color: Colors.blueGrey[900],
                  ),
                  title: Text(
                    "Orders",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.settings_sharp,
                    color: Colors.blueGrey[900],
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await _auth.signOut();
                    Get.offAll(() => LoginPage());
                  },
                  leading: Icon(
                    Icons.logout_rounded,
                    color: Colors.blueGrey[900],
                  ),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
