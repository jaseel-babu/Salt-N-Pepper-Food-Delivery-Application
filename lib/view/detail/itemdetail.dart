import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user_side/model/itemmodel.dart';

class ItemDetailPage extends StatefulWidget {
  ItemDetailPage({Key? key, required this.itemDetail}) : super(key: key);
  ItemModel itemDetail;

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  Razorpay? razorpay;
  @override
  void initState() {
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      print(response.paymentId);
      print("success");
    });
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      print(response.message);
      print("Error");
    });
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      print(response.walletName);
      print("wallet");
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    List sizeChart = widget.itemDetail.size!.keys.toList();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: maxWidth,
              height: maxHeight / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.itemDetail.thumbnail!,
                  fit: BoxFit.cover,
                  frameBuilder: (
                    context,
                    child,
                    frame,
                    wasSynchronouslyLoaded,
                  ) =>
                      child,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    widget.itemDetail.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                ...sizeChart.map(
                  (e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(
                          " ${widget.itemDetail.size![e]}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  width: maxWidth / 1.4,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      checkout();
                    },
                    child: const Text("buy now"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void checkout() async {
    var options = {
      'key': 'rzp_test_8sF0I6V5fjFowv',
      'amount': '2500',
      'name': 'jaseel',
      'description': 'Payment',
      'prefill': {'contact': '7559074583', 'email': 'shebinpr126@gmail.com'},
      'external': {
        'wallets': ['paytm'],
      },
    };
    try {
      razorpay!.open(options);
    } catch (e) {
      print(e);
    }
  }
}
