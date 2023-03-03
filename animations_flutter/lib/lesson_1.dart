import 'dart:math' show pi;

import 'package:flutter/material.dart';

class Lesson1 extends StatefulWidget {
  const Lesson1({super.key});

  @override
  State<Lesson1> createState() => _Lesson1State();
}

class _Lesson1State extends State<Lesson1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    _animation = Tween<double>(begin: 0.0, end: pi * 2).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(_animation.value),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2.5,
                      spreadRadius: 2.5,
                      offset: Offset.fromDirection(pi / 2, 10),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

/*
- Animation controller is an object that allows you to change the value of a double from say 0 - 1 at a certain pace and the pace is specified using a duration.
- Animation controller needs to be disposed in the dispose method of the stateful widget
- Animation is an object tied to an animation controller and it changes its values based on the value of then animation controller's value
- Vsync - vertical sync (screen refresh rate)
- Transform is a widget used to alter or distort the form of its child.

*/