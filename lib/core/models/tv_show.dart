import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv_show.freezed.dart';
part 'tv_show.g.dart';

@freezed
class TvShow with _$TvShow {
  factory TvShow({
    required int id,
    required String title,
    required String overview,
    required List<int> genreIds,
    String? posterPath,
    String? backdropPath,
    required String firstAirDate,
    required double voteAverage,
    required int voteCount,
    int? numberOfSeasons,
  }) = _TvShow;

  factory TvShow.fromJson(Map<String, dynamic> json) => _$TvShowFromJson(json);
}
