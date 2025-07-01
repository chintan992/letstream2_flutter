// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WatchlistItem _$WatchlistItemFromJson(Map<String, dynamic> json) {
  return _WatchlistItem.fromJson(json);
}

/// @nodoc
mixin _$WatchlistItem {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get mediaId => throw _privateConstructorUsedError;
  String get mediaType => throw _privateConstructorUsedError; // 'movie' or 'tv'
  String get title => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get backdropPath => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  DateTime get addedAt => throw _privateConstructorUsedError;

  /// Serializes this WatchlistItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WatchlistItemCopyWith<WatchlistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchlistItemCopyWith<$Res> {
  factory $WatchlistItemCopyWith(
          WatchlistItem value, $Res Function(WatchlistItem) then) =
      _$WatchlistItemCopyWithImpl<$Res, WatchlistItem>;
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
      double? rating,
      DateTime addedAt});
}

/// @nodoc
class _$WatchlistItemCopyWithImpl<$Res, $Val extends WatchlistItem>
    implements $WatchlistItemCopyWith<$Res> {
  _$WatchlistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WatchlistItem
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
    Object? rating = freezed,
    Object? addedAt = null,
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
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WatchlistItemImplCopyWith<$Res>
    implements $WatchlistItemCopyWith<$Res> {
  factory _$$WatchlistItemImplCopyWith(
          _$WatchlistItemImpl value, $Res Function(_$WatchlistItemImpl) then) =
      __$$WatchlistItemImplCopyWithImpl<$Res>;
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
      double? rating,
      DateTime addedAt});
}

/// @nodoc
class __$$WatchlistItemImplCopyWithImpl<$Res>
    extends _$WatchlistItemCopyWithImpl<$Res, _$WatchlistItemImpl>
    implements _$$WatchlistItemImplCopyWith<$Res> {
  __$$WatchlistItemImplCopyWithImpl(
      _$WatchlistItemImpl _value, $Res Function(_$WatchlistItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of WatchlistItem
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
    Object? rating = freezed,
    Object? addedAt = null,
  }) {
    return _then(_$WatchlistItemImpl(
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
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      addedAt: null == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WatchlistItemImpl implements _WatchlistItem {
  const _$WatchlistItemImpl(
      {required this.id,
      required this.userId,
      required this.mediaId,
      required this.mediaType,
      required this.title,
      this.overview,
      this.backdropPath,
      this.posterPath,
      this.rating,
      required this.addedAt});

  factory _$WatchlistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WatchlistItemImplFromJson(json);

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
  final double? rating;
  @override
  final DateTime addedAt;

  @override
  String toString() {
    return 'WatchlistItem(id: $id, userId: $userId, mediaId: $mediaId, mediaType: $mediaType, title: $title, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath, rating: $rating, addedAt: $addedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchlistItemImpl &&
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
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, mediaId, mediaType,
      title, overview, backdropPath, posterPath, rating, addedAt);

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchlistItemImplCopyWith<_$WatchlistItemImpl> get copyWith =>
      __$$WatchlistItemImplCopyWithImpl<_$WatchlistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WatchlistItemImplToJson(
      this,
    );
  }
}

abstract class _WatchlistItem implements WatchlistItem {
  const factory _WatchlistItem(
      {required final String id,
      required final String userId,
      required final int mediaId,
      required final String mediaType,
      required final String title,
      final String? overview,
      final String? backdropPath,
      final String? posterPath,
      final double? rating,
      required final DateTime addedAt}) = _$WatchlistItemImpl;

  factory _WatchlistItem.fromJson(Map<String, dynamic> json) =
      _$WatchlistItemImpl.fromJson;

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
  double? get rating;
  @override
  DateTime get addedAt;

  /// Create a copy of WatchlistItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WatchlistItemImplCopyWith<_$WatchlistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
