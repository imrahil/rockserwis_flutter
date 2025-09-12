// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EpisodePlayerState {

 bool get playing; AudioProcessingState get processingState; Duration get progress; Duration get buffered; Duration get total; Episode? get currentEpisode; List<Episode> get episodes;
/// Create a copy of EpisodePlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpisodePlayerStateCopyWith<EpisodePlayerState> get copyWith => _$EpisodePlayerStateCopyWithImpl<EpisodePlayerState>(this as EpisodePlayerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EpisodePlayerState&&(identical(other.playing, playing) || other.playing == playing)&&(identical(other.processingState, processingState) || other.processingState == processingState)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.buffered, buffered) || other.buffered == buffered)&&(identical(other.total, total) || other.total == total)&&(identical(other.currentEpisode, currentEpisode) || other.currentEpisode == currentEpisode)&&const DeepCollectionEquality().equals(other.episodes, episodes));
}


@override
int get hashCode => Object.hash(runtimeType,playing,processingState,progress,buffered,total,currentEpisode,const DeepCollectionEquality().hash(episodes));

@override
String toString() {
  return 'EpisodePlayerState(playing: $playing, processingState: $processingState, progress: $progress, buffered: $buffered, total: $total, currentEpisode: $currentEpisode, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class $EpisodePlayerStateCopyWith<$Res>  {
  factory $EpisodePlayerStateCopyWith(EpisodePlayerState value, $Res Function(EpisodePlayerState) _then) = _$EpisodePlayerStateCopyWithImpl;
@useResult
$Res call({
 bool playing, AudioProcessingState processingState, Duration progress, Duration buffered, Duration total, Episode? currentEpisode, List<Episode> episodes
});



}
/// @nodoc
class _$EpisodePlayerStateCopyWithImpl<$Res>
    implements $EpisodePlayerStateCopyWith<$Res> {
  _$EpisodePlayerStateCopyWithImpl(this._self, this._then);

  final EpisodePlayerState _self;
  final $Res Function(EpisodePlayerState) _then;

/// Create a copy of EpisodePlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playing = null,Object? processingState = null,Object? progress = null,Object? buffered = null,Object? total = null,Object? currentEpisode = freezed,Object? episodes = null,}) {
  return _then(_self.copyWith(
playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,processingState: null == processingState ? _self.processingState : processingState // ignore: cast_nullable_to_non_nullable
as AudioProcessingState,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as Duration,buffered: null == buffered ? _self.buffered : buffered // ignore: cast_nullable_to_non_nullable
as Duration,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Duration,currentEpisode: freezed == currentEpisode ? _self.currentEpisode : currentEpisode // ignore: cast_nullable_to_non_nullable
as Episode?,episodes: null == episodes ? _self.episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<Episode>,
  ));
}

}


/// @nodoc


class _EpisodePlayerState implements EpisodePlayerState {
   _EpisodePlayerState({required this.playing, required this.processingState, required this.progress, required this.buffered, required this.total, this.currentEpisode, final  List<Episode> episodes = const []}): _episodes = episodes;
  

@override final  bool playing;
@override final  AudioProcessingState processingState;
@override final  Duration progress;
@override final  Duration buffered;
@override final  Duration total;
@override final  Episode? currentEpisode;
 final  List<Episode> _episodes;
@override@JsonKey() List<Episode> get episodes {
  if (_episodes is EqualUnmodifiableListView) return _episodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episodes);
}


/// Create a copy of EpisodePlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpisodePlayerStateCopyWith<_EpisodePlayerState> get copyWith => __$EpisodePlayerStateCopyWithImpl<_EpisodePlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EpisodePlayerState&&(identical(other.playing, playing) || other.playing == playing)&&(identical(other.processingState, processingState) || other.processingState == processingState)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.buffered, buffered) || other.buffered == buffered)&&(identical(other.total, total) || other.total == total)&&(identical(other.currentEpisode, currentEpisode) || other.currentEpisode == currentEpisode)&&const DeepCollectionEquality().equals(other._episodes, _episodes));
}


@override
int get hashCode => Object.hash(runtimeType,playing,processingState,progress,buffered,total,currentEpisode,const DeepCollectionEquality().hash(_episodes));

@override
String toString() {
  return 'EpisodePlayerState(playing: $playing, processingState: $processingState, progress: $progress, buffered: $buffered, total: $total, currentEpisode: $currentEpisode, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class _$EpisodePlayerStateCopyWith<$Res> implements $EpisodePlayerStateCopyWith<$Res> {
  factory _$EpisodePlayerStateCopyWith(_EpisodePlayerState value, $Res Function(_EpisodePlayerState) _then) = __$EpisodePlayerStateCopyWithImpl;
@override @useResult
$Res call({
 bool playing, AudioProcessingState processingState, Duration progress, Duration buffered, Duration total, Episode? currentEpisode, List<Episode> episodes
});



}
/// @nodoc
class __$EpisodePlayerStateCopyWithImpl<$Res>
    implements _$EpisodePlayerStateCopyWith<$Res> {
  __$EpisodePlayerStateCopyWithImpl(this._self, this._then);

  final _EpisodePlayerState _self;
  final $Res Function(_EpisodePlayerState) _then;

/// Create a copy of EpisodePlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playing = null,Object? processingState = null,Object? progress = null,Object? buffered = null,Object? total = null,Object? currentEpisode = freezed,Object? episodes = null,}) {
  return _then(_EpisodePlayerState(
playing: null == playing ? _self.playing : playing // ignore: cast_nullable_to_non_nullable
as bool,processingState: null == processingState ? _self.processingState : processingState // ignore: cast_nullable_to_non_nullable
as AudioProcessingState,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as Duration,buffered: null == buffered ? _self.buffered : buffered // ignore: cast_nullable_to_non_nullable
as Duration,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as Duration,currentEpisode: freezed == currentEpisode ? _self.currentEpisode : currentEpisode // ignore: cast_nullable_to_non_nullable
as Episode?,episodes: null == episodes ? _self._episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<Episode>,
  ));
}


}

// dart format on
