// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return _Episode.fromJson(json);
}

/// @nodoc
mixin _$Episode {
  @Id()
  int get id => throw _privateConstructorUsedError;
  @Id()
  set id(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'schedule_id')
  int get episodeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'schedule_id')
  set episodeId(int value) => throw _privateConstructorUsedError;
  int? get podcastId => throw _privateConstructorUsedError;
  set podcastId(int? value) => throw _privateConstructorUsedError;
  @Property(type: PropertyType.dateNano)
  DateTime get date => throw _privateConstructorUsedError;
  @Property(type: PropertyType.dateNano)
  set date(DateTime value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'img_path')
  String get imgPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'img_path')
  set imgPath(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'podcast_duration')
  double get episodeDuration => throw _privateConstructorUsedError;
  @JsonKey(name: 'podcast_duration')
  set episodeDuration(double value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_podcast')
  bool get hasPodcast => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_podcast')
  set hasPodcast(bool value) => throw _privateConstructorUsedError;
  bool get isFavorited => throw _privateConstructorUsedError;
  set isFavorited(bool value) => throw _privateConstructorUsedError;

  /// Serializes this Episode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodeCopyWith<Episode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) then) =
      _$EpisodeCopyWithImpl<$Res, Episode>;
  @useResult
  $Res call(
      {@Id() int id,
      @JsonKey(name: 'schedule_id') int episodeId,
      int? podcastId,
      @Property(type: PropertyType.dateNano) DateTime date,
      String name,
      @JsonKey(name: 'img_path') String imgPath,
      @JsonKey(name: 'podcast_duration') double episodeDuration,
      @JsonKey(name: 'has_podcast') bool hasPodcast,
      bool isFavorited});
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res, $Val extends Episode>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? episodeId = null,
    Object? podcastId = freezed,
    Object? date = null,
    Object? name = null,
    Object? imgPath = null,
    Object? episodeDuration = null,
    Object? hasPodcast = null,
    Object? isFavorited = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      episodeId: null == episodeId
          ? _value.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as int,
      podcastId: freezed == podcastId
          ? _value.podcastId
          : podcastId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imgPath: null == imgPath
          ? _value.imgPath
          : imgPath // ignore: cast_nullable_to_non_nullable
              as String,
      episodeDuration: null == episodeDuration
          ? _value.episodeDuration
          : episodeDuration // ignore: cast_nullable_to_non_nullable
              as double,
      hasPodcast: null == hasPodcast
          ? _value.hasPodcast
          : hasPodcast // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorited: null == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EpisodeImplCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$$EpisodeImplCopyWith(
          _$EpisodeImpl value, $Res Function(_$EpisodeImpl) then) =
      __$$EpisodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Id() int id,
      @JsonKey(name: 'schedule_id') int episodeId,
      int? podcastId,
      @Property(type: PropertyType.dateNano) DateTime date,
      String name,
      @JsonKey(name: 'img_path') String imgPath,
      @JsonKey(name: 'podcast_duration') double episodeDuration,
      @JsonKey(name: 'has_podcast') bool hasPodcast,
      bool isFavorited});
}

/// @nodoc
class __$$EpisodeImplCopyWithImpl<$Res>
    extends _$EpisodeCopyWithImpl<$Res, _$EpisodeImpl>
    implements _$$EpisodeImplCopyWith<$Res> {
  __$$EpisodeImplCopyWithImpl(
      _$EpisodeImpl _value, $Res Function(_$EpisodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? episodeId = null,
    Object? podcastId = freezed,
    Object? date = null,
    Object? name = null,
    Object? imgPath = null,
    Object? episodeDuration = null,
    Object? hasPodcast = null,
    Object? isFavorited = null,
  }) {
    return _then(_$EpisodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      episodeId: null == episodeId
          ? _value.episodeId
          : episodeId // ignore: cast_nullable_to_non_nullable
              as int,
      podcastId: freezed == podcastId
          ? _value.podcastId
          : podcastId // ignore: cast_nullable_to_non_nullable
              as int?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imgPath: null == imgPath
          ? _value.imgPath
          : imgPath // ignore: cast_nullable_to_non_nullable
              as String,
      episodeDuration: null == episodeDuration
          ? _value.episodeDuration
          : episodeDuration // ignore: cast_nullable_to_non_nullable
              as double,
      hasPodcast: null == hasPodcast
          ? _value.hasPodcast
          : hasPodcast // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorited: null == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@Entity(realClass: Episode)
class _$EpisodeImpl extends _Episode {
  _$EpisodeImpl(
      {@Id() this.id = 0,
      @JsonKey(name: 'schedule_id') required this.episodeId,
      this.podcastId,
      @Property(type: PropertyType.dateNano) required this.date,
      required this.name,
      @JsonKey(name: 'img_path') this.imgPath = "",
      @JsonKey(name: 'podcast_duration') this.episodeDuration = 0.0,
      @JsonKey(name: 'has_podcast') required this.hasPodcast,
      this.isFavorited = false})
      : super._();

  factory _$EpisodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EpisodeImplFromJson(json);

  @override
  @JsonKey()
  @Id()
  int id;
  @override
  @JsonKey(name: 'schedule_id')
  int episodeId;
  @override
  int? podcastId;
  @override
  @Property(type: PropertyType.dateNano)
  DateTime date;
  @override
  String name;
  @override
  @JsonKey(name: 'img_path')
  String imgPath;
  @override
  @JsonKey(name: 'podcast_duration')
  double episodeDuration;
  @override
  @JsonKey(name: 'has_podcast')
  bool hasPodcast;
  @override
  @JsonKey()
  bool isFavorited;

  @override
  String toString() {
    return 'Episode(id: $id, episodeId: $episodeId, podcastId: $podcastId, date: $date, name: $name, imgPath: $imgPath, episodeDuration: $episodeDuration, hasPodcast: $hasPodcast, isFavorited: $isFavorited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.episodeId, episodeId) ||
                other.episodeId == episodeId) &&
            (identical(other.podcastId, podcastId) ||
                other.podcastId == podcastId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imgPath, imgPath) || other.imgPath == imgPath) &&
            (identical(other.episodeDuration, episodeDuration) ||
                other.episodeDuration == episodeDuration) &&
            (identical(other.hasPodcast, hasPodcast) ||
                other.hasPodcast == hasPodcast) &&
            (identical(other.isFavorited, isFavorited) ||
                other.isFavorited == isFavorited));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, episodeId, podcastId, date,
      name, imgPath, episodeDuration, hasPodcast, isFavorited);

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      __$$EpisodeImplCopyWithImpl<_$EpisodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EpisodeImplToJson(
      this,
    );
  }
}

abstract class _Episode extends Episode {
  factory _Episode(
      {@Id() int id,
      @JsonKey(name: 'schedule_id') required int episodeId,
      int? podcastId,
      @Property(type: PropertyType.dateNano) required DateTime date,
      required String name,
      @JsonKey(name: 'img_path') String imgPath,
      @JsonKey(name: 'podcast_duration') double episodeDuration,
      @JsonKey(name: 'has_podcast') required bool hasPodcast,
      bool isFavorited}) = _$EpisodeImpl;
  _Episode._() : super._();

  factory _Episode.fromJson(Map<String, dynamic> json) = _$EpisodeImpl.fromJson;

  @override
  @Id()
  int get id;
  @Id()
  set id(int value);
  @override
  @JsonKey(name: 'schedule_id')
  int get episodeId;
  @JsonKey(name: 'schedule_id')
  set episodeId(int value);
  @override
  int? get podcastId;
  set podcastId(int? value);
  @override
  @Property(type: PropertyType.dateNano)
  DateTime get date;
  @Property(type: PropertyType.dateNano)
  set date(DateTime value);
  @override
  String get name;
  set name(String value);
  @override
  @JsonKey(name: 'img_path')
  String get imgPath;
  @JsonKey(name: 'img_path')
  set imgPath(String value);
  @override
  @JsonKey(name: 'podcast_duration')
  double get episodeDuration;
  @JsonKey(name: 'podcast_duration')
  set episodeDuration(double value);
  @override
  @JsonKey(name: 'has_podcast')
  bool get hasPodcast;
  @JsonKey(name: 'has_podcast')
  set hasPodcast(bool value);
  @override
  bool get isFavorited;
  set isFavorited(bool value);

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodeImplCopyWith<_$EpisodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
