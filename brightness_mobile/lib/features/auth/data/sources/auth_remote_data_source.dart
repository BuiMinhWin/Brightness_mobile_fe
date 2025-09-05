import 'package:dio/dio.dart';

import '../models/auth_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> login({required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _client;
  final Uri baseUrl;
  AuthRemoteDataSourceImpl({required Dio client, required this.baseUrl}) : _client = client;

  @override
  Future<AuthTokenModel> login({required String username, required String password}) async {
    final url = baseUrl.resolve('/login');
    final resp = await _client.postUri(url, data: {
      'username': username,
      'password': password,
    });
    return AuthTokenModel.fromJson(resp.data as Map<String, dynamic>);
  }
}

