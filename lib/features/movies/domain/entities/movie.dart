class Movie {
  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.language,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.posterUrl,
    this.backdropUrl,
    this.casts = const [],
  });

  final String id;
  final String title;
  final String overview;
  final String language;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final String? posterUrl;
  final String? backdropUrl;
  final List<MovieCast> casts;
}

class MovieCast {
  const MovieCast({
    required this.name,
    required this.character,
    this.profileUrl,
  });

  final String name;
  final String character;
  final String? profileUrl;
}

class MoviePage {
  const MoviePage({
    required this.movies,
    required this.currentPage,
    required this.lastPage,
  });

  final List<Movie> movies;
  final int currentPage;
  final int lastPage;

  bool get hasMore => currentPage < lastPage;
}
