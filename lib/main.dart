import 'dart:async';
import 'dart:math';

import 'package:app/die.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final roundProvider = StateProvider<int>((ref) => 0);

final honbaProvider = StateProvider<int>((ref) => 0);

final isDiceRollingProvider = StateProvider((ref) => true);

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

    return Portal(
      child: MaterialApp(
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
                      _Dice(),
                      ElevatedButton(
                        onPressed: ref.watch(isDiceRollingProvider)
                            ? null
                            : () {
                                ref
                                    .read(roundProvider.notifier)
                                    .update((state) => state + 1);
                                ref
                                    .read(honbaProvider.notifier)
                                    .update((state) => 0);
                                ref.read(isDiceRollingProvider.notifier).state =
                                    true;
                              },
                        child: Text(
                          ref.watch(roundNameProvider),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: ref.watch(isDiceRollingProvider)
                            ? null
                            : () {
                                ref
                                    .read(honbaProvider.notifier)
                                    .update((state) => state + 1);
                                ref.read(isDiceRollingProvider.notifier).state =
                                    true;
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

final numberListProvider =
    NotifierProvider<NumberListNotifier, List<int>>(NumberListNotifier.new);

final isStopProvider = StateProvider((_) => false);

class NumberListNotifier extends Notifier<List<int>> {
  final _max = 6;
  final _rnd = Random();

  @override
  List<int> build() {
    return [_rnd.nextInt(_max), _rnd.nextInt(_max)];
  }

  void update() {
    // 前と同じ値にならないようにする
    state =
        state.map((n) => n = (n + _rnd.nextInt(_max - 1) + 1) % _max).toList();
  }
}

class _Dice extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const size = 40.0;
    final isStop = ref.watch(isStopProvider);

    useEffect(
      () {
        if (isStop) {
          Future.microtask(
              () => ref.read(isDiceRollingProvider.notifier).state = false);
          return () {};
        }

        final timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (timer) {
            ref.read(numberListProvider.notifier).update();
          },
        );
        final stopTimer = Timer(
          const Duration(milliseconds: 700),
          () => ref.read(isStopProvider.notifier).update((state) => true),
        );

        return () {
          timer.cancel();
          stopTimer.cancel();
        };
      },
      [isStop],
    );

    return GestureDetector(
      onTap: () {
        if (!ref.read(isDiceRollingProvider)) return;

        ref.read(isStopProvider.notifier).update((state) => !state);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Die(n: ref.watch(numberListProvider)[0] + 1, size: size),
            const SizedBox(width: 16),
            Die(n: ref.watch(numberListProvider)[1] + 1, size: size),
          ],
        ),
      ),
    );
  }
}

class _WindText extends HookConsumerWidget {
  const _WindText(this.wind);

  final Wind wind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size.shortestSide * .1;
    final isStop = ref.watch(isStopProvider);
    final number =
        ref.watch(numberListProvider).fold(0, (prev, n) => prev + n + 1);
    final isShow = (isStop && ((number + 3) % 4 == wind.index));

    return RotatedBox(
      quarterTurns: wind.turns,
      child: PortalTarget(
        visible: isShow,
        anchor: Aligned(
          follower: Alignment.bottomLeft,
          target: Alignment.bottomRight,
        ),
        portalFollower: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
                width: size * 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        child: Text(
          wind.name,
          style: TextStyle(
            fontSize: size,
            color: wind == Wind.east ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}

enum Wind {
  east,
  south,
  west,
  north;

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
