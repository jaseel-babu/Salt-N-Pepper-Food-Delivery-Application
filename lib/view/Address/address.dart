import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/view/Address/addnewaddress.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          "Address",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 15),
              child: Text(
                "Select Address",
                style: TextStyle(
                  shadows: [
                    Shadow(offset: Offset(0, -10)),
                  ],
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  decorationThickness: 3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.transparent,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Shebin PR",
                              style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Phone Number: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "91 7559074583",
                              style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Flat Number: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "12 B",
                              style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "City: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "kochi",
                              style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "State: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Kerala",
                              style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Full Address: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Skyline 12 B, Kakkanad, Kochi , Kerala",
                              style: TextStyle(
                                color: Colors.brown[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection("users")
            //       .doc(sharedPreferences!.getString("uid"))
            //       .collection("useraddress")
            //       .snapshots(),
            //   builder: (context, snapshot) {
            //     List<String> data = [];
            //     // ignore: cast_nullable_to_non_nullable
            //     data = snapshot.data as List<String>;
            //     return !snapshot.hasData
            // ? const Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : ListView.builder(
            //             itemCount: data.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return Container();
            //             },
            //           );
            //   },
            // ),
            // AdressDesign()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add New Address"),
        backgroundColor: Colors.red[900],
        icon: const Icon(
          Icons.add_location,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => const AddNewAddress());
        },
      ),
    );
  }
}
