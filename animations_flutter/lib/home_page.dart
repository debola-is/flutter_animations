import 'package:animations_flutter/lesson3.dart';
import 'package:animations_flutter/lesson_1.dart';
import 'package:animations_flutter/lesson_2.dart';
import 'package:animations_flutter/lesson_4.dart';
import 'package:animations_flutter/lesson_5.dart';
import 'package:animations_flutter/lesson_6.dart';
import 'package:animations_flutter/lesson_7.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateToLesson(Widget page, BuildContext context) {
  Navigator.push(context, CupertinoPageRoute(
    builder: (context) {
      return page;
    },
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home Page'),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: Text('Select which lesson to view')),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              navigateToLesson(const Lesson1(), context);
            },
            title: const Text('Lesson 1'),
            subtitle: const Text(
                'Animated Builder and Transform: Rotating Container with shadow, rotating along Y-axis'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              navigateToLesson(const Lesson2(), context);
            },
            title: const Text('Lesson 2'),
            subtitle: const Text(
                'Chained Animations, Curves and Clippers: Rotating and fliping circle animation'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              navigateToLesson(const Lesson3(), context);
            },
            title: const Text('Lesson 3'),
            subtitle: const Text(
                '3D Animations in Flutter, using Stack and Tranform to Generate A False 3D Representation of A Rotating Cube'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              navigateToLesson(const Lesson4(), context);
            },
            title: const Text('Lesson 4'),
            subtitle: const Text('Hero Animations in FLutter'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              navigateToLesson(const Lesson5(), context);
            },
            title: const Text('Lesson 5'),
            subtitle: const Text(
                'Implicit Animations in FLutter: Using an Animated Container'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              navigateToLesson(const Lesson6(), context);
            },
            title: const Text('Lesson 6'),
            subtitle: const Text(
                'Tween Animation Builder, Custom Clipper and Clip Path'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
          ListTile(
            onTap: () {
              navigateToLesson(const Lesson7(), context);
            },
            title: const Text('Lesson 7'),
            subtitle: const Text('Custom Painter and Polygons in Flutter'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
