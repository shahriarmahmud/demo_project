import 'dart:convert';
import 'package:demo_project/core/utils/constants.dart';
import 'package:demo_project/features/auth/data/models/user_model.dart';
import 'package:demo_project/features/auth/domain/entities/user.dart';
import 'package:demo_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  final http.Client _client;

  AuthRepositoryImpl({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<User> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse(AppConstants.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to login');
    }
  }
}
