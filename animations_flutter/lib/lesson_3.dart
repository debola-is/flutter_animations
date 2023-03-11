import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Lesson3 extends StatefulWidget {
  const Lesson3({super.key});

  @override
  State<Lesson3> createState() => _Lesson3State();
}

const sideLength = 100.0;

class _Lesson3State extends State<Lesson3> with TickerProviderStateMixin {
  late AnimationController _controllerX;
  late AnimationController _controllerY;
  late AnimationController _controllerZ;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _controllerX = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _controllerY = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _controllerZ = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
  }

  @override
  void dispose() {
    _controllerX.dispose();
    _controllerY.dispose();
    _controllerZ.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controllerX
      ..reset()
      ..repeat();
    _controllerY
      ..reset()
      ..repeat();
    _controllerZ
      ..reset()
      ..repeat();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: double.infinity,
            ),
            AnimatedBuilder(
                // Using a listenable to merge all the animation controllers into one to avoid using multiple animated builders as used in lesson 2

                animation: Listenable.merge([
                  _controllerX,
                  _controllerY,
                  _controllerZ,
                ]),
                builder: (context, child) {
                  return Transform(
                    // We need to be able to bind the single Tween (0 - 360 degress) to all the three animation controllers. Such that we are now saying, controllerX should animate through the range specified by the Tween but should take the duration specified by the controllerX and similarlly for all the other controllers. All to the single Tween.

                    //Animation object has a function evalute() which takes in a parameter of the animation controller and can help us retrieve this information

                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_animation.evaluate(_controllerX))
                      ..rotateY(_animation.evaluate(_controllerY))
                      ..rotateZ(_animation.evaluate(_controllerZ)),
                    child: Stack(
                      children: [
                        // front
                        Container(
                          color: Colors.red,
                          width: sideLength,
                          height: sideLength,
                        ),
                        // back
                        Transform(
                          transform: Matrix4.identity()
                            ..translate(Vector3(0, 0, -sideLength)),
                          child: Container(
                            color: Colors.green,
                            width: sideLength,
                            height: sideLength,
                          ),
                        ),
                        // left
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(pi / 2),
                          child: Container(
                            color: Colors.blue,
                            width: sideLength,
                            height: sideLength,
                          ),
                        ),
                        // right
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()..rotateY(-pi / 2),
                          child: Container(
                            color: Colors.yellow,
                            width: sideLength,
                            height: sideLength,
                          ),
                        ),
                        // top
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()..rotateX(-pi / 2),
                          child: Container(
                            color: Colors.purple,
                            width: sideLength,
                            height: sideLength,
                          ),
                        ),
                        // bottom
                        Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..rotateX(pi / 2),
                          child: Container(
                            color: Colors.brown,
                            width: sideLength,
                            height: sideLength,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
