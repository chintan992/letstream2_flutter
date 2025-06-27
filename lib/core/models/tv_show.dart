import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv_show.freezed.dart';
part 'tv_show.g.dart';

@freezed
class TvShow with _$TvShow {
  factory TvShow({
    required int id,
    required String title,
    String? overview,
    @Default([]) List<int> genreIds,
    String? posterPath,
    String? backdropPath,
    String? firstAirDate,
    @Default(0.0) double voteAverage,
    @Default(0) int voteCount,
    int? numberOfSeasons,
  }) = _TvShow;

  factory TvShow.fromJson(Map<String, dynamic> json) => TvShow(
        id: (json['id'] as num).toInt(),
        title: json['name'] as String? ?? 'Untitled Show',
        overview: json['overview'] as String?,
        genreIds: (json['genre_ids'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ?? [],
        posterPath: json['poster_path'] as String?,
        backdropPath: json['backdrop_path'] as String?,
        firstAirDate: json['first_air_date'] as String?,
        voteAverage: ((json['vote_average'] as num?)?.toDouble() ?? 0.0),
        voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
        numberOfSeasons: json['number_of_seasons'] == null ? null : (json['number_of_seasons'] as num).toInt(),
      );

  static List<TvShow> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TvShow.fromJson(json as Map<String, dynamic>)).toList();
  }
}
