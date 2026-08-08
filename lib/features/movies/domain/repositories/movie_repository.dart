import 'package:demo_project/features/movies/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<MoviePage> getMovies({required int page, int limit = 20});
}
