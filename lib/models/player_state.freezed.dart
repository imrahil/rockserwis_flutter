// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EpisodePlayerState {
  bool get playing => throw _privateConstructorUsedError;
  AudioProcessingState get processingState =>
      throw _privateConstructorUsedError;
  Duration get progress => throw _privateConstructorUsedError;
  Duration get buffered => throw _privateConstructorUsedError;
  Duration get total => throw _privateConstructorUsedError;
  Episode? get currentEpisode => throw _privateConstructorUsedError;
  List<Episode> get episodes => throw _privateConstructorUsedError;

  /// Create a copy of EpisodePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodePlayerStateCopyWith<EpisodePlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodePlayerStateCopyWith<$Res> {
  factory $EpisodePlayerStateCopyWith(
          EpisodePlayerState value, $Res Function(EpisodePlayerState) then) =
      _$EpisodePlayerStateCopyWithImpl<$Res, EpisodePlayerState>;
  @useResult
  $Res call(
      {bool playing,
      AudioProcessingState processingState,
      Duration progress,
      Duration buffered,
      Duration total,
      Episode? currentEpisode,
      List<Episode> episodes});

  $EpisodeCopyWith<$Res>? get currentEpisode;
}

/// @nodoc
class _$EpisodePlayerStateCopyWithImpl<$Res, $Val extends EpisodePlayerState>
    implements $EpisodePlayerStateCopyWith<$Res> {
  _$EpisodePlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EpisodePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playing = null,
    Object? processingState = null,
    Object? progress = null,
    Object? buffered = null,
    Object? total = null,
    Object? currentEpisode = freezed,
    Object? episodes = null,
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
      currentEpisode: freezed == currentEpisode
          ? _value.currentEpisode
          : currentEpisode // ignore: cast_nullable_to_non_nullable
              as Episode?,
      episodes: null == episodes
          ? _value.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
    ) as $Val);
  }

  /// Create a copy of EpisodePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EpisodeCopyWith<$Res>? get currentEpisode {
    if (_value.currentEpisode == null) {
      return null;
    }

    return $EpisodeCopyWith<$Res>(_value.currentEpisode!, (value) {
      return _then(_value.copyWith(currentEpisode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EpisodePlayerStateImplCopyWith<$Res>
    implements $EpisodePlayerStateCopyWith<$Res> {
  factory _$$EpisodePlayerStateImplCopyWith(_$EpisodePlayerStateImpl value,
          $Res Function(_$EpisodePlayerStateImpl) then) =
      __$$EpisodePlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool playing,
      AudioProcessingState processingState,
      Duration progress,
      Duration buffered,
      Duration total,
      Episode? currentEpisode,
      List<Episode> episodes});

  @override
  $EpisodeCopyWith<$Res>? get currentEpisode;
}

/// @nodoc
class __$$EpisodePlayerStateImplCopyWithImpl<$Res>
    extends _$EpisodePlayerStateCopyWithImpl<$Res, _$EpisodePlayerStateImpl>
    implements _$$EpisodePlayerStateImplCopyWith<$Res> {
  __$$EpisodePlayerStateImplCopyWithImpl(_$EpisodePlayerStateImpl _value,
      $Res Function(_$EpisodePlayerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EpisodePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playing = null,
    Object? processingState = null,
    Object? progress = null,
    Object? buffered = null,
    Object? total = null,
    Object? currentEpisode = freezed,
    Object? episodes = null,
  }) {
    return _then(_$EpisodePlayerStateImpl(
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
      currentEpisode: freezed == currentEpisode
          ? _value.currentEpisode
          : currentEpisode // ignore: cast_nullable_to_non_nullable
              as Episode?,
      episodes: null == episodes
          ? _value._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
    ));
  }
}

/// @nodoc

class _$EpisodePlayerStateImpl implements _EpisodePlayerState {
  _$EpisodePlayerStateImpl(
      {required this.playing,
      required this.processingState,
      required this.progress,
      required this.buffered,
      required this.total,
      this.currentEpisode,
      final List<Episode> episodes = const []})
      : _episodes = episodes;

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
  final Episode? currentEpisode;
  final List<Episode> _episodes;
  @override
  @JsonKey()
  List<Episode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  String toString() {
    return 'EpisodePlayerState(playing: $playing, processingState: $processingState, progress: $progress, buffered: $buffered, total: $total, currentEpisode: $currentEpisode, episodes: $episodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodePlayerStateImpl &&
            (identical(other.playing, playing) || other.playing == playing) &&
            (identical(other.processingState, processingState) ||
                other.processingState == processingState) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.buffered, buffered) ||
                other.buffered == buffered) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.currentEpisode, currentEpisode) ||
                other.currentEpisode == currentEpisode) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      playing,
      processingState,
      progress,
      buffered,
      total,
      currentEpisode,
      const DeepCollectionEquality().hash(_episodes));

  /// Create a copy of EpisodePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodePlayerStateImplCopyWith<_$EpisodePlayerStateImpl> get copyWith =>
      __$$EpisodePlayerStateImplCopyWithImpl<_$EpisodePlayerStateImpl>(
          this, _$identity);
}

abstract class _EpisodePlayerState implements EpisodePlayerState {
  factory _EpisodePlayerState(
      {required final bool playing,
      required final AudioProcessingState processingState,
      required final Duration progress,
      required final Duration buffered,
      required final Duration total,
      final Episode? currentEpisode,
      final List<Episode> episodes}) = _$EpisodePlayerStateImpl;

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
  Episode? get currentEpisode;
  @override
  List<Episode> get episodes;

  /// Create a copy of EpisodePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodePlayerStateImplCopyWith<_$EpisodePlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
