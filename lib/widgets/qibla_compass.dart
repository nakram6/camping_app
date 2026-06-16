import 'dart:math';

import 'package:flutter/material.dart';

class QiblaCompass extends StatelessWidget {
final double heading;
final double qiblaDirection;

const QiblaCompass({
super.key,
required this.heading,
required this.qiblaDirection,
});

@override
Widget build(BuildContext context) {
final rotation =
(qiblaDirection - heading) *
pi /
180;


return Container(
  width: 340,
  height: 340,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: RadialGradient(
      colors: [
        Colors.green.shade50,
        Colors.white,
      ],
    ),
    border: Border.all(
      color: Colors.green.shade700,
      width: 8,
    ),
    boxShadow: [
      BoxShadow(
        color:
            Colors.green.withOpacity(
          0.25,
        ),
        blurRadius: 25,
        spreadRadius: 5,
      ),
    ],
  ),
  child: Stack(
    alignment: Alignment.center,
    children: [
      const Positioned(
        top: 15,
        child: Text(
          "N",
          style: TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      const Positioned(
        bottom: 15,
        child: Text(
          "S",
          style: TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      const Positioned(
        left: 15,
        child: Text(
          "W",
          style: TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      const Positioned(
        right: 15,
        child: Text(
          "E",
          style: TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      Container(
        width: 250,
        height: 250,
        decoration:
            BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color:
                Colors.green.shade200,
            width: 2,
          ),
        ),
      ),

      AnimatedRotation(
        turns:
            rotation /
            (2 * pi),
        duration:
            const Duration(
          milliseconds: 300,
        ),
        child: Container(
          decoration:
              BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green
                    .withOpacity(
                  0.5,
                ),
                blurRadius: 15,
              ),
            ],
          ),
          child: const Icon(
            Icons.navigation,
            size: 140,
            color: Colors.green,
          ),
        ),
      ),

      Container(
        width: 80,
        height: 80,
        decoration:
            BoxDecoration(
          color: Colors.black,
          borderRadius:
              BorderRadius.circular(
            12,
          ),
          border: Border.all(
            color: Colors.amber,
            width: 3,
          ),
        ),
        child: const Center(
          child: Text(
            "🕋",
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    ],
  ),
);


}
}
