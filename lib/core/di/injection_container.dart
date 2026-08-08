import 'package:demo_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:demo_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:demo_project/features/auth/presentation/login_viewmodel.dart';
import 'package:demo_project/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:demo_project/features/movies/domain/repositories/movie_repository.dart';
import 'package:demo_project/features/movies/presentation/movies_viewmodel.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<MovieRepository>(MovieRepositoryImpl.new);
  sl.registerLazySingleton<AuthRepository>(AuthRepositoryImpl.new);

  sl.registerFactory(() => MoviesViewModel(sl()));
  sl.registerFactory(() => LoginViewModel(sl()));
}
