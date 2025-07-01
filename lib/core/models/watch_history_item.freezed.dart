// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watch_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WatchHistoryItem _$WatchHistoryItemFromJson(Map<String, dynamic> json) {
  return _WatchHistoryItem.fromJson(json);
}

/// @nodoc
mixin _$WatchHistoryItem {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get mediaId => throw _privateConstructorUsedError;
  String get mediaType => throw _privateConstructorUsedError; // 'movie' or 'tv'
  String get title => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get backdropPath => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  String? get preferredSource => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int? get seasonNumber => throw _privateConstructorUsedError;
  int? get episodeNumber => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  int? get watchPosition => throw _privateConstructorUsedError;

  /// Serializes this WatchHistoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WatchHistoryItemCopyWith<WatchHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchHistoryItemCopyWith<$Res> {
  factory $WatchHistoryItemCopyWith(
          WatchHistoryItem value, $Res Function(WatchHistoryItem) then) =
      _$WatchHistoryItemCopyWithImpl<$Res, WatchHistoryItem>;
  @useResult
  $Res call(
      {String id,
      String userId,
      int mediaId,
      String mediaType,
      String title,
      String? overview,
      String? backdropPath,
      String? posterPath,
      String? preferredSource,
      double? rating,
      int? seasonNumber,
      int? episodeNumber,
      DateTime createdAt,
      int? duration,
      int? watchPosition});
}

/// @nodoc
class _$WatchHistoryItemCopyWithImpl<$Res, $Val extends WatchHistoryItem>
    implements $WatchHistoryItemCopyWith<$Res> {
  _$WatchHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? mediaId = null,
    Object? mediaType = null,
    Object? title = null,
    Object? overview = freezed,
    Object? backdropPath = freezed,
    Object? posterPath = freezed,
    Object? preferredSource = freezed,
    Object? rating = freezed,
    Object? seasonNumber = freezed,
    Object? episodeNumber = freezed,
    Object? createdAt = null,
    Object? duration = freezed,
    Object? watchPosition = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaId: null == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredSource: freezed == preferredSource
          ? _value.preferredSource
          : preferredSource // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      seasonNumber: freezed == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      episodeNumber: freezed == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      watchPosition: freezed == watchPosition
          ? _value.watchPosition
          : watchPosition // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WatchHistoryItemImplCopyWith<$Res>
    implements $WatchHistoryItemCopyWith<$Res> {
  factory _$$WatchHistoryItemImplCopyWith(_$WatchHistoryItemImpl value,
          $Res Function(_$WatchHistoryItemImpl) then) =
      __$$WatchHistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      int mediaId,
      String mediaType,
      String title,
      String? overview,
      String? backdropPath,
      String? posterPath,
      String? preferredSource,
      double? rating,
      int? seasonNumber,
      int? episodeNumber,
      DateTime createdAt,
      int? duration,
      int? watchPosition});
}

/// @nodoc
class __$$WatchHistoryItemImplCopyWithImpl<$Res>
    extends _$WatchHistoryItemCopyWithImpl<$Res, _$WatchHistoryItemImpl>
    implements _$$WatchHistoryItemImplCopyWith<$Res> {
  __$$WatchHistoryItemImplCopyWithImpl(_$WatchHistoryItemImpl _value,
      $Res Function(_$WatchHistoryItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? mediaId = null,
    Object? mediaType = null,
    Object? title = null,
    Object? overview = freezed,
    Object? backdropPath = freezed,
    Object? posterPath = freezed,
    Object? preferredSource = freezed,
    Object? rating = freezed,
    Object? seasonNumber = freezed,
    Object? episodeNumber = freezed,
    Object? createdAt = null,
    Object? duration = freezed,
    Object? watchPosition = freezed,
  }) {
    return _then(_$WatchHistoryItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      mediaId: null == mediaId
          ? _value.mediaId
          : mediaId // ignore: cast_nullable_to_non_nullable
              as int,
      mediaType: null == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredSource: freezed == preferredSource
          ? _value.preferredSource
          : preferredSource // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      seasonNumber: freezed == seasonNumber
          ? _value.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      episodeNumber: freezed == episodeNumber
          ? _value.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      watchPosition: freezed == watchPosition
          ? _value.watchPosition
          : watchPosition // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WatchHistoryItemImpl implements _WatchHistoryItem {
  const _$WatchHistoryItemImpl(
      {required this.id,
      required this.userId,
      required this.mediaId,
      required this.mediaType,
      required this.title,
      this.overview,
      this.backdropPath,
      this.posterPath,
      this.preferredSource,
      this.rating,
      this.seasonNumber,
      this.episodeNumber,
      required this.createdAt,
      this.duration,
      this.watchPosition});

  factory _$WatchHistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WatchHistoryItemImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final int mediaId;
  @override
  final String mediaType;
// 'movie' or 'tv'
  @override
  final String title;
  @override
  final String? overview;
  @override
  final String? backdropPath;
  @override
  final String? posterPath;
  @override
  final String? preferredSource;
  @override
  final double? rating;
  @override
  final int? seasonNumber;
  @override
  final int? episodeNumber;
  @override
  final DateTime createdAt;
  @override
  final int? duration;
  @override
  final int? watchPosition;

  @override
  String toString() {
    return 'WatchHistoryItem(id: $id, userId: $userId, mediaId: $mediaId, mediaType: $mediaType, title: $title, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath, preferredSource: $preferredSource, rating: $rating, seasonNumber: $seasonNumber, episodeNumber: $episodeNumber, createdAt: $createdAt, duration: $duration, watchPosition: $watchPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchHistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.mediaId, mediaId) || other.mediaId == mediaId) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.preferredSource, preferredSource) ||
                other.preferredSource == preferredSource) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            (identical(other.episodeNumber, episodeNumber) ||
                other.episodeNumber == episodeNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.watchPosition, watchPosition) ||
                other.watchPosition == watchPosition));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      mediaId,
      mediaType,
      title,
      overview,
      backdropPath,
      posterPath,
      preferredSource,
      rating,
      seasonNumber,
      episodeNumber,
      createdAt,
      duration,
      watchPosition);

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchHistoryItemImplCopyWith<_$WatchHistoryItemImpl> get copyWith =>
      __$$WatchHistoryItemImplCopyWithImpl<_$WatchHistoryItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WatchHistoryItemImplToJson(
      this,
    );
  }
}

abstract class _WatchHistoryItem implements WatchHistoryItem {
  const factory _WatchHistoryItem(
      {required final String id,
      required final String userId,
      required final int mediaId,
      required final String mediaType,
      required final String title,
      final String? overview,
      final String? backdropPath,
      final String? posterPath,
      final String? preferredSource,
      final double? rating,
      final int? seasonNumber,
      final int? episodeNumber,
      required final DateTime createdAt,
      final int? duration,
      final int? watchPosition}) = _$WatchHistoryItemImpl;

  factory _WatchHistoryItem.fromJson(Map<String, dynamic> json) =
      _$WatchHistoryItemImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  int get mediaId;
  @override
  String get mediaType; // 'movie' or 'tv'
  @override
  String get title;
  @override
  String? get overview;
  @override
  String? get backdropPath;
  @override
  String? get posterPath;
  @override
  String? get preferredSource;
  @override
  double? get rating;
  @override
  int? get seasonNumber;
  @override
  int? get episodeNumber;
  @override
  DateTime get createdAt;
  @override
  int? get duration;
  @override
  int? get watchPosition;

  /// Create a copy of WatchHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchHistoryItemImplCopyWith<_$WatchHistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
