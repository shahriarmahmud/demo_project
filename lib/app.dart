import 'package:demo_project/core/di/injection_container.dart';
import 'package:demo_project/core/theme/app_theme.dart';
import 'package:demo_project/core/utils/constants.dart';
import 'package:demo_project/features/auth/presentation/login_page.dart';
import 'package:demo_project/features/auth/presentation/login_viewmodel.dart';
import 'package:demo_project/features/movies/presentation/movies_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: sl<MoviesViewModel>()),
        ChangeNotifierProvider.value(value: sl<LoginViewModel>()),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: AppTheme.lightTheme,
        home: const LoginPage(),
      ),
    );
  }
}
