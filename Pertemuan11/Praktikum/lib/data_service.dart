import 'package:dio/dio.dart';

import 'user.dart';

class DataService {
  final Dio dio = Dio();
  final String _baseUrl = 'https://reqres.in';

  Future getUsers() async {
    try {
      Response response = await dio.get('$_baseUrl/api/users');
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  // Future postUser(String name, String job) async {
  Future<UserCreate?> postUser(UserCreate user) async {
    try {
      Response response =
          await dio.post('$_baseUrl/api/users', data: user.toJson());
      if (response.statusCode == 201) {
        return UserCreate.fromJson(response.data);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  // Future putUser(String idUser, String name, String job) async {
  Future<UserUpdate?> putUser(String idUser, UserUpdate user) async {
    try {
      Response response =
          await dio.put('$_baseUrl/api/users/$idUser', data: user.toJson());
      if (response.statusCode == 200) {
        return UserUpdate.fromJson(response.data);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future deleteUser(String idUser) async {
    try {
      Response response = await dio.delete('$_baseUrl/api/users/$idUser');
      if (response.statusCode == 204) {
        return "Data berhasil dihapus";
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future<Iterable<User>?> getUserModel() async {
    try {
      Response response = await dio.get('$_baseUrl/api/users');
      if (response.statusCode == 200) {
        final users = (response.data['data'] as List)
            .map((e) => User.fromJson(e))
            .toList();
        return users;
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }
}