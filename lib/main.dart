import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_maple_story/snail.dart';
import 'button.dart';
import 'fox.dart';
import 'kakashi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomePage(),
     );//Material App
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>_HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Blue Snail
  int snailSpriteCount = 1;
  double snailPosX = 0.5;
  String snailDirection = 'left';

  //My Fox
  int foxSpriteCount = 1;
  double foxPosX = 0;
  String foxDirection = 'right';

  //My Kakashi
  int kakashiSpriteCount = 2;
  double kakashiPosX = -0.5;
  String kakashiDirection = 'right';

  // Star variables
  int starSpriteCount = 1;
  double starPosX = -0.5;
  String starDirection = 'right';


  //loading screen
  var loadingScreenColor = Colors.pink[300];
  var loadingScreenTextColor = Colors.black;
  int loadingTime = 3;

  // Star variables
  List<double> starPositionsX = []; // X positions of stars
  List<double> starPositionsY = []; // Y positions of stars
  bool isStarActive = false; // To track if a star is active

// Game state variables
  int score = 0; // Player's score
  bool isSnailAlive = true; // To track if the snail is alive
  bool gameOver = false; // To track if the game is over


  void startGame() {
    startGameTimer();
    moveSnail();
    moveFox();
  }

  void startGameTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        loadingTime--;
      });
      if (loadingTime == 0) {
        setState(() {
          loadingScreenColor = Colors.transparent;
          loadingTime = 3;
          loadingScreenTextColor = Colors.transparent;
        });
        timer.cancel();
      }
    });
  }

  void attack() {
    shootStar(); // Shoot a star when the attack button is clicked
  }

  void checkGameOver() {
    if ((kakashiPosX - snailPosX).abs() < 0.05 && isSnailAlive) {
      setState(() {
        gameOver = true; // End the game
      });
    }
  }


  void shootStar() {
    setState(() {
      // Add a new star at Kakashi's position
      starPositionsX.add(kakashiPosX);
      starPositionsY.add(1.1); // Y position of Kakashi
    });

    // Move the star toward the snail
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        for (int i = 0; i < starPositionsX.length; i++) {
          starPositionsX[i] += 0.05; // Move the star to the right

          // Check if the star hits the snail
          if ((starPositionsX[i] - snailPosX).abs() < 0.1 && isSnailAlive) {
            // Hit detected
            setState(() {
              isSnailAlive = false; // Snail dies
              score += 5; // Increase score
              starPositionsX.removeAt(i); // Remove the star
              starPositionsY.removeAt(i);
            });

            // Respawn the snail after a delay
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
                isSnailAlive = true;
                snailPosX = 1; // Reset snail position
              });
            });

            timer.cancel();
            break;
          }

          // Remove the star if it goes off-screen
          if (starPositionsX[i] > 1.5) {
            starPositionsX.removeAt(i);
            starPositionsY.removeAt(i);
            break;
          }
        }
      });
    });
  }


  void moveFox() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        foxSpriteCount++;

        if (foxSpriteCount == 9) {
          foxSpriteCount = 1;
        }

        if ((foxPosX - kakashiPosX).abs() > 0.1) {
          if (kakashiDirection == 'right') {
            foxPosX = kakashiPosX - 0.1;
          } else if (kakashiDirection == 'left') {
            foxPosX = kakashiPosX + 0.1;
          }
        }

        if (foxPosX - kakashiPosX > 0) {
          foxDirection = 'left';
        } else {
          foxDirection = 'right';
        }
      });
    });
  }


  void moveSnail() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      setState(() {
        snailSpriteCount++;

        if (snailDirection == 'left') {
          snailPosX -= 0.01;
        } else {
          snailPosX += 0.01;
        }

        if (snailPosX < 0.3) {
          snailDirection = 'right';
        } else if (snailPosX > 0.6) {
          snailDirection = 'left';
        }

        if (snailSpriteCount == 5) {
          snailSpriteCount = 1;
        }
      });
    });
  }

  void moveLeft() {
    setState(() {
      kakashiPosX -= 0.03;
      kakashiSpriteCount++;
      kakashiDirection = 'left';
      checkGameOver();
    });
  }

  void moveRight() {
    setState(() {
      kakashiPosX += 0.03;
      kakashiSpriteCount++;
      kakashiDirection = 'right';
      checkGameOver();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue[300],
              child: Stack(
                children: [
                  // Snail
                  if (isSnailAlive)
                    Container(
                      alignment: Alignment(snailPosX, 1.04),
                      child: BlueSnail(
                        snailDirection: snailDirection,
                        snailSpriteCount: snailSpriteCount,
                      ),
                    ),
                  if (!isSnailAlive)
                    Container(
                      alignment: Alignment(snailPosX, 1.04),
                      child: Image.asset('lib/mapleSTORY/snail_dead' +
                          snailSpriteCount.toString() +
                          '.png'),
                    ),

                  // Fox
                  Container(
                    alignment: Alignment(foxPosX, 1.03),
                    child: MyFox(
                      foxDirection: foxDirection,
                      foxSpriteCount: foxSpriteCount,
                    ),
                  ),
                  // Kakashi
                  Container(
                    alignment: Alignment(kakashiPosX, 1.1),
                    child: MyKakashi(
                      kakashiDirection: kakashiDirection,
                      kakashiSpriteCount: kakashiSpriteCount % 2 + 1,
                    ),
                  ),
                  // Stars
                  for (int i = 0; i < starPositionsX.length; i++)
                    Container(
                      alignment: Alignment(starPositionsX[i], starPositionsY[i]),
                      child: Image.asset('lib/mapleSTORY/star' +
                          starSpriteCount.toString() +
                          '.png'),
                    ),
                  if (gameOver)
                    Center(
                      child: Text(
                        'GAME OVER\nScore: $score',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Loading Screen
                  Container(
                    color: loadingScreenColor,
                    child: Center(
                      child: Text(
                        loadingTime.toString(),
                        style: TextStyle(color: loadingScreenTextColor),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Text(
                      'Score: $score',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.green[600],
          ),
          Expanded(
            child: Container(
              color: Colors.grey[500],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'K A K A S H I S T O R Y',
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        text: 'PLAY',
                        function: () {
                          if (gameOver) {
                            setState(() {
                              score = 0;
                              isSnailAlive = true;
                              gameOver = false;
                            });
                          }
                          startGame();
                        },
                      ),
                      MyButton(
                        text: 'ATTACK',
                        function: attack,
                      ),
                      MyButton(
                        text: '←',
                        function: moveLeft,
                      ),
                      MyButton(
                        text: '→',
                        function: moveRight,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}












