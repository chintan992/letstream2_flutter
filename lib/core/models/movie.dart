import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Movie({
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

  const Movie._();
  
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  int? get releaseYear {
    if (releaseDate == null) return null;
    return DateTime.tryParse(releaseDate!)?.year;
  }

  static List<Movie> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Movie.fromJson(json as Map<String, dynamic>)).toList();
  }
}
