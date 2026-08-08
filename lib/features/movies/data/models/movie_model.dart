import 'package:demo_project/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.language,
    required super.releaseDate,
    required super.voteAverage,
    required super.voteCount,
    required super.popularity,
    super.posterUrl,
    super.backdropUrl,
    super.casts,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final casts = (json['casts'] as List<dynamic>? ?? [])
        .map((cast) => MovieCastModel.fromJson(cast as Map<String, dynamic>))
        .toList();

    return MovieModel(
      id: json['id'] as String,
      title: json['original_title'] as String,
      overview: json['overview'] as String? ?? '',
      language: json['original_language'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0,
      posterUrl: json['poster_path'] as String?,
      backdropUrl: json['backdrop_path'] as String?,
      casts: casts,
    );
  }
}

class MovieCastModel extends MovieCast {
  const MovieCastModel({
    required super.name,
    required super.character,
    super.profileUrl,
  });

  factory MovieCastModel.fromJson(Map<String, dynamic> json) {
    return MovieCastModel(
      name: json['name'] as String? ?? '',
      character: json['character'] as String? ?? '',
      profileUrl: json['profile_path'] as String?,
    );
  }
}

class MoviePageModel extends MoviePage {
  const MoviePageModel({
    required super.movies,
    required super.currentPage,
    required super.lastPage,
  });

  factory MoviePageModel.fromJson(Map<String, dynamic> json) {
    final movies = (json['data'] as List<dynamic>)
        .map((item) => MovieModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return MoviePageModel(
      movies: movies,
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
    );
  }
}
