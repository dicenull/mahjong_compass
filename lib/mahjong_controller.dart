import 'package:app/mahjong_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mahjong_controller.g.dart';

@riverpod
class MahjongController extends _$MahjongController {
  @override
  MahjongState build() => MahjongState(round: 0, honba: 0);

  void nextRound() {
    state = state.copyWith(
      round: state.round + 1,
      honba: 0,
    );
    ref.read(mahjongPhaseControllerProvider.notifier).yamaDetected();
  }

  void nextHonba() {
    state = state.copyWith(
      honba: state.honba + 1,
    );
    ref.read(mahjongPhaseControllerProvider.notifier).yamaDetected();
  }
}

@riverpod
class MahjongPhaseController extends _$MahjongPhaseController {
  @override
  MahjongPhase build() => MahjongPhase.diceRolling;

  void yamaDetected() {
    state = MahjongPhase.ready;
  }

  void restart() {
    state = MahjongPhase.diceRolling;
  }
}

@riverpod
String honbaName(HonbaNameRef ref) {
  final honba =
      ref.watch(mahjongControllerProvider.select((value) => value.honba));
  return '$honba 本場';
}

@riverpod
String roundName(RoundNameRef ref) {
  final round =
      ref.watch(mahjongControllerProvider.select((value) => value.round));

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
}
