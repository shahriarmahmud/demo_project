import 'package:demo_project/features/movies/domain/entities/movie.dart';
import 'package:demo_project/features/movies/domain/repositories/movie_repository.dart';
import 'package:flutter/foundation.dart';

class MoviesViewModel extends ChangeNotifier {
  MoviesViewModel(this._repository);

  final MovieRepository _repository;

  final List<Movie> _movies = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  int _currentPage = 0;
  int _lastPage = 1;

  List<Movie> get movies => List.unmodifiable(_movies);
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _currentPage < _lastPage;

  Future<void> loadMovies() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final page = await _repository.getMovies(page: 1);
      _movies
        ..clear()
        ..addAll(page.movies);
      _currentPage = page.currentPage;
      _lastPage = page.lastPage;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final page = await _repository.getMovies(page: _currentPage + 1);
      _movies.addAll(page.movies);
      _currentPage = page.currentPage;
      _lastPage = page.lastPage;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
