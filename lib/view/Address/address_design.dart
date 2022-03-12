import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_side/controller/addresschanger.dart';
import 'package:user_side/model/addressmodel.dart';

class AdressDesign extends StatefulWidget {
  const AdressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
  });

  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  @override
  _AdressDesignState createState() => _AdressDesignState();
}

class _AdressDesignState extends State<AdressDesign> {
  final addressChangerController = Get.put(AddressChangerController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressChangerController>(
      builder: (_controller) {
        return GestureDetector(
          onTap: () {
            // _controller.displayResult(widget.value!);
            //    _controller.update();
          },
          child: Card(
            color: Colors.cyan.withOpacity(0.4),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  children: [
                    Radio<dynamic>(
                      groupValue: widget.currentIndex,
                      value: widget.value,
                      activeColor: Colors.amber,
                      onChanged: (val) {
                        _controller.displayResult(widget.value!);
                        _controller.update();
                      },
                    ),
                    ListView(
                      shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Table(
                            children: const[
                               TableRow(
                                children: [
                                  Text(
                                    "Name: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Shebin PR"),
                                ],
                              ),
                               TableRow(
                                children: [
                                  Text(
                                    "Phone Number: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("91 7559074583"),
                                ],
                              ),
                               TableRow(
                                children: [
                                  Text(
                                    "Flat Number: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("12 B"),
                                ],
                              ),
                               TableRow(
                                children: [
                                  Text(
                                    "City: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("kochi"),
                                ],
                              ),
                               TableRow(
                                children: [
                                  Text(
                                    "State: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Kerala"),
                                ],
                              ),
                               TableRow(
                                children: [
                                  Text(
                                    "Full Address: ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Skyline 12 B, Kakkanad, Kochi , Kerala"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black54,
                      ),
                      onPressed: () {},
                      child: const Text("Check on Maps"),
                    ),

                    // ignore: prefer_if_elements_to_conditional_expressions
                    // widget.value == _controller.count
                    //     ?
                         ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () {},
                            child: const Text("Proceed"),
                          )
                        // : Container()
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
