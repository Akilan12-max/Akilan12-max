import 'dart:async';

import 'package:blog/models/user_model.dart';
import 'package:blog/services/networking/api_response.dart';
import 'package:blog/services/repository/login_repository.dart';

class LoginBloc {
  LoginRepository _loginRepository;

  StreamController _loginController;

  StreamSink<ApiResponse<User>> get loginSink => _loginController.sink;

  Stream<ApiResponse<User>> get loginStream => _loginController.stream;

  LoginBloc({email, password}) {
    _loginController = StreamController<ApiResponse<User>>();
    _loginRepository = LoginRepository();
    login(email: email, password: password);
  }

  login({email, password}) async {
    loginSink.add(ApiResponse.loading('Processing'));
    try {
      User response = await _loginRepository.loginUserRepo(
          email: email, password: password);
      loginSink.add(ApiResponse.completed(response));
    } catch (e) {
      loginSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _loginController?.close();
  }
}
