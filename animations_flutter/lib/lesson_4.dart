import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}

const people = [
  Person(name: 'John', age: 22, emoji: '🧔'),
  Person(name: 'Angela', age: 21, emoji: '👩'),
  Person(name: 'Peter', age: 24, emoji: '🧑'),
];

class Lesson4 extends StatefulWidget {
  const Lesson4({super.key});

  @override
  State<Lesson4> createState() => _Lesson4State();
}

class _Lesson4State extends State<Lesson4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('People')),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => DetailsScreen(person: person),
                ),
              );
            },
            leading: Hero(
              tag: person.name,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 40),
              ),
            ),
            title: Text(person.name),
            subtitle: Text('${person.age}'),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Person person;

  const DetailsScreen({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Hero(
            // the flightShuttleBuilder property can be used to fine tune how the trnasition between the hero widgets occurs
            flightShuttleBuilder: (
              flightContext,
              animation,
              flightDirection, // push and pop (to and fro)
              fromHeroContext,
              toHeroContext,
            ) {
              switch (flightDirection) {
                case HeroFlightDirection.push:
                  return ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(begin: 0.0, end: 1.0).chain(
                          CurveTween(
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      child: toHeroContext.widget);

                case HeroFlightDirection.pop:
                  return fromHeroContext.widget;
              }
            },
            tag: person.name,
            child: Material(
              color: Colors.transparent,
              child: Text(
                person.emoji,
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(person.name),
            const SizedBox(height: 20),
            Text('${person.age}'),
          ],
        ),
      ),
    );
  }
}
