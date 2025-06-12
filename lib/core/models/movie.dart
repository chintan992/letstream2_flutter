import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    required int id,
    required String title,
    String? overview,
    required List<int> genreIds,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    required double voteAverage,
    required int voteCount,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: (json['id'] as num).toInt(),
        title: json['title'] as String? ?? 'Untitled Movie',
        overview: json['overview'] as String?,
        genreIds: (json['genre_ids'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ?? [],
        posterPath: json['poster_path'] as String?,
        backdropPath: json['backdrop_path'] as String?,
        releaseDate: json['release_date'] as String?,
        voteAverage: ((json['vote_average'] as num?)?.toDouble() ?? 0.0),
        voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      );

  static List<Movie> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
  }
}
