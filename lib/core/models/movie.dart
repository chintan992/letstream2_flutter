import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required String title,
    String? overview,
    @Default([]) List<int> genreIds,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    @Default(0.0) double voteAverage,
    @Default(0) int voteCount,
  }) = _Movie;

  const Movie._();
  
  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: (json['id'] as num).toInt(),
    title: json['title'] as String? ?? 'Untitled',
    overview: json['overview'] as String?,
    genreIds: (json['genre_ids'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ?? [],
    posterPath: json['poster_path'] as String?,
    backdropPath: json['backdrop_path'] as String?,
    releaseDate: json['release_date'] as String?,
    voteAverage: ((json['vote_average'] as num?)?.toDouble() ?? 0.0),
    voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
  );

  int? get releaseYear {
    if (releaseDate == null) return null;
    return DateTime.tryParse(releaseDate!)?.year;
  }

  static List<Movie> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
  }
}
