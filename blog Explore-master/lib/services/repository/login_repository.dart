import 'dart:convert';

import 'package:blog/models/user_model.dart';
import 'package:blog/services/networking/api_base_helper.dart';

final url = 'login';

class LoginRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<User> loginUserRepo({email, password}) async {
    Map _body = {"email": email, "password": password};
    final response = await _helper.post(url: url, body: _body);
    return User.fromJson(jsonDecode(response.toString()));
  }
}
