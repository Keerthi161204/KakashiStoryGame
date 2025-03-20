import 'dart:math';
import 'package:flutter/material.dart';

class MyKakashi extends StatelessWidget {
  final int kakashiSpriteCount;
  final String kakashiDirection;

  MyKakashi({required this.kakashiSpriteCount,required this.kakashiDirection});

  @override
  Widget build(BuildContext context) {
    if(kakashiDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 100,
        width: 100,
        child: Image.asset('lib/mapleSTORY/kaku' +
            kakashiSpriteCount.toString() +
            '.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 100,
          width: 100,
          child: Image.asset('lib/mapleSTORY/kaku' +
              kakashiSpriteCount.toString() +
              '.png'),
        ),
      );
    }
  }
}