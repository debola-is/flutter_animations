import 'package:flutter/material.dart';

import 'dart:math' show pi;

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockWise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;

      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockWise,
    );
    path.close();
    return path;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class Lesson2 extends StatefulWidget {
  const Lesson2({super.key});

  @override
  State<Lesson2> createState() => _Lesson2State();
}

class _Lesson2State extends State<Lesson2> with TickerProviderStateMixin {
  late AnimationController _counterClockwiseRotationController;
  late Animation<double> _counterClockwiseRotationAnimation;

  late AnimationController _flipController;
  late Animation _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _counterClockwiseRotationAnimation =
        Tween<double>(begin: 0.0, end: -(pi / 2)).animate(
      CurvedAnimation(
        curve: Curves.bounceOut,
        parent: _counterClockwiseRotationController,
      ),
    );

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut,
      ),
    );

    // A status listener is a callback on an animation that will notofy you when the status of the animation changes

    _counterClockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Create new animation
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(
          CurvedAnimation(
            parent: _flipController,
            curve: Curves.bounceOut,
          ),
        );

        // Reset the flip controller and start the animation

        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Create a new animation and reset the animation controller

        _counterClockwiseRotationAnimation = Tween<double>(
          begin: _counterClockwiseRotationAnimation.value,
          end: _counterClockwiseRotationAnimation.value + -(pi / 2),
        ).animate(
          CurvedAnimation(
            curve: Curves.bounceOut,
            parent: _counterClockwiseRotationController,
          ),
        );

        _counterClockwiseRotationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _counterClockwiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockwiseRotationController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));

    return Scaffold(
      body: SafeArea(
          child: AnimatedBuilder(
        animation: _counterClockwiseRotationController,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(_counterClockwiseRotationAnimation.value),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _flipController,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()
                        ..rotateY(_flipAnimation.value),
                      child: ClipPath(
                        clipper: HalfCircleClipper(side: CircleSide.left),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Color(0xff0057b7),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _flipController,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..rotateY(_flipAnimation.value),
                      child: ClipPath(
                        clipper: HalfCircleClipper(side: CircleSide.right),
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Color(0xffffd700),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      )),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  HalfCircleClipper({
    required this.side,
  });

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
