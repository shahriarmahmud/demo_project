import 'dart:convert';

import 'package:demo_project/core/utils/constants.dart';
import 'package:demo_project/features/movies/data/models/movie_model.dart';
import 'package:demo_project/features/movies/domain/entities/movie.dart';
import 'package:demo_project/features/movies/domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<MoviePage> getMovies({required int page, int limit = 20}) async {
    final uri = Uri.parse('${AppConstants.moviesUrl}?page=$page&limit=$limit');
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load movies (${response.statusCode})');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return MoviePageModel.fromJson(json);
  }
}
