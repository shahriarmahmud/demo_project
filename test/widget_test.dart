import 'package:demo_project/features/movies/domain/entities/movie.dart';
import 'package:demo_project/features/movies/domain/repositories/movie_repository.dart';
import 'package:demo_project/features/movies/presentation/movies_page.dart';
import 'package:demo_project/features/movies/presentation/movies_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Movies list shows titles', (WidgetTester tester) async {
    final viewModel = MoviesViewModel(_FakeMovieRepository());

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: viewModel,
        child: const MaterialApp(home: MoviesPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Test Movie One'), findsOneWidget);
    expect(find.text('Test Movie Two'), findsOneWidget);
  });
}

class _FakeMovieRepository implements MovieRepository {
  @override
  Future<MoviePage> getMovies({required int page, int limit = 20}) async {
    return MoviePage(
      currentPage: 1,
      lastPage: 1,
      movies: const [
        Movie(
          id: '1',
          title: 'Test Movie One',
          overview: 'Overview one',
          language: 'en',
          releaseDate: '2024-01-01',
          voteAverage: 8.5,
          voteCount: 100,
          popularity: 10,
          posterUrl: null,
        ),
        Movie(
          id: '2',
          title: 'Test Movie Two',
          overview: 'Overview two',
          language: 'en',
          releaseDate: '2024-02-01',
          voteAverage: 7.2,
          voteCount: 50,
          popularity: 5,
          posterUrl: null,
        ),
      ],
    );
  }
}
