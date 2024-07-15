import 'package:dio/dio.dart';

import 'package:news_app/core/utils/constants.dart';

class AuthApi {
  final Dio dio = Dio();

  Future<bool> authenticate(String username, String password) async {
    try {
      final response = await dio.post('${Constants.baseUrl}/auth/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200 && response.data['token'] != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
