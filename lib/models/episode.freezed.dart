// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Episode {

@Id() int get id;@Id() set id(int value);@JsonKey(name: 'schedule_id') int get episodeId;@JsonKey(name: 'schedule_id') set episodeId(int value); int? get podcastId; set podcastId(int? value);@Property(type: PropertyType.dateNano) DateTime get date;@Property(type: PropertyType.dateNano) set date(DateTime value); String get name; set name(String value);@JsonKey(name: 'img_path') String get imgPath;@JsonKey(name: 'img_path') set imgPath(String value);@JsonKey(name: 'podcast_duration') double get episodeDuration;@JsonKey(name: 'podcast_duration') set episodeDuration(double value);@JsonKey(name: 'has_podcast') bool get hasPodcast;@JsonKey(name: 'has_podcast') set hasPodcast(bool value); bool get isFavorited; set isFavorited(bool value);@Property(type: PropertyType.dateNano) DateTime? get updatedAt;@Property(type: PropertyType.dateNano) set updatedAt(DateTime? value); int get progress; set progress(int value); int get total; set total(int value); String? get downloadedPath; set downloadedPath(String? value);
/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EpisodeCopyWith<Episode> get copyWith => _$EpisodeCopyWithImpl<Episode>(this as Episode, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Episode&&(identical(other.id, id) || other.id == id)&&(identical(other.episodeId, episodeId) || other.episodeId == episodeId)&&(identical(other.podcastId, podcastId) || other.podcastId == podcastId)&&(identical(other.date, date) || other.date == date)&&(identical(other.name, name) || other.name == name)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath)&&(identical(other.episodeDuration, episodeDuration) || other.episodeDuration == episodeDuration)&&(identical(other.hasPodcast, hasPodcast) || other.hasPodcast == hasPodcast)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.total, total) || other.total == total)&&(identical(other.downloadedPath, downloadedPath) || other.downloadedPath == downloadedPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,episodeId,podcastId,date,name,imgPath,episodeDuration,hasPodcast,isFavorited,updatedAt,progress,total,downloadedPath);

@override
String toString() {
  return 'Episode(id: $id, episodeId: $episodeId, podcastId: $podcastId, date: $date, name: $name, imgPath: $imgPath, episodeDuration: $episodeDuration, hasPodcast: $hasPodcast, isFavorited: $isFavorited, updatedAt: $updatedAt, progress: $progress, total: $total, downloadedPath: $downloadedPath)';
}


}

/// @nodoc
abstract mixin class $EpisodeCopyWith<$Res>  {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) _then) = _$EpisodeCopyWithImpl;
@useResult
$Res call({
@Id() int id,@JsonKey(name: 'schedule_id') int episodeId, int? podcastId,@Property(type: PropertyType.dateNano) DateTime date, String name,@JsonKey(name: 'img_path') String imgPath,@JsonKey(name: 'podcast_duration') double episodeDuration,@JsonKey(name: 'has_podcast') bool hasPodcast, bool isFavorited,@Property(type: PropertyType.dateNano) DateTime? updatedAt, int progress, int total, String? downloadedPath
});




}
/// @nodoc
class _$EpisodeCopyWithImpl<$Res>
    implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._self, this._then);

  final Episode _self;
  final $Res Function(Episode) _then;

/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? episodeId = null,Object? podcastId = freezed,Object? date = null,Object? name = null,Object? imgPath = null,Object? episodeDuration = null,Object? hasPodcast = null,Object? isFavorited = null,Object? updatedAt = freezed,Object? progress = null,Object? total = null,Object? downloadedPath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,episodeId: null == episodeId ? _self.episodeId : episodeId // ignore: cast_nullable_to_non_nullable
as int,podcastId: freezed == podcastId ? _self.podcastId : podcastId // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imgPath: null == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String,episodeDuration: null == episodeDuration ? _self.episodeDuration : episodeDuration // ignore: cast_nullable_to_non_nullable
as double,hasPodcast: null == hasPodcast ? _self.hasPodcast : hasPodcast // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,downloadedPath: freezed == downloadedPath ? _self.downloadedPath : downloadedPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Episode].
extension EpisodePatterns on Episode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Episode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Episode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Episode value)  $default,){
final _that = this;
switch (_that) {
case _Episode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Episode value)?  $default,){
final _that = this;
switch (_that) {
case _Episode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@Id()  int id, @JsonKey(name: 'schedule_id')  int episodeId,  int? podcastId, @Property(type: PropertyType.dateNano)  DateTime date,  String name, @JsonKey(name: 'img_path')  String imgPath, @JsonKey(name: 'podcast_duration')  double episodeDuration, @JsonKey(name: 'has_podcast')  bool hasPodcast,  bool isFavorited, @Property(type: PropertyType.dateNano)  DateTime? updatedAt,  int progress,  int total,  String? downloadedPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Episode() when $default != null:
return $default(_that.id,_that.episodeId,_that.podcastId,_that.date,_that.name,_that.imgPath,_that.episodeDuration,_that.hasPodcast,_that.isFavorited,_that.updatedAt,_that.progress,_that.total,_that.downloadedPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@Id()  int id, @JsonKey(name: 'schedule_id')  int episodeId,  int? podcastId, @Property(type: PropertyType.dateNano)  DateTime date,  String name, @JsonKey(name: 'img_path')  String imgPath, @JsonKey(name: 'podcast_duration')  double episodeDuration, @JsonKey(name: 'has_podcast')  bool hasPodcast,  bool isFavorited, @Property(type: PropertyType.dateNano)  DateTime? updatedAt,  int progress,  int total,  String? downloadedPath)  $default,) {final _that = this;
switch (_that) {
case _Episode():
return $default(_that.id,_that.episodeId,_that.podcastId,_that.date,_that.name,_that.imgPath,_that.episodeDuration,_that.hasPodcast,_that.isFavorited,_that.updatedAt,_that.progress,_that.total,_that.downloadedPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@Id()  int id, @JsonKey(name: 'schedule_id')  int episodeId,  int? podcastId, @Property(type: PropertyType.dateNano)  DateTime date,  String name, @JsonKey(name: 'img_path')  String imgPath, @JsonKey(name: 'podcast_duration')  double episodeDuration, @JsonKey(name: 'has_podcast')  bool hasPodcast,  bool isFavorited, @Property(type: PropertyType.dateNano)  DateTime? updatedAt,  int progress,  int total,  String? downloadedPath)?  $default,) {final _that = this;
switch (_that) {
case _Episode() when $default != null:
return $default(_that.id,_that.episodeId,_that.podcastId,_that.date,_that.name,_that.imgPath,_that.episodeDuration,_that.hasPodcast,_that.isFavorited,_that.updatedAt,_that.progress,_that.total,_that.downloadedPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)
@Entity(realClass: Episode)
class _Episode extends Episode {
   _Episode({@Id() this.id = 0, @JsonKey(name: 'schedule_id') required this.episodeId, this.podcastId, @Property(type: PropertyType.dateNano) required this.date, required this.name, @JsonKey(name: 'img_path') this.imgPath = "", @JsonKey(name: 'podcast_duration') this.episodeDuration = 0.0, @JsonKey(name: 'has_podcast') required this.hasPodcast, this.isFavorited = false, @Property(type: PropertyType.dateNano) this.updatedAt, this.progress = 0, this.total = 0, this.downloadedPath}): super._();
  factory _Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

@override@JsonKey()@Id()  int id;
@override@JsonKey(name: 'schedule_id')  int episodeId;
@override  int? podcastId;
@override@Property(type: PropertyType.dateNano)  DateTime date;
@override  String name;
@override@JsonKey(name: 'img_path')  String imgPath;
@override@JsonKey(name: 'podcast_duration')  double episodeDuration;
@override@JsonKey(name: 'has_podcast')  bool hasPodcast;
@override@JsonKey()  bool isFavorited;
@override@Property(type: PropertyType.dateNano)  DateTime? updatedAt;
@override@JsonKey()  int progress;
@override@JsonKey()  int total;
@override  String? downloadedPath;

/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EpisodeCopyWith<_Episode> get copyWith => __$EpisodeCopyWithImpl<_Episode>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Episode&&(identical(other.id, id) || other.id == id)&&(identical(other.episodeId, episodeId) || other.episodeId == episodeId)&&(identical(other.podcastId, podcastId) || other.podcastId == podcastId)&&(identical(other.date, date) || other.date == date)&&(identical(other.name, name) || other.name == name)&&(identical(other.imgPath, imgPath) || other.imgPath == imgPath)&&(identical(other.episodeDuration, episodeDuration) || other.episodeDuration == episodeDuration)&&(identical(other.hasPodcast, hasPodcast) || other.hasPodcast == hasPodcast)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.total, total) || other.total == total)&&(identical(other.downloadedPath, downloadedPath) || other.downloadedPath == downloadedPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,episodeId,podcastId,date,name,imgPath,episodeDuration,hasPodcast,isFavorited,updatedAt,progress,total,downloadedPath);

@override
String toString() {
  return 'Episode(id: $id, episodeId: $episodeId, podcastId: $podcastId, date: $date, name: $name, imgPath: $imgPath, episodeDuration: $episodeDuration, hasPodcast: $hasPodcast, isFavorited: $isFavorited, updatedAt: $updatedAt, progress: $progress, total: $total, downloadedPath: $downloadedPath)';
}


}

/// @nodoc
abstract mixin class _$EpisodeCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$EpisodeCopyWith(_Episode value, $Res Function(_Episode) _then) = __$EpisodeCopyWithImpl;
@override @useResult
$Res call({
@Id() int id,@JsonKey(name: 'schedule_id') int episodeId, int? podcastId,@Property(type: PropertyType.dateNano) DateTime date, String name,@JsonKey(name: 'img_path') String imgPath,@JsonKey(name: 'podcast_duration') double episodeDuration,@JsonKey(name: 'has_podcast') bool hasPodcast, bool isFavorited,@Property(type: PropertyType.dateNano) DateTime? updatedAt, int progress, int total, String? downloadedPath
});




}
/// @nodoc
class __$EpisodeCopyWithImpl<$Res>
    implements _$EpisodeCopyWith<$Res> {
  __$EpisodeCopyWithImpl(this._self, this._then);

  final _Episode _self;
  final $Res Function(_Episode) _then;

/// Create a copy of Episode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? episodeId = null,Object? podcastId = freezed,Object? date = null,Object? name = null,Object? imgPath = null,Object? episodeDuration = null,Object? hasPodcast = null,Object? isFavorited = null,Object? updatedAt = freezed,Object? progress = null,Object? total = null,Object? downloadedPath = freezed,}) {
  return _then(_Episode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,episodeId: null == episodeId ? _self.episodeId : episodeId // ignore: cast_nullable_to_non_nullable
as int,podcastId: freezed == podcastId ? _self.podcastId : podcastId // ignore: cast_nullable_to_non_nullable
as int?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imgPath: null == imgPath ? _self.imgPath : imgPath // ignore: cast_nullable_to_non_nullable
as String,episodeDuration: null == episodeDuration ? _self.episodeDuration : episodeDuration // ignore: cast_nullable_to_non_nullable
as double,hasPodcast: null == hasPodcast ? _self.hasPodcast : hasPodcast // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,downloadedPath: freezed == downloadedPath ? _self.downloadedPath : downloadedPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
