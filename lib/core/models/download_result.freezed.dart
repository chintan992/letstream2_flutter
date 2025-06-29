// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DownloadResult _$DownloadResultFromJson(Map<String, dynamic> json) {
  return _DownloadResult.fromJson(json);
}

/// @nodoc
mixin _$DownloadResult {
  String get title => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  String get downloadUrl => throw _privateConstructorUsedError;
  String get fileId => throw _privateConstructorUsedError;

  /// Serializes this DownloadResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DownloadResultCopyWith<DownloadResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadResultCopyWith<$Res> {
  factory $DownloadResultCopyWith(
          DownloadResult value, $Res Function(DownloadResult) then) =
      _$DownloadResultCopyWithImpl<$Res, DownloadResult>;
  @useResult
  $Res call({String title, String size, String downloadUrl, String fileId});
}

/// @nodoc
class _$DownloadResultCopyWithImpl<$Res, $Val extends DownloadResult>
    implements $DownloadResultCopyWith<$Res> {
  _$DownloadResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? size = null,
    Object? downloadUrl = null,
    Object? fileId = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      downloadUrl: null == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DownloadResultImplCopyWith<$Res>
    implements $DownloadResultCopyWith<$Res> {
  factory _$$DownloadResultImplCopyWith(_$DownloadResultImpl value,
          $Res Function(_$DownloadResultImpl) then) =
      __$$DownloadResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String size, String downloadUrl, String fileId});
}

/// @nodoc
class __$$DownloadResultImplCopyWithImpl<$Res>
    extends _$DownloadResultCopyWithImpl<$Res, _$DownloadResultImpl>
    implements _$$DownloadResultImplCopyWith<$Res> {
  __$$DownloadResultImplCopyWithImpl(
      _$DownloadResultImpl _value, $Res Function(_$DownloadResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of DownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? size = null,
    Object? downloadUrl = null,
    Object? fileId = null,
  }) {
    return _then(_$DownloadResultImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      downloadUrl: null == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      fileId: null == fileId
          ? _value.fileId
          : fileId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DownloadResultImpl extends _DownloadResult {
  const _$DownloadResultImpl(
      {required this.title,
      required this.size,
      required this.downloadUrl,
      required this.fileId})
      : super._();

  factory _$DownloadResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DownloadResultImplFromJson(json);

  @override
  final String title;
  @override
  final String size;
  @override
  final String downloadUrl;
  @override
  final String fileId;

  @override
  String toString() {
    return 'DownloadResult(title: $title, size: $size, downloadUrl: $downloadUrl, fileId: $fileId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadResultImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.fileId, fileId) || other.fileId == fileId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, size, downloadUrl, fileId);

  /// Create a copy of DownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadResultImplCopyWith<_$DownloadResultImpl> get copyWith =>
      __$$DownloadResultImplCopyWithImpl<_$DownloadResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DownloadResultImplToJson(
      this,
    );
  }
}

abstract class _DownloadResult extends DownloadResult {
  const factory _DownloadResult(
      {required final String title,
      required final String size,
      required final String downloadUrl,
      required final String fileId}) = _$DownloadResultImpl;
  const _DownloadResult._() : super._();

  factory _DownloadResult.fromJson(Map<String, dynamic> json) =
      _$DownloadResultImpl.fromJson;

  @override
  String get title;
  @override
  String get size;
  @override
  String get downloadUrl;
  @override
  String get fileId;

  /// Create a copy of DownloadResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadResultImplCopyWith<_$DownloadResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DownloadResponse _$DownloadResponseFromJson(Map<String, dynamic> json) {
  return _DownloadResponse.fromJson(json);
}

/// @nodoc
mixin _$DownloadResponse {
  String get status => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;
  List<DownloadResult> get results => throw _privateConstructorUsedError;

  /// Serializes this DownloadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DownloadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DownloadResponseCopyWith<DownloadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadResponseCopyWith<$Res> {
  factory $DownloadResponseCopyWith(
          DownloadResponse value, $Res Function(DownloadResponse) then) =
      _$DownloadResponseCopyWithImpl<$Res, DownloadResponse>;
  @useResult
  $Res call(
      {String status,
      String query,
      int totalResults,
      List<DownloadResult> results});
}

/// @nodoc
class _$DownloadResponseCopyWithImpl<$Res, $Val extends DownloadResponse>
    implements $DownloadResponseCopyWith<$Res> {
  _$DownloadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DownloadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? query = null,
    Object? totalResults = null,
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<DownloadResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DownloadResponseImplCopyWith<$Res>
    implements $DownloadResponseCopyWith<$Res> {
  factory _$$DownloadResponseImplCopyWith(_$DownloadResponseImpl value,
          $Res Function(_$DownloadResponseImpl) then) =
      __$$DownloadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String query,
      int totalResults,
      List<DownloadResult> results});
}

/// @nodoc
class __$$DownloadResponseImplCopyWithImpl<$Res>
    extends _$DownloadResponseCopyWithImpl<$Res, _$DownloadResponseImpl>
    implements _$$DownloadResponseImplCopyWith<$Res> {
  __$$DownloadResponseImplCopyWithImpl(_$DownloadResponseImpl _value,
      $Res Function(_$DownloadResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of DownloadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? query = null,
    Object? totalResults = null,
    Object? results = null,
  }) {
    return _then(_$DownloadResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<DownloadResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DownloadResponseImpl extends _DownloadResponse {
  const _$DownloadResponseImpl(
      {required this.status,
      required this.query,
      required this.totalResults,
      required final List<DownloadResult> results})
      : _results = results,
        super._();

  factory _$DownloadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DownloadResponseImplFromJson(json);

  @override
  final String status;
  @override
  final String query;
  @override
  final int totalResults;
  final List<DownloadResult> _results;
  @override
  List<DownloadResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'DownloadResponse(status: $status, query: $query, totalResults: $totalResults, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, query, totalResults,
      const DeepCollectionEquality().hash(_results));

  /// Create a copy of DownloadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadResponseImplCopyWith<_$DownloadResponseImpl> get copyWith =>
      __$$DownloadResponseImplCopyWithImpl<_$DownloadResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DownloadResponseImplToJson(
      this,
    );
  }
}

abstract class _DownloadResponse extends DownloadResponse {
  const factory _DownloadResponse(
      {required final String status,
      required final String query,
      required final int totalResults,
      required final List<DownloadResult> results}) = _$DownloadResponseImpl;
  const _DownloadResponse._() : super._();

  factory _DownloadResponse.fromJson(Map<String, dynamic> json) =
      _$DownloadResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get query;
  @override
  int get totalResults;
  @override
  List<DownloadResult> get results;

  /// Create a copy of DownloadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadResponseImplCopyWith<_$DownloadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
