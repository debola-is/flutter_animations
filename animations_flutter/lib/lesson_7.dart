import 'dart:math';

import 'package:flutter/material.dart';

class Lesson7 extends StatefulWidget {
  const Lesson7({super.key});

  @override
  State<Lesson7> createState() => _Lesson7State();
}

class _Lesson7State extends State<Lesson7> with TickerProviderStateMixin {
  // Controller and animation to animate the change in sides of the polygon

  late AnimationController _sidesController;
  late Animation<int> _sidesAnimation;

  // Controller and animation to animate the change in radius of the polygon

  late AnimationController _radiusController;
  late Animation _radiusAnimation;

  // Controller and animation to animate the rotation of the polygon

  late AnimationController _rotationController;
  late Animation _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _sidesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _sidesAnimation = IntTween(begin: 3, end: 10).animate(_sidesController);

    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _radiusAnimation = Tween(
      begin: 20.0,
      end: 400.0,
    )
        .chain(
          CurveTween(
            curve: Curves.bounceInOut,
          ),
        )
        .animate(_radiusController);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _rotationAnimation = Tween(
      begin: 0.0,
      end: 2 * pi,
    )
        .chain(
          CurveTween(
            curve: Curves.easeInOut,
          ),
        )
        .animate(_rotationController);
  }

  @override
  void dispose() {
    _sidesController.dispose();
    _radiusController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sidesController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson 7'),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge(
              [_sidesController, _radiusController, _rotationController]),
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..rotateX(_rotationAnimation.value)
                ..rotateY(_rotationAnimation.value)
                ..rotateZ(_rotationAnimation.value),
              alignment: Alignment.center,
              child: CustomPaint(
                painter: Polygon(sides: _sidesAnimation.value),
                // Custom paint on its's own doesn't have a size and so it requires a sized widget as it's child.
                child: SizedBox(
                  width: _radiusAnimation.value,
                  height: _radiusAnimation.value,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Polygon extends CustomPainter {
  final int sides;

  Polygon({required this.sides});
  @override
  void paint(Canvas canvas, Size size) {
    // Paint object is empty by default, all desired parameters are supplied using cascade operator
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final Path path = Path();

    //We obtain the center of the circle to draw
    final Offset center = Offset(size.width / 2, size.height / 2);

    // obtain the angle between the sides of the polygon to draw
    final double angle = (2 * pi) / sides;

    // we generate an array all the angles we would be drawing e.g for three sides [0,120, 240]
    final List angles = List.generate(sides, (index) => index * angle);

    // get circle radius
    final double radius = size.width / 2;

    /*
    Recall the formula for the coordinates of a point on the circumference
    of a circle as given as;
    x = center.x + radius * cos(angle)
    y = center.y + radius * sin(angle)
     */

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    // Now, we can just iterate through our array of angles and draw a line to the corresponding point on the circumference of the circle of each angle.
    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }

    // Close the path
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;

  // shouldRepaint evalutess the condition if the oldDelegate is Polygon and the current number of sides id different from the previous number of sides then it should repaint if not, there is no reason to repaint.
}
