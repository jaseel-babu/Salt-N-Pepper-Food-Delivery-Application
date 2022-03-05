import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';

class ClippingSample extends StatefulWidget {
  const ClippingSample({Key? key}) : super(key: key);

  @override
  State<ClippingSample> createState() => _ClippingSampleState();
}

class _ClippingSampleState extends State<ClippingSample> {
  int? currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33),
                  color: Colors.blueAccent.shade200,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.shade100,
                      offset: const Offset(5.0, 5.0),
                      blurRadius: 25.0,
                      spreadRadius: 1.0,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 6.0,
                      spreadRadius: 1.0,
                    )
                  ],
                ),
                child: ClipPath(
                  clipper: BackgroundClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
     
     
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const roundnessFactor = 35.0;

    final path = Path();

    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height - roundnessFactor,
    );
    path.lineTo(size.width, roundnessFactor * 2);
    path.quadraticBezierTo(
      size.width - 10,
      roundnessFactor,
      size.width - roundnessFactor * 1.5,
      roundnessFactor * 1.5,
    );
    path.lineTo(
      roundnessFactor * 0.6,
      size.height * 0.33 - roundnessFactor * 0.3,
    );
    path.quadraticBezierTo(
      0,
      size.height * 0.33,
      0,
      size.height * 0.33 + roundnessFactor,
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
