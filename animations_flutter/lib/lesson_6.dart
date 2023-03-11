import 'package:flutter/material.dart';
import 'dart:math' as math;

class Lesson6 extends StatefulWidget {
  const Lesson6({super.key});

  @override
  State<Lesson6> createState() => _Lesson6State();
}

class _Lesson6State extends State<Lesson6> {
  Color _color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lesson6'),
        ),
        body: Center(
          child: ClipPath(
            clipper: CircleClipper(),
            child: TweenAnimationBuilder(
              tween: ColorTween(
                begin: getRandomColor(),
                end: _color,
              ),
              onEnd: () {
                setState(() {
                  _color = getRandomColor();
                });
              },
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  color: value,
                );
              },
            ),
          ),
        ));
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

Color getRandomColor() => Color(0XFF000000 + math.Random().nextInt(0x00FFFFFF));
