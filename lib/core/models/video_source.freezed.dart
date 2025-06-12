// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoSource _$VideoSourceFromJson(Map<String, dynamic> json) {
  return _VideoSource.fromJson(json);
}

/// @nodoc
mixin _$VideoSource {
  String get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get movieUrlPattern => throw _privateConstructorUsedError;
  String get tvUrlPattern => throw _privateConstructorUsedError;

  /// Serializes this VideoSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoSourceCopyWith<VideoSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoSourceCopyWith<$Res> {
  factory $VideoSourceCopyWith(
          VideoSource value, $Res Function(VideoSource) then) =
      _$VideoSourceCopyWithImpl<$Res, VideoSource>;
  @useResult
  $Res call(
      {String key, String name, String movieUrlPattern, String tvUrlPattern});
}

/// @nodoc
class _$VideoSourceCopyWithImpl<$Res, $Val extends VideoSource>
    implements $VideoSourceCopyWith<$Res> {
  _$VideoSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? movieUrlPattern = null,
    Object? tvUrlPattern = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      movieUrlPattern: null == movieUrlPattern
          ? _value.movieUrlPattern
          : movieUrlPattern // ignore: cast_nullable_to_non_nullable
              as String,
      tvUrlPattern: null == tvUrlPattern
          ? _value.tvUrlPattern
          : tvUrlPattern // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoSourceImplCopyWith<$Res>
    implements $VideoSourceCopyWith<$Res> {
  factory _$$VideoSourceImplCopyWith(
          _$VideoSourceImpl value, $Res Function(_$VideoSourceImpl) then) =
      __$$VideoSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String key, String name, String movieUrlPattern, String tvUrlPattern});
}

/// @nodoc
class __$$VideoSourceImplCopyWithImpl<$Res>
    extends _$VideoSourceCopyWithImpl<$Res, _$VideoSourceImpl>
    implements _$$VideoSourceImplCopyWith<$Res> {
  __$$VideoSourceImplCopyWithImpl(
      _$VideoSourceImpl _value, $Res Function(_$VideoSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? name = null,
    Object? movieUrlPattern = null,
    Object? tvUrlPattern = null,
  }) {
    return _then(_$VideoSourceImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      movieUrlPattern: null == movieUrlPattern
          ? _value.movieUrlPattern
          : movieUrlPattern // ignore: cast_nullable_to_non_nullable
              as String,
      tvUrlPattern: null == tvUrlPattern
          ? _value.tvUrlPattern
          : tvUrlPattern // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoSourceImpl implements _VideoSource {
  const _$VideoSourceImpl(
      {required this.key,
      required this.name,
      required this.movieUrlPattern,
      required this.tvUrlPattern});

  factory _$VideoSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoSourceImplFromJson(json);

  @override
  final String key;
  @override
  final String name;
  @override
  final String movieUrlPattern;
  @override
  final String tvUrlPattern;

  @override
  String toString() {
    return 'VideoSource(key: $key, name: $name, movieUrlPattern: $movieUrlPattern, tvUrlPattern: $tvUrlPattern)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoSourceImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.movieUrlPattern, movieUrlPattern) ||
                other.movieUrlPattern == movieUrlPattern) &&
            (identical(other.tvUrlPattern, tvUrlPattern) ||
                other.tvUrlPattern == tvUrlPattern));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, key, name, movieUrlPattern, tvUrlPattern);

  /// Create a copy of VideoSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoSourceImplCopyWith<_$VideoSourceImpl> get copyWith =>
      __$$VideoSourceImplCopyWithImpl<_$VideoSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoSourceImplToJson(
      this,
    );
  }
}

abstract class _VideoSource implements VideoSource {
  const factory _VideoSource(
      {required final String key,
      required final String name,
      required final String movieUrlPattern,
      required final String tvUrlPattern}) = _$VideoSourceImpl;

  factory _VideoSource.fromJson(Map<String, dynamic> json) =
      _$VideoSourceImpl.fromJson;

  @override
  String get key;
  @override
  String get name;
  @override
  String get movieUrlPattern;
  @override
  String get tvUrlPattern;

  /// Create a copy of VideoSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoSourceImplCopyWith<_$VideoSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
