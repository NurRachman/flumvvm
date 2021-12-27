import 'package:dio/dio.dart';
import 'package:flumvvm/model/user.dart';
import 'package:flumvvm/network/api.dart';
import 'package:flumvvm/util/constants.dart';

class UserRepository {
  var baseApi = api();

  Future<List<Users>> getUsers() async {
    Response response = await baseApi.get(Constants.getUsers);
    if (response.statusCode == STATUS_OK) {
      var data = response.data;
      var userData = <Users>[];

      data.forEach((v) {
        userData.add(Users.fromJson(v));
      });

      return userData;
    } else {
      throw Exception(response.data['message']);
    }
  }

}