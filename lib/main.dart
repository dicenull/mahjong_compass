import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide;
    final centerPadding = size * .4;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            width: size,
            height: size,
            child: Container(
              color: Colors.blueGrey,
              child: _Compass(centerPadding),
            ),
          ),
        ),
      ),
    );
  }
}

class _Compass extends StatelessWidget {
  const _Compass(this.centerPadding);

  final double centerPadding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.shrink(),
              _WindText(Wind.west),
              SizedBox.shrink(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _WindText(Wind.north),
              SizedBox(
                width: centerPadding,
                height: centerPadding,
              ),
              const _WindText(Wind.south),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.shrink(),
              _WindText(Wind.east),
              SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class _WindText extends StatelessWidget {
  const _WindText(this.wind);

  final Wind wind;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.shortestSide * .1;
    return RotatedBox(
      quarterTurns: wind.turns,
      child: Text(
        wind.name,
        style: TextStyle(
          fontSize: size,
          color: wind == Wind.east ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}

enum Wind {
  north,
  east,
  south,
  west;

  String get name => switch (this) {
        Wind.north => '北',
        Wind.east => '東',
        Wind.south => '南',
        Wind.west => '西',
      };

  int get turns => switch (this) {
        Wind.north => 1,
        Wind.east => 0,
        Wind.south => 3,
        Wind.west => 2,
      };
}
