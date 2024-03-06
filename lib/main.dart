import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final roundProvider = StateProvider<int>((ref) => 0);

final honbaProvider = StateProvider<int>((ref) => 0);

final honbaNameProvider = Provider<String>((ref) {
  final honba = ref.watch(honbaProvider);
  return '$honba 本場';
});

final roundNameProvider = Provider<String>((ref) {
  final round = ref.watch(roundProvider);
  return switch (round) {
    0 => '東一局',
    1 => '東二局',
    2 => '東三局',
    3 => '東四局',
    4 => '南一局',
    5 => '南二局',
    6 => '南三局',
    7 => '南四局',
    8 => '西一局',
    9 => '西二局',
    10 => '西三局',
    11 => '西四局',
    12 => '北一局',
    13 => '北二局',
    14 => '北三局',
    15 => '北四局',
    _ => throw UnimplementedError(),
  };
});

void main() {
  runApp(const ProviderScope(child: App()));
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

class _Compass extends ConsumerWidget {
  const _Compass(this.centerPadding);

  final double centerPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(roundProvider);

    return Center(
      child: AnimatedRotation(
        turns: -round / 4,
        duration: const Duration(milliseconds: 500),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Wrap(
                      //   children: List.generate(
                      //     6,
                      //     (index) => Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: _Die(n: index + 1, size: 40),
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(roundProvider.notifier)
                              .update((state) => state + 1);
                          ref.read(honbaProvider.notifier).update((state) => 0);
                        },
                        child: Text(
                          ref.watch(roundNameProvider),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          ref
                              .read(honbaProvider.notifier)
                              .update((state) => state + 1);
                        },
                        child: Text(
                          ref.watch(honbaNameProvider),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
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
      ),
    );
  }
}

class _Die extends StatelessWidget {
  const _Die({required this.n, required this.size});

  final int n;
  final double size;

  @override
  Widget build(BuildContext context) {
    final dSize = size * .2;

    const none = SizedBox.shrink();

    return Container(
      color: Colors.white,
      height: size,
      width: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (n == 4 || n == 5 || n == 6) _Dot(dSize) else none,
              none,
              if (n != 1) _Dot(dSize) else none,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (n == 6) _Dot(dSize) else none,
              if (n == 1 || n == 3 || n == 5)
                _Dot(dSize, isRed: n == 1)
              else
                none,
              if (n == 6) _Dot(dSize) else none,
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (n != 1) _Dot(dSize) else none,
              none,
              if (n == 4 || n == 5 || n == 6) _Dot(dSize) else none,
            ],
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.size, {this.isRed = false});

  final double size;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isRed ? Colors.red : Colors.black,
      ),
      width: size,
      height: size,
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
