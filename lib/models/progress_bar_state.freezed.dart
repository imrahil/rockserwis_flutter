// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProgressBarState {
  bool get playing => throw _privateConstructorUsedError;
  AudioProcessingState get processingState =>
      throw _privateConstructorUsedError;
  Duration get progress => throw _privateConstructorUsedError;
  Duration get buffered => throw _privateConstructorUsedError;
  Duration get total => throw _privateConstructorUsedError;
  Episode? get episode => throw _privateConstructorUsedError;

  /// Create a copy of ProgressBarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressBarStateCopyWith<ProgressBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressBarStateCopyWith<$Res> {
  factory $ProgressBarStateCopyWith(
          ProgressBarState value, $Res Function(ProgressBarState) then) =
      _$ProgressBarStateCopyWithImpl<$Res, ProgressBarState>;
  @useResult
  $Res call(
      {bool playing,
      AudioProcessingState processingState,
      Duration progress,
      Duration buffered,
      Duration total,
      Episode? episode});

  $EpisodeCopyWith<$Res>? get episode;
}

/// @nodoc
class _$ProgressBarStateCopyWithImpl<$Res, $Val extends ProgressBarState>
    implements $ProgressBarStateCopyWith<$Res> {
  _$ProgressBarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressBarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playing = null,
    Object? processingState = null,
    Object? progress = null,
    Object? buffered = null,
    Object? total = null,
    Object? episode = freezed,
  }) {
    return _then(_value.copyWith(
      playing: null == playing
          ? _value.playing
          : playing // ignore: cast_nullable_to_non_nullable
              as bool,
      processingState: null == processingState
          ? _value.processingState
          : processingState // ignore: cast_nullable_to_non_nullable
              as AudioProcessingState,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as Duration,
      buffered: null == buffered
          ? _value.buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as Duration,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as Duration,
      episode: freezed == episode
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as Episode?,
    ) as $Val);
  }

  /// Create a copy of ProgressBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EpisodeCopyWith<$Res>? get episode {
    if (_value.episode == null) {
      return null;
    }

    return $EpisodeCopyWith<$Res>(_value.episode!, (value) {
      return _then(_value.copyWith(episode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProgressBarStateImplCopyWith<$Res>
    implements $ProgressBarStateCopyWith<$Res> {
  factory _$$ProgressBarStateImplCopyWith(_$ProgressBarStateImpl value,
          $Res Function(_$ProgressBarStateImpl) then) =
      __$$ProgressBarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool playing,
      AudioProcessingState processingState,
      Duration progress,
      Duration buffered,
      Duration total,
      Episode? episode});

  @override
  $EpisodeCopyWith<$Res>? get episode;
}

/// @nodoc
class __$$ProgressBarStateImplCopyWithImpl<$Res>
    extends _$ProgressBarStateCopyWithImpl<$Res, _$ProgressBarStateImpl>
    implements _$$ProgressBarStateImplCopyWith<$Res> {
  __$$ProgressBarStateImplCopyWithImpl(_$ProgressBarStateImpl _value,
      $Res Function(_$ProgressBarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressBarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playing = null,
    Object? processingState = null,
    Object? progress = null,
    Object? buffered = null,
    Object? total = null,
    Object? episode = freezed,
  }) {
    return _then(_$ProgressBarStateImpl(
      playing: null == playing
          ? _value.playing
          : playing // ignore: cast_nullable_to_non_nullable
              as bool,
      processingState: null == processingState
          ? _value.processingState
          : processingState // ignore: cast_nullable_to_non_nullable
              as AudioProcessingState,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as Duration,
      buffered: null == buffered
          ? _value.buffered
          : buffered // ignore: cast_nullable_to_non_nullable
              as Duration,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as Duration,
      episode: freezed == episode
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as Episode?,
    ));
  }
}

/// @nodoc

class _$ProgressBarStateImpl implements _ProgressBarState {
  _$ProgressBarStateImpl(
      {required this.playing,
      required this.processingState,
      required this.progress,
      required this.buffered,
      required this.total,
      this.episode});

  @override
  final bool playing;
  @override
  final AudioProcessingState processingState;
  @override
  final Duration progress;
  @override
  final Duration buffered;
  @override
  final Duration total;
  @override
  final Episode? episode;

  @override
  String toString() {
    return 'ProgressBarState(playing: $playing, processingState: $processingState, progress: $progress, buffered: $buffered, total: $total, episode: $episode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressBarStateImpl &&
            (identical(other.playing, playing) || other.playing == playing) &&
            (identical(other.processingState, processingState) ||
                other.processingState == processingState) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.buffered, buffered) ||
                other.buffered == buffered) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.episode, episode) || other.episode == episode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playing, processingState,
      progress, buffered, total, episode);

  /// Create a copy of ProgressBarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressBarStateImplCopyWith<_$ProgressBarStateImpl> get copyWith =>
      __$$ProgressBarStateImplCopyWithImpl<_$ProgressBarStateImpl>(
          this, _$identity);
}

abstract class _ProgressBarState implements ProgressBarState {
  factory _ProgressBarState(
      {required final bool playing,
      required final AudioProcessingState processingState,
      required final Duration progress,
      required final Duration buffered,
      required final Duration total,
      final Episode? episode}) = _$ProgressBarStateImpl;

  @override
  bool get playing;
  @override
  AudioProcessingState get processingState;
  @override
  Duration get progress;
  @override
  Duration get buffered;
  @override
  Duration get total;
  @override
  Episode? get episode;

  /// Create a copy of ProgressBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressBarStateImplCopyWith<_$ProgressBarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
