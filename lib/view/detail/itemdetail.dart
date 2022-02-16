import 'package:flutter/material.dart';
import 'package:user_side/model/itemmodel.dart';

class ItemDetailPage extends StatelessWidget {
  ItemDetailPage({Key? key, required this.itemDetail}) : super(key: key);
  ItemModel itemDetail;
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
          ],
        ),
      ),
    );
  }
}
