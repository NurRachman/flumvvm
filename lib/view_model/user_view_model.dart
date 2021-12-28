import 'package:flumvvm/model/base_response.dart';
import 'package:flumvvm/model/user.dart';
import 'package:flumvvm/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  BaseResponse<List<Users>> _responseUsers =
      BaseResponse<List<Users>>.initial("Empty");

  BaseResponse<List<Users>> get responseUsers {
    return _responseUsers;
  }

  Future<void> getUsers() async {
    _responseUsers = BaseResponse<List<Users>>.loading("Loading...");
    notifyListeners();

    try {
      List<Users> response = await UserRepository().getUsers();
      _responseUsers = BaseResponse<List<Users>>.completed(response);

      notifyListeners();
    } catch (e) {
      _responseUsers = BaseResponse<List<Users>>.error(e.toString());
      debugPrint(e.toString());

      notifyListeners();
    }
  }
}
