import 'package:dio/dio.dart';

import '../../../../core/constants/endpoints.dart';
import '../../../../core/network/dio_client.dart';

abstract class HomeRemoteDataSource {
  Future<Response<dynamic>> getDailyCalories({required DateTime date});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl(this.dioClient);

  @override
  Future<Response> getDailyCalories({required DateTime date}) async {
    final dio = dioClient.forUserService();
    return dio.get(
      Endpoints.dailyCalories,
      queryParameters: {
        'date': date.toIso8601String(),
      },
    );
  }
}

