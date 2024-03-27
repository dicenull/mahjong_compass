// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mahjong_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MahjongState {
  int get round => throw _privateConstructorUsedError;
  int get honba => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MahjongStateCopyWith<MahjongState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MahjongStateCopyWith<$Res> {
  factory $MahjongStateCopyWith(
          MahjongState value, $Res Function(MahjongState) then) =
      _$MahjongStateCopyWithImpl<$Res, MahjongState>;
  @useResult
  $Res call({int round, int honba});
}

/// @nodoc
class _$MahjongStateCopyWithImpl<$Res, $Val extends MahjongState>
    implements $MahjongStateCopyWith<$Res> {
  _$MahjongStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? round = null,
    Object? honba = null,
  }) {
    return _then(_value.copyWith(
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as int,
      honba: null == honba
          ? _value.honba
          : honba // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MahjongStateImplCopyWith<$Res>
    implements $MahjongStateCopyWith<$Res> {
  factory _$$MahjongStateImplCopyWith(
          _$MahjongStateImpl value, $Res Function(_$MahjongStateImpl) then) =
      __$$MahjongStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int round, int honba});
}

/// @nodoc
class __$$MahjongStateImplCopyWithImpl<$Res>
    extends _$MahjongStateCopyWithImpl<$Res, _$MahjongStateImpl>
    implements _$$MahjongStateImplCopyWith<$Res> {
  __$$MahjongStateImplCopyWithImpl(
      _$MahjongStateImpl _value, $Res Function(_$MahjongStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? round = null,
    Object? honba = null,
  }) {
    return _then(_$MahjongStateImpl(
      round: null == round
          ? _value.round
          : round // ignore: cast_nullable_to_non_nullable
              as int,
      honba: null == honba
          ? _value.honba
          : honba // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MahjongStateImpl implements _MahjongState {
  _$MahjongStateImpl({required this.round, required this.honba});

  @override
  final int round;
  @override
  final int honba;

  @override
  String toString() {
    return 'MahjongState(round: $round, honba: $honba)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MahjongStateImpl &&
            (identical(other.round, round) || other.round == round) &&
            (identical(other.honba, honba) || other.honba == honba));
  }

  @override
  int get hashCode => Object.hash(runtimeType, round, honba);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MahjongStateImplCopyWith<_$MahjongStateImpl> get copyWith =>
      __$$MahjongStateImplCopyWithImpl<_$MahjongStateImpl>(this, _$identity);
}

abstract class _MahjongState implements MahjongState {
  factory _MahjongState({required final int round, required final int honba}) =
      _$MahjongStateImpl;

  @override
  int get round;
  @override
  int get honba;
  @override
  @JsonKey(ignore: true)
  _$$MahjongStateImplCopyWith<_$MahjongStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
