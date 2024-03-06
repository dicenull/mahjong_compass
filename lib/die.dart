import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const max = 6;

class RollDie extends HookWidget {
  const RollDie(this.size, {super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final rnd = useMemoized(() => Random());
    final n = useState(rnd.nextInt(max));
    useEffect(
      () {
        final timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (timer) {
            // 前と同じ値にならないようにする
            n.value = (n.value + rnd.nextInt(max - 1) + 1) % max;
          },
        );

        return timer.cancel;
      },
      const [],
    );

    return Die(n: n.value + 1, size: size);
  }
}

class Die extends StatelessWidget {
  const Die({super.key, required this.n, required this.size});

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
