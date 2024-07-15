import 'package:news_app/data/data_providers/auth_api.dart';
import 'package:news_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({required this.authApi});

  @override
  Future<bool> authenticate(String username, String password) async {
    return await authApi.authenticate(username, password);
  }
}
