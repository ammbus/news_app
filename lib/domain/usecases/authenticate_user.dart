import 'package:news_app/domain/repositories/auth_repository.dart';

class AuthenticateUser {
  final AuthRepository repository;

  AuthenticateUser({required this.repository});

  Future<bool> call(String username, String password) async {
    return await repository.authenticate(username, password);
  }
}

