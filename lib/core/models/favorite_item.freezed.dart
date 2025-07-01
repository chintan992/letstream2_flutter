// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteItem _$FavoriteItemFromJson(Map<String, dynamic> json) {
  return _FavoriteItem.fromJson(json);
}

/// @nodoc
mixin _$FavoriteItem {
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

  /// Serializes this FavoriteItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteItemCopyWith<FavoriteItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteItemCopyWith<$Res> {
  factory $FavoriteItemCopyWith(
          FavoriteItem value, $Res Function(FavoriteItem) then) =
      _$FavoriteItemCopyWithImpl<$Res, FavoriteItem>;
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
class _$FavoriteItemCopyWithImpl<$Res, $Val extends FavoriteItem>
    implements $FavoriteItemCopyWith<$Res> {
  _$FavoriteItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteItem
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
abstract class _$$FavoriteItemImplCopyWith<$Res>
    implements $FavoriteItemCopyWith<$Res> {
  factory _$$FavoriteItemImplCopyWith(
          _$FavoriteItemImpl value, $Res Function(_$FavoriteItemImpl) then) =
      __$$FavoriteItemImplCopyWithImpl<$Res>;
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
class __$$FavoriteItemImplCopyWithImpl<$Res>
    extends _$FavoriteItemCopyWithImpl<$Res, _$FavoriteItemImpl>
    implements _$$FavoriteItemImplCopyWith<$Res> {
  __$$FavoriteItemImplCopyWithImpl(
      _$FavoriteItemImpl _value, $Res Function(_$FavoriteItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteItem
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
    return _then(_$FavoriteItemImpl(
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
class _$FavoriteItemImpl implements _FavoriteItem {
  const _$FavoriteItemImpl(
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

  factory _$FavoriteItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteItemImplFromJson(json);

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
    return 'FavoriteItem(id: $id, userId: $userId, mediaId: $mediaId, mediaType: $mediaType, title: $title, overview: $overview, backdropPath: $backdropPath, posterPath: $posterPath, rating: $rating, addedAt: $addedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteItemImpl &&
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

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      __$$FavoriteItemImplCopyWithImpl<_$FavoriteItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteItemImplToJson(
      this,
    );
  }
}

abstract class _FavoriteItem implements FavoriteItem {
  const factory _FavoriteItem(
      {required final String id,
      required final String userId,
      required final int mediaId,
      required final String mediaType,
      required final String title,
      final String? overview,
      final String? backdropPath,
      final String? posterPath,
      final double? rating,
      required final DateTime addedAt}) = _$FavoriteItemImpl;

  factory _FavoriteItem.fromJson(Map<String, dynamic> json) =
      _$FavoriteItemImpl.fromJson;

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

  /// Create a copy of FavoriteItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
