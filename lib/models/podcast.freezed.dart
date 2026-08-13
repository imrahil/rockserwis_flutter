// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'podcast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Podcast {

@Id() int get id;@Id() set id(int value);@JsonKey(name: 'broadcast_id') int get podcastId;@JsonKey(name: 'broadcast_id') set podcastId(int value);@JsonKey(name: 'broadcast_name') String get podcastName;@JsonKey(name: 'broadcast_name') set podcastName(String value);@JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson) ToMany<Author> get authors;@JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson) set authors(ToMany<Author> value);@JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson) ToMany<Schedule> get schedules;@JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson) set schedules(ToMany<Schedule> value);@JsonKey(name: 'music_only') bool get onlyMusic;@JsonKey(name: 'music_only') set onlyMusic(bool value);@JsonKey(name: 'podcasts_active') bool get isActive;@JsonKey(name: 'podcasts_active') set isActive(bool value);@JsonKey(name: 'has_podcasts') bool get hasEpisodes;@JsonKey(name: 'has_podcasts') set hasEpisodes(bool value); String get image; set image(String value); bool get isFavorited; set isFavorited(bool value);
/// Create a copy of Podcast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PodcastCopyWith<Podcast> get copyWith => _$PodcastCopyWithImpl<Podcast>(this as Podcast, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Podcast&&(identical(other.id, id) || other.id == id)&&(identical(other.podcastId, podcastId) || other.podcastId == podcastId)&&(identical(other.podcastName, podcastName) || other.podcastName == podcastName)&&const DeepCollectionEquality().equals(other.authors, authors)&&const DeepCollectionEquality().equals(other.schedules, schedules)&&(identical(other.onlyMusic, onlyMusic) || other.onlyMusic == onlyMusic)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.hasEpisodes, hasEpisodes) || other.hasEpisodes == hasEpisodes)&&(identical(other.image, image) || other.image == image)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,podcastId,podcastName,const DeepCollectionEquality().hash(authors),const DeepCollectionEquality().hash(schedules),onlyMusic,isActive,hasEpisodes,image,isFavorited);

@override
String toString() {
  return 'Podcast(id: $id, podcastId: $podcastId, podcastName: $podcastName, authors: $authors, schedules: $schedules, onlyMusic: $onlyMusic, isActive: $isActive, hasEpisodes: $hasEpisodes, image: $image, isFavorited: $isFavorited)';
}


}

/// @nodoc
abstract mixin class $PodcastCopyWith<$Res>  {
  factory $PodcastCopyWith(Podcast value, $Res Function(Podcast) _then) = _$PodcastCopyWithImpl;
@useResult
$Res call({
@Id() int id,@JsonKey(name: 'broadcast_id') int podcastId,@JsonKey(name: 'broadcast_name') String podcastName,@JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson) ToMany<Author> authors,@JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson) ToMany<Schedule> schedules,@JsonKey(name: 'music_only') bool onlyMusic,@JsonKey(name: 'podcasts_active') bool isActive,@JsonKey(name: 'has_podcasts') bool hasEpisodes, String image, bool isFavorited
});




}
/// @nodoc
class _$PodcastCopyWithImpl<$Res>
    implements $PodcastCopyWith<$Res> {
  _$PodcastCopyWithImpl(this._self, this._then);

  final Podcast _self;
  final $Res Function(Podcast) _then;

/// Create a copy of Podcast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? podcastId = null,Object? podcastName = null,Object? authors = null,Object? schedules = null,Object? onlyMusic = null,Object? isActive = null,Object? hasEpisodes = null,Object? image = null,Object? isFavorited = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,podcastId: null == podcastId ? _self.podcastId : podcastId // ignore: cast_nullable_to_non_nullable
as int,podcastName: null == podcastName ? _self.podcastName : podcastName // ignore: cast_nullable_to_non_nullable
as String,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as ToMany<Author>,schedules: null == schedules ? _self.schedules : schedules // ignore: cast_nullable_to_non_nullable
as ToMany<Schedule>,onlyMusic: null == onlyMusic ? _self.onlyMusic : onlyMusic // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,hasEpisodes: null == hasEpisodes ? _self.hasEpisodes : hasEpisodes // ignore: cast_nullable_to_non_nullable
as bool,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Podcast].
extension PodcastPatterns on Podcast {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Podcast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Podcast() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Podcast value)  $default,){
final _that = this;
switch (_that) {
case _Podcast():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Podcast value)?  $default,){
final _that = this;
switch (_that) {
case _Podcast() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@Id()  int id, @JsonKey(name: 'broadcast_id')  int podcastId, @JsonKey(name: 'broadcast_name')  String podcastName, @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)  ToMany<Author> authors, @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)  ToMany<Schedule> schedules, @JsonKey(name: 'music_only')  bool onlyMusic, @JsonKey(name: 'podcasts_active')  bool isActive, @JsonKey(name: 'has_podcasts')  bool hasEpisodes,  String image,  bool isFavorited)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Podcast() when $default != null:
return $default(_that.id,_that.podcastId,_that.podcastName,_that.authors,_that.schedules,_that.onlyMusic,_that.isActive,_that.hasEpisodes,_that.image,_that.isFavorited);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@Id()  int id, @JsonKey(name: 'broadcast_id')  int podcastId, @JsonKey(name: 'broadcast_name')  String podcastName, @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)  ToMany<Author> authors, @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)  ToMany<Schedule> schedules, @JsonKey(name: 'music_only')  bool onlyMusic, @JsonKey(name: 'podcasts_active')  bool isActive, @JsonKey(name: 'has_podcasts')  bool hasEpisodes,  String image,  bool isFavorited)  $default,) {final _that = this;
switch (_that) {
case _Podcast():
return $default(_that.id,_that.podcastId,_that.podcastName,_that.authors,_that.schedules,_that.onlyMusic,_that.isActive,_that.hasEpisodes,_that.image,_that.isFavorited);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@Id()  int id, @JsonKey(name: 'broadcast_id')  int podcastId, @JsonKey(name: 'broadcast_name')  String podcastName, @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)  ToMany<Author> authors, @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)  ToMany<Schedule> schedules, @JsonKey(name: 'music_only')  bool onlyMusic, @JsonKey(name: 'podcasts_active')  bool isActive, @JsonKey(name: 'has_podcasts')  bool hasEpisodes,  String image,  bool isFavorited)?  $default,) {final _that = this;
switch (_that) {
case _Podcast() when $default != null:
return $default(_that.id,_that.podcastId,_that.podcastName,_that.authors,_that.schedules,_that.onlyMusic,_that.isActive,_that.hasEpisodes,_that.image,_that.isFavorited);case _:
  return null;

}
}

}

/// @nodoc

@Entity(realClass: Podcast)
@JsonSerializable(createToJson: false)
class _Podcast implements Podcast {
   _Podcast({@Id() this.id = 0, @JsonKey(name: 'broadcast_id') required this.podcastId, @JsonKey(name: 'broadcast_name') required this.podcastName, @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson) required this.authors, @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson) required this.schedules, @JsonKey(name: 'music_only') required this.onlyMusic, @JsonKey(name: 'podcasts_active') required this.isActive, @JsonKey(name: 'has_podcasts') required this.hasEpisodes, this.image = "", this.isFavorited = false});
  factory _Podcast.fromJson(Map<String, dynamic> json) => _$PodcastFromJson(json);

@override@JsonKey()@Id()  int id;
@override@JsonKey(name: 'broadcast_id')  int podcastId;
@override@JsonKey(name: 'broadcast_name')  String podcastName;
@override@JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)  ToMany<Author> authors;
@override@JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)  ToMany<Schedule> schedules;
@override@JsonKey(name: 'music_only')  bool onlyMusic;
@override@JsonKey(name: 'podcasts_active')  bool isActive;
@override@JsonKey(name: 'has_podcasts')  bool hasEpisodes;
@override@JsonKey()  String image;
@override@JsonKey()  bool isFavorited;

/// Create a copy of Podcast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PodcastCopyWith<_Podcast> get copyWith => __$PodcastCopyWithImpl<_Podcast>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Podcast&&(identical(other.id, id) || other.id == id)&&(identical(other.podcastId, podcastId) || other.podcastId == podcastId)&&(identical(other.podcastName, podcastName) || other.podcastName == podcastName)&&const DeepCollectionEquality().equals(other.authors, authors)&&const DeepCollectionEquality().equals(other.schedules, schedules)&&(identical(other.onlyMusic, onlyMusic) || other.onlyMusic == onlyMusic)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.hasEpisodes, hasEpisodes) || other.hasEpisodes == hasEpisodes)&&(identical(other.image, image) || other.image == image)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,podcastId,podcastName,const DeepCollectionEquality().hash(authors),const DeepCollectionEquality().hash(schedules),onlyMusic,isActive,hasEpisodes,image,isFavorited);

@override
String toString() {
  return 'Podcast(id: $id, podcastId: $podcastId, podcastName: $podcastName, authors: $authors, schedules: $schedules, onlyMusic: $onlyMusic, isActive: $isActive, hasEpisodes: $hasEpisodes, image: $image, isFavorited: $isFavorited)';
}


}

/// @nodoc
abstract mixin class _$PodcastCopyWith<$Res> implements $PodcastCopyWith<$Res> {
  factory _$PodcastCopyWith(_Podcast value, $Res Function(_Podcast) _then) = __$PodcastCopyWithImpl;
@override @useResult
$Res call({
@Id() int id,@JsonKey(name: 'broadcast_id') int podcastId,@JsonKey(name: 'broadcast_name') String podcastName,@JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson) ToMany<Author> authors,@JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson) ToMany<Schedule> schedules,@JsonKey(name: 'music_only') bool onlyMusic,@JsonKey(name: 'podcasts_active') bool isActive,@JsonKey(name: 'has_podcasts') bool hasEpisodes, String image, bool isFavorited
});




}
/// @nodoc
class __$PodcastCopyWithImpl<$Res>
    implements _$PodcastCopyWith<$Res> {
  __$PodcastCopyWithImpl(this._self, this._then);

  final _Podcast _self;
  final $Res Function(_Podcast) _then;

/// Create a copy of Podcast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? podcastId = null,Object? podcastName = null,Object? authors = null,Object? schedules = null,Object? onlyMusic = null,Object? isActive = null,Object? hasEpisodes = null,Object? image = null,Object? isFavorited = null,}) {
  return _then(_Podcast(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,podcastId: null == podcastId ? _self.podcastId : podcastId // ignore: cast_nullable_to_non_nullable
as int,podcastName: null == podcastName ? _self.podcastName : podcastName // ignore: cast_nullable_to_non_nullable
as String,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as ToMany<Author>,schedules: null == schedules ? _self.schedules : schedules // ignore: cast_nullable_to_non_nullable
as ToMany<Schedule>,onlyMusic: null == onlyMusic ? _self.onlyMusic : onlyMusic // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,hasEpisodes: null == hasEpisodes ? _self.hasEpisodes : hasEpisodes // ignore: cast_nullable_to_non_nullable
as bool,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
