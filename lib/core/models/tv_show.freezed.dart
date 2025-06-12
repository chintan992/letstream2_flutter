// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tv_show.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TvShow _$TvShowFromJson(Map<String, dynamic> json) {
  return _TvShow.fromJson(json);
}

/// @nodoc
mixin _$TvShow {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get overview => throw _privateConstructorUsedError;
  List<int> get genreIds => throw _privateConstructorUsedError;
  String? get posterPath => throw _privateConstructorUsedError;
  String? get backdropPath => throw _privateConstructorUsedError;
  String get firstAirDate => throw _privateConstructorUsedError;
  double get voteAverage => throw _privateConstructorUsedError;
  int get voteCount => throw _privateConstructorUsedError;
  int? get numberOfSeasons => throw _privateConstructorUsedError;

  /// Serializes this TvShow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TvShow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TvShowCopyWith<TvShow> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TvShowCopyWith<$Res> {
  factory $TvShowCopyWith(TvShow value, $Res Function(TvShow) then) =
      _$TvShowCopyWithImpl<$Res, TvShow>;
  @useResult
  $Res call(
      {int id,
      String title,
      String overview,
      List<int> genreIds,
      String? posterPath,
      String? backdropPath,
      String firstAirDate,
      double voteAverage,
      int voteCount,
      int? numberOfSeasons});
}

/// @nodoc
class _$TvShowCopyWithImpl<$Res, $Val extends TvShow>
    implements $TvShowCopyWith<$Res> {
  _$TvShowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TvShow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? genreIds = null,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? firstAirDate = null,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? numberOfSeasons = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      genreIds: null == genreIds
          ? _value.genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: null == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfSeasons: freezed == numberOfSeasons
          ? _value.numberOfSeasons
          : numberOfSeasons // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TvShowImplCopyWith<$Res> implements $TvShowCopyWith<$Res> {
  factory _$$TvShowImplCopyWith(
          _$TvShowImpl value, $Res Function(_$TvShowImpl) then) =
      __$$TvShowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String overview,
      List<int> genreIds,
      String? posterPath,
      String? backdropPath,
      String firstAirDate,
      double voteAverage,
      int voteCount,
      int? numberOfSeasons});
}

/// @nodoc
class __$$TvShowImplCopyWithImpl<$Res>
    extends _$TvShowCopyWithImpl<$Res, _$TvShowImpl>
    implements _$$TvShowImplCopyWith<$Res> {
  __$$TvShowImplCopyWithImpl(
      _$TvShowImpl _value, $Res Function(_$TvShowImpl) _then)
      : super(_value, _then);

  /// Create a copy of TvShow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? overview = null,
    Object? genreIds = null,
    Object? posterPath = freezed,
    Object? backdropPath = freezed,
    Object? firstAirDate = null,
    Object? voteAverage = null,
    Object? voteCount = null,
    Object? numberOfSeasons = freezed,
  }) {
    return _then(_$TvShowImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      overview: null == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String,
      genreIds: null == genreIds
          ? _value._genreIds
          : genreIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      posterPath: freezed == posterPath
          ? _value.posterPath
          : posterPath // ignore: cast_nullable_to_non_nullable
              as String?,
      backdropPath: freezed == backdropPath
          ? _value.backdropPath
          : backdropPath // ignore: cast_nullable_to_non_nullable
              as String?,
      firstAirDate: null == firstAirDate
          ? _value.firstAirDate
          : firstAirDate // ignore: cast_nullable_to_non_nullable
              as String,
      voteAverage: null == voteAverage
          ? _value.voteAverage
          : voteAverage // ignore: cast_nullable_to_non_nullable
              as double,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfSeasons: freezed == numberOfSeasons
          ? _value.numberOfSeasons
          : numberOfSeasons // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TvShowImpl implements _TvShow {
  _$TvShowImpl(
      {required this.id,
      required this.title,
      required this.overview,
      required final List<int> genreIds,
      this.posterPath,
      this.backdropPath,
      required this.firstAirDate,
      required this.voteAverage,
      required this.voteCount,
      this.numberOfSeasons})
      : _genreIds = genreIds;

  factory _$TvShowImpl.fromJson(Map<String, dynamic> json) =>
      _$$TvShowImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String overview;
  final List<int> _genreIds;
  @override
  List<int> get genreIds {
    if (_genreIds is EqualUnmodifiableListView) return _genreIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genreIds);
  }

  @override
  final String? posterPath;
  @override
  final String? backdropPath;
  @override
  final String firstAirDate;
  @override
  final double voteAverage;
  @override
  final int voteCount;
  @override
  final int? numberOfSeasons;

  @override
  String toString() {
    return 'TvShow(id: $id, title: $title, overview: $overview, genreIds: $genreIds, posterPath: $posterPath, backdropPath: $backdropPath, firstAirDate: $firstAirDate, voteAverage: $voteAverage, voteCount: $voteCount, numberOfSeasons: $numberOfSeasons)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TvShowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            const DeepCollectionEquality().equals(other._genreIds, _genreIds) &&
            (identical(other.posterPath, posterPath) ||
                other.posterPath == posterPath) &&
            (identical(other.backdropPath, backdropPath) ||
                other.backdropPath == backdropPath) &&
            (identical(other.firstAirDate, firstAirDate) ||
                other.firstAirDate == firstAirDate) &&
            (identical(other.voteAverage, voteAverage) ||
                other.voteAverage == voteAverage) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.numberOfSeasons, numberOfSeasons) ||
                other.numberOfSeasons == numberOfSeasons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      overview,
      const DeepCollectionEquality().hash(_genreIds),
      posterPath,
      backdropPath,
      firstAirDate,
      voteAverage,
      voteCount,
      numberOfSeasons);

  /// Create a copy of TvShow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TvShowImplCopyWith<_$TvShowImpl> get copyWith =>
      __$$TvShowImplCopyWithImpl<_$TvShowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TvShowImplToJson(
      this,
    );
  }
}

abstract class _TvShow implements TvShow {
  factory _TvShow(
      {required final int id,
      required final String title,
      required final String overview,
      required final List<int> genreIds,
      final String? posterPath,
      final String? backdropPath,
      required final String firstAirDate,
      required final double voteAverage,
      required final int voteCount,
      final int? numberOfSeasons}) = _$TvShowImpl;

  factory _TvShow.fromJson(Map<String, dynamic> json) = _$TvShowImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get overview;
  @override
  List<int> get genreIds;
  @override
  String? get posterPath;
  @override
  String? get backdropPath;
  @override
  String get firstAirDate;
  @override
  double get voteAverage;
  @override
  int get voteCount;
  @override
  int? get numberOfSeasons;

  /// Create a copy of TvShow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TvShowImplCopyWith<_$TvShowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
