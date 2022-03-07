import 'package:flutter/material.dart';
import 'package:user_side/model/itemmodel.dart';

class CartDesign extends StatefulWidget {
  ItemModel? itemModel;
  int? quantityNo;
  CartDesign({this.itemModel, this.quantityNo});

  @override
  State<CartDesign> createState() => _CartDesignState();
}

class _CartDesignState extends State<CartDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Image.network(
                widget.itemModel!.thumbnail!,
                width: 140,
                height: 120,
              ),

              const SizedBox(
                width: 6,
              ),

              //title
              //quantity number
              //price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //title
                  Text(
                    widget.itemModel!.title.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Kiwi",
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),

                  //quantity number // x 7
                  Row(
                    children: [
                      const Text(
                        "x ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Acme",
                        ),
                      ),
                      Text(
                        widget.quantityNo.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: "Acme",
                        ),
                      ),
                    ],
                  ),

                  //price
                  Row(
                    children: [
                      const Text(
                        "Price: ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const Text(
                        "€ ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        widget.itemModel!.size.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
