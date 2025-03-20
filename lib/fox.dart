import 'dart:math';
import 'package:flutter/material.dart';

class MyFox extends StatelessWidget {
  final int foxSpriteCount;
  final String foxDirection;

  MyFox({required this.foxSpriteCount,required this.foxDirection});

  @override
  Widget build(BuildContext context) {
    if(foxDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset('lib/mapleSTORY/f' +
            foxSpriteCount.toString() +
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
          child: Image.asset('lib/mapleSTORY/f' +
              foxSpriteCount.toString() +
              '.png'),
        ),
      );
    }
  }
}