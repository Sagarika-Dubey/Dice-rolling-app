import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var counter = 1;
  Random random = Random();
  int currentImageIndex = 0;
  List<String> images = [
    'assets/images/d1.png',
    'assets/images/d2.png',
    'assets/images/d3.png',
    'assets/images/d4.png',
    'assets/images/d5.png',
    'assets/images/d6.png'
  ];

  AudioPlayer player = AudioPlayer();

  void diceRoll() {
    setState(() {
      currentImageIndex = random.nextInt(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 184, 99, 20),
          foregroundColor: Colors.white,
          title: const Text("Dice Rolling App"),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 235, 139, 49), Colors.indigo],
              begin: startAlignment,
              end: endAlignment,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: random.nextDouble() * 90,
                child: Image.asset(
                  images[currentImageIndex],
                  height: 100,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    player.setAsset('assets/audio/dice-audio.mp3');
                    player.play();
                    Timer.periodic(const Duration(milliseconds: 80), (timer) {
                      counter++;
                      diceRoll();

                      if (counter >= 13) {
                        timer.cancel();
                        setState(() {
                          counter = 1;
                        });
                      }
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 225, 190, 248)),
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Roll',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  )),
            ],
          )),
        ),
      ),
    );
  }
}
