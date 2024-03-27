import 'package:freezed_annotation/freezed_annotation.dart';

part 'mahjong_state.freezed.dart';

@freezed
class MahjongState with _$MahjongState {
  factory MahjongState({
    required int round,
    required int honba,
  }) = _MahjongState;
}

enum MahjongPhase {
  ready,
  diceRolling,
}
