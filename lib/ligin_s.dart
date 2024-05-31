import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'get_config.dart';
import 'user_model.dart';

abstract class LoginService {
  Dio dio = Dio();
  late Response response;
  String baseurl = 'https://dummyjson.com/auth/login';

  Future<bool> Login(UserModel user);
}

class LogInServiceImp extends LoginService {
  @override
  Future<bool> Login(UserModel user) async {
    try {
      response = await dio.post(baseurl, data: user.toMap());
      if (response.statusCode == 200) {
        core
            .get<SharedPreferences>()
            .setString('token', response.data['token']);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.message);
      return false;
    }
  }
}
