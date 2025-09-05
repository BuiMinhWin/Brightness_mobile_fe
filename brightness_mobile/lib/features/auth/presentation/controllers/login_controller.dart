import 'package:flutter/foundation.dart';

import '../../domain/entities/auth_token.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase _login;
  LoginController({required LoginUseCase login}) : _login = login;

  bool _loading = false;
  String? _error;
  AuthToken? _token;

  bool get loading => _loading;
  String? get error => _error;
  AuthToken? get token => _token;

  Future<void> submit(String username, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _token = await _login(LoginParams(username: username, password: password));
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

