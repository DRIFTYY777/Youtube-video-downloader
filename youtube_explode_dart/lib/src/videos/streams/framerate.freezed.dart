// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'framerate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Framerate _$FramerateFromJson(Map<String, dynamic> json) {
  return _Framerate.fromJson(json);
}

/// @nodoc
mixin _$Framerate {
  /// Framerate as frames per second
  num get framesPerSecond => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FramerateCopyWith<Framerate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FramerateCopyWith<$Res> {
  factory $FramerateCopyWith(Framerate value, $Res Function(Framerate) then) =
      _$FramerateCopyWithImpl<$Res, Framerate>;
  @useResult
  $Res call({num framesPerSecond});
}

/// @nodoc
class _$FramerateCopyWithImpl<$Res, $Val extends Framerate>
    implements $FramerateCopyWith<$Res> {
  _$FramerateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? framesPerSecond = null,
  }) {
    return _then(_value.copyWith(
      framesPerSecond: null == framesPerSecond
          ? _value.framesPerSecond
          : framesPerSecond // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FramerateCopyWith<$Res> implements $FramerateCopyWith<$Res> {
  factory _$$_FramerateCopyWith(
          _$_Framerate value, $Res Function(_$_Framerate) then) =
      __$$_FramerateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num framesPerSecond});
}

/// @nodoc
class __$$_FramerateCopyWithImpl<$Res>
    extends _$FramerateCopyWithImpl<$Res, _$_Framerate>
    implements _$$_FramerateCopyWith<$Res> {
  __$$_FramerateCopyWithImpl(
      _$_Framerate _value, $Res Function(_$_Framerate) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? framesPerSecond = null,
  }) {
    return _then(_$_Framerate(
      null == framesPerSecond
          ? _value.framesPerSecond
          : framesPerSecond // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Framerate extends _Framerate {
  const _$_Framerate(this.framesPerSecond) : super._();

  factory _$_Framerate.fromJson(Map<String, dynamic> json) =>
      _$$_FramerateFromJson(json);

  /// Framerate as frames per second
  @override
  final num framesPerSecond;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Framerate &&
            (identical(other.framesPerSecond, framesPerSecond) ||
                other.framesPerSecond == framesPerSecond));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, framesPerSecond);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FramerateCopyWith<_$_Framerate> get copyWith =>
      __$$_FramerateCopyWithImpl<_$_Framerate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FramerateToJson(
      this,
    );
  }
}

abstract class _Framerate extends Framerate {
  const factory _Framerate(final num framesPerSecond) = _$_Framerate;
  const _Framerate._() : super._();

  factory _Framerate.fromJson(Map<String, dynamic> json) =
      _$_Framerate.fromJson;

  @override

  /// Framerate as frames per second
  num get framesPerSecond;
  @override
  @JsonKey(ignore: true)
  _$$_FramerateCopyWith<_$_Framerate> get copyWith =>
      throw _privateConstructorUsedError;
}
