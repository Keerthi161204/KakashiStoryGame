import 'dart:math';
import 'package:flutter/material.dart';

class Mystar extends StatelessWidget {
  final int starSpriteCount;
  final String starDirection;

  Mystar({required this.starSpriteCount,required this.starDirection});

  @override
  Widget build(BuildContext context) {
    if(starDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset('lib/mapleSTORY/star' +
            starSpriteCount.toString() +
            '.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset('lib/mapleSTORY/star' +
              starSpriteCount.toString() +
              '.png'),
        ),
      );
    }
  }
}