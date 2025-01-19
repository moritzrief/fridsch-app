import 'package:dio/dio.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import 'connection.service.dart';
import 'models/user.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  UserService._internal();

  factory UserService() => _instance;

  String _token = "";
  User? _user;

  Future<String?> login(String email, String pwd) async {
    try {
      var res = await kDio.post('/auth/login', data: {
        "email": email,
        "pwd": pwd,
      });

      _token = res.data["access_token"];
      print('login');
      //check errors

      return res.data["access_token"];
    } catch (e) {
      return null;
    }
  }

  Future<String?> register(String name, String email, String pwd) async {
    try {
      var res = await kDio.post('/auth/register', data: {
        "displayName": name,
        "email": email,
        "password": pwd,
      });
      //ceck errors
      _token = res.data["access_token"];
      print('register');

      return res.data["access_token"];
    } catch (e) {
      return null;
    }
  }

  Future<String?> loginWithGoogle() async {
    try {
      final url = Uri.http('https://api.fridsch.mrief.dev', '/auth/google');
      final result = Uri.parse(await FlutterWebAuth.authenticate(
              url: url.toString(), callbackUrlScheme: 'fridsch'))
          .queryParameters['token']!;
      _token = result;
      print('GoogleLogin');
      return result;
    } catch (e) {
      print('GoogleLogin canceled');
      //User canceled login
    }
    print('GoogleLogin');
  }

  Future<User> getInfo() async {
    var res = await kDio.get('/userdata',
        options: Options(headers: {
          "Authorization": "Bearer $_token",
        }));

    print('getUserInfo');
    //ceck errors
    _user = User.fromJson(res.data);
    return _user!;
  }

  Future<String> getUsername() async {
    return _user == null ? (await getInfo()).displayName : _user!.displayName;
  }

  get token => _token;
}
