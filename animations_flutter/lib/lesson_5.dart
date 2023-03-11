import 'package:flutter/material.dart';

class Lesson5 extends StatefulWidget {
  const Lesson5({super.key});

  @override
  State<Lesson5> createState() => _Lesson5State();
}

const defaultWidth = 100.0;

class _Lesson5State extends State<Lesson5> {
  bool _zoomedIn = false;
  String _buttonText = 'Zoom In';
  double _width = defaultWidth;
  Curve _curve = Curves.bounceInOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Lesson 5'),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
                // Side Note: Research has shown that the most pleasing animation duration on mobile platforms to most users typically falls between 300ms to 500ms. Anything way more looks boring to most users. Personally, 350ms is my favourite sweet spot.

                duration: const Duration(milliseconds: 350),
                curve: _curve,
                width: _width,
                child: Image.asset('assets/images/trade-time-zone.png')),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _zoomedIn = !_zoomedIn;
                    _buttonText = _zoomedIn ? 'Zoom Out' : 'Zoom In';
                    _width = _zoomedIn
                        ? MediaQuery.of(context).size.width
                        : defaultWidth;
                    _curve = _zoomedIn ? Curves.bounceInOut : Curves.easeOut;
                  });
                }
              },
              child: Text(_buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
