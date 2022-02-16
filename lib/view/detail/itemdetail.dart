import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:user_side/model/itemmodel.dart';

class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({Key? key, required this.itemDetail}) : super(key: key);
  ItemModel itemDetail;
  final paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: "100.0",
      status: PaymentItemStatus.final_price,
    )
  ];
  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    List sizeChart = itemDetail.size!.keys.toList();

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
                  itemDetail.thumbnail!,
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
                    itemDetail.title!,
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
                          " ${itemDetail.size![e]}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    );
                  },
                ),
               
                FutureBuilder<bool>(
                  future: _payClient.userCanPay(PayProvider.google_pay),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        return RawGooglePayButton(
                            style: GooglePayButtonStyle.black,
                            type: GooglePayButtonType.pay,
                            onPressed: onGooglePayPressed);
                      } else {
                        return SizedBox();
                        // userCanPay returned false
                        // Consider showing an alternative payment method
                      }
                    }
                    return SizedBox();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void onGooglePayPressed() async {
    final result = await _payClient.showPaymentSelector(
      provider: PayProvider.google_pay,
      paymentItems: paymentItems,
    );
    // Send the resulting Google Pay token to your server / PSP
  }

  Pay _payClient = Pay.withAssets([
    // 'default_payment_profile_apple_pay.json',
    'gpay.json'
  ]);
  void onGooglePayResult(paymentResult) {
    print(paymentResult);
    // Send the resulting Google Pay token to your server / PSP
  }
}
