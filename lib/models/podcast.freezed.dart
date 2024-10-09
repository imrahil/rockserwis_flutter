// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'podcast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Podcast _$PodcastFromJson(Map<String, dynamic> json) {
  return _Podcast.fromJson(json);
}

/// @nodoc
mixin _$Podcast {
  @Id()
  int get id => throw _privateConstructorUsedError;
  @Id()
  set id(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_id')
  int get podcastId => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_id')
  set podcastId(int value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_name')
  String get podcastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_name')
  set podcastName(String value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
  ToMany<Author> get authors => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
  set authors(ToMany<Author> value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
  ToMany<Schedule> get schedules => throw _privateConstructorUsedError;
  @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
  set schedules(ToMany<Schedule> value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'music_only')
  bool get onlyMusic => throw _privateConstructorUsedError;
  @JsonKey(name: 'music_only')
  set onlyMusic(bool value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'podcasts_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'podcasts_active')
  set isActive(bool value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_podcasts')
  bool get hasEpisodes => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_podcasts')
  set hasEpisodes(bool value) => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  set image(String value) => throw _privateConstructorUsedError;
  bool get isFavorited => throw _privateConstructorUsedError;
  set isFavorited(bool value) => throw _privateConstructorUsedError;

  /// Create a copy of Podcast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PodcastCopyWith<Podcast> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PodcastCopyWith<$Res> {
  factory $PodcastCopyWith(Podcast value, $Res Function(Podcast) then) =
      _$PodcastCopyWithImpl<$Res, Podcast>;
  @useResult
  $Res call(
      {@Id() int id,
      @JsonKey(name: 'broadcast_id') int podcastId,
      @JsonKey(name: 'broadcast_name') String podcastName,
      @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
      ToMany<Author> authors,
      @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
      ToMany<Schedule> schedules,
      @JsonKey(name: 'music_only') bool onlyMusic,
      @JsonKey(name: 'podcasts_active') bool isActive,
      @JsonKey(name: 'has_podcasts') bool hasEpisodes,
      String image,
      bool isFavorited});
}

/// @nodoc
class _$PodcastCopyWithImpl<$Res, $Val extends Podcast>
    implements $PodcastCopyWith<$Res> {
  _$PodcastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Podcast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? podcastId = null,
    Object? podcastName = null,
    Object? authors = null,
    Object? schedules = null,
    Object? onlyMusic = null,
    Object? isActive = null,
    Object? hasEpisodes = null,
    Object? image = null,
    Object? isFavorited = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      podcastId: null == podcastId
          ? _value.podcastId
          : podcastId // ignore: cast_nullable_to_non_nullable
              as int,
      podcastName: null == podcastName
          ? _value.podcastName
          : podcastName // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as ToMany<Author>,
      schedules: null == schedules
          ? _value.schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as ToMany<Schedule>,
      onlyMusic: null == onlyMusic
          ? _value.onlyMusic
          : onlyMusic // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      hasEpisodes: null == hasEpisodes
          ? _value.hasEpisodes
          : hasEpisodes // ignore: cast_nullable_to_non_nullable
              as bool,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorited: null == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PodcastImplCopyWith<$Res> implements $PodcastCopyWith<$Res> {
  factory _$$PodcastImplCopyWith(
          _$PodcastImpl value, $Res Function(_$PodcastImpl) then) =
      __$$PodcastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Id() int id,
      @JsonKey(name: 'broadcast_id') int podcastId,
      @JsonKey(name: 'broadcast_name') String podcastName,
      @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
      ToMany<Author> authors,
      @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
      ToMany<Schedule> schedules,
      @JsonKey(name: 'music_only') bool onlyMusic,
      @JsonKey(name: 'podcasts_active') bool isActive,
      @JsonKey(name: 'has_podcasts') bool hasEpisodes,
      String image,
      bool isFavorited});
}

/// @nodoc
class __$$PodcastImplCopyWithImpl<$Res>
    extends _$PodcastCopyWithImpl<$Res, _$PodcastImpl>
    implements _$$PodcastImplCopyWith<$Res> {
  __$$PodcastImplCopyWithImpl(
      _$PodcastImpl _value, $Res Function(_$PodcastImpl) _then)
      : super(_value, _then);

  /// Create a copy of Podcast
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? podcastId = null,
    Object? podcastName = null,
    Object? authors = null,
    Object? schedules = null,
    Object? onlyMusic = null,
    Object? isActive = null,
    Object? hasEpisodes = null,
    Object? image = null,
    Object? isFavorited = null,
  }) {
    return _then(_$PodcastImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      podcastId: null == podcastId
          ? _value.podcastId
          : podcastId // ignore: cast_nullable_to_non_nullable
              as int,
      podcastName: null == podcastName
          ? _value.podcastName
          : podcastName // ignore: cast_nullable_to_non_nullable
              as String,
      authors: null == authors
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as ToMany<Author>,
      schedules: null == schedules
          ? _value.schedules
          : schedules // ignore: cast_nullable_to_non_nullable
              as ToMany<Schedule>,
      onlyMusic: null == onlyMusic
          ? _value.onlyMusic
          : onlyMusic // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      hasEpisodes: null == hasEpisodes
          ? _value.hasEpisodes
          : hasEpisodes // ignore: cast_nullable_to_non_nullable
              as bool,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorited: null == isFavorited
          ? _value.isFavorited
          : isFavorited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@Entity(realClass: Podcast)
@JsonSerializable(createToJson: false)
class _$PodcastImpl implements _Podcast {
  _$PodcastImpl(
      {@Id() this.id = 0,
      @JsonKey(name: 'broadcast_id') required this.podcastId,
      @JsonKey(name: 'broadcast_name') required this.podcastName,
      @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
      required this.authors,
      @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
      required this.schedules,
      @JsonKey(name: 'music_only') required this.onlyMusic,
      @JsonKey(name: 'podcasts_active') required this.isActive,
      @JsonKey(name: 'has_podcasts') required this.hasEpisodes,
      this.image = "",
      this.isFavorited = false});

  factory _$PodcastImpl.fromJson(Map<String, dynamic> json) =>
      _$$PodcastImplFromJson(json);

  @override
  @JsonKey()
  @Id()
  int id;
  @override
  @JsonKey(name: 'broadcast_id')
  int podcastId;
  @override
  @JsonKey(name: 'broadcast_name')
  String podcastName;
  @override
  @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
  ToMany<Author> authors;
  @override
  @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
  ToMany<Schedule> schedules;
  @override
  @JsonKey(name: 'music_only')
  bool onlyMusic;
  @override
  @JsonKey(name: 'podcasts_active')
  bool isActive;
  @override
  @JsonKey(name: 'has_podcasts')
  bool hasEpisodes;
  @override
  @JsonKey()
  String image;
  @override
  @JsonKey()
  bool isFavorited;

  @override
  String toString() {
    return 'Podcast(id: $id, podcastId: $podcastId, podcastName: $podcastName, authors: $authors, schedules: $schedules, onlyMusic: $onlyMusic, isActive: $isActive, hasEpisodes: $hasEpisodes, image: $image, isFavorited: $isFavorited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PodcastImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.podcastId, podcastId) ||
                other.podcastId == podcastId) &&
            (identical(other.podcastName, podcastName) ||
                other.podcastName == podcastName) &&
            const DeepCollectionEquality().equals(other.authors, authors) &&
            const DeepCollectionEquality().equals(other.schedules, schedules) &&
            (identical(other.onlyMusic, onlyMusic) ||
                other.onlyMusic == onlyMusic) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.hasEpisodes, hasEpisodes) ||
                other.hasEpisodes == hasEpisodes) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isFavorited, isFavorited) ||
                other.isFavorited == isFavorited));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      podcastId,
      podcastName,
      const DeepCollectionEquality().hash(authors),
      const DeepCollectionEquality().hash(schedules),
      onlyMusic,
      isActive,
      hasEpisodes,
      image,
      isFavorited);

  /// Create a copy of Podcast
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PodcastImplCopyWith<_$PodcastImpl> get copyWith =>
      __$$PodcastImplCopyWithImpl<_$PodcastImpl>(this, _$identity);
}

abstract class _Podcast implements Podcast {
  factory _Podcast(
      {@Id() int id,
      @JsonKey(name: 'broadcast_id') required int podcastId,
      @JsonKey(name: 'broadcast_name') required String podcastName,
      @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
      required ToMany<Author> authors,
      @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
      required ToMany<Schedule> schedules,
      @JsonKey(name: 'music_only') required bool onlyMusic,
      @JsonKey(name: 'podcasts_active') required bool isActive,
      @JsonKey(name: 'has_podcasts') required bool hasEpisodes,
      String image,
      bool isFavorited}) = _$PodcastImpl;

  factory _Podcast.fromJson(Map<String, dynamic> json) = _$PodcastImpl.fromJson;

  @override
  @Id()
  int get id;
  @Id()
  set id(int value);
  @override
  @JsonKey(name: 'broadcast_id')
  int get podcastId;
  @JsonKey(name: 'broadcast_id')
  set podcastId(int value);
  @override
  @JsonKey(name: 'broadcast_name')
  String get podcastName;
  @JsonKey(name: 'broadcast_name')
  set podcastName(String value);
  @override
  @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
  ToMany<Author> get authors;
  @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
  set authors(ToMany<Author> value);
  @override
  @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
  ToMany<Schedule> get schedules;
  @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
  set schedules(ToMany<Schedule> value);
  @override
  @JsonKey(name: 'music_only')
  bool get onlyMusic;
  @JsonKey(name: 'music_only')
  set onlyMusic(bool value);
  @override
  @JsonKey(name: 'podcasts_active')
  bool get isActive;
  @JsonKey(name: 'podcasts_active')
  set isActive(bool value);
  @override
  @JsonKey(name: 'has_podcasts')
  bool get hasEpisodes;
  @JsonKey(name: 'has_podcasts')
  set hasEpisodes(bool value);
  @override
  String get image;
  set image(String value);
  @override
  bool get isFavorited;
  set isFavorited(bool value);

  /// Create a copy of Podcast
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PodcastImplCopyWith<_$PodcastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
