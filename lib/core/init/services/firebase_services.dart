import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:medication_app_v0/core/components/models/others/firebase_auth_error.dart';
import 'package:medication_app_v0/core/components/models/others/user_data_model.dart';
import 'package:medication_app_v0/core/components/models/others/user_request.dart';

class FirebaseService {
  final dio = Dio(BaseOptions(
      baseUrl:
          "https://medicationapp-92ffd-default-rtdb.europe-west1.firebasedatabase.app"));
  final String _firebaseURL =
      "https://medicationapp-92ffd-default-rtdb.europe-west1.firebasedatabase.app";
  final String _firebaseAuthUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDtcp7MBA7x8SSz_Z8bgHRxwLjLEyyjOFY";

  //sign İn with email and password
  Future postUser(UserRequest request) async {
    try {
      var jsonBody = jsonEncode(request.toJson());
      final response = await dio.post(_firebaseAuthUrl, data: jsonBody);
      print(response.toString());
      return response;
    } catch (e) {
      return FirebaseAuthError();
    }
  }

  Future<UserDataModel> getUserData(String token, String uid) async {
    String path = '/users/$uid.json';
    var response = await dio.get(path, queryParameters: {'auth': token});
    if (response.statusCode == HttpStatus.ok) {
      UserDataModel userData = UserDataModel.fromJson(response.data);
      print("valla geldi!!!! ${userData.toString()}");
      return userData;
    } else {
      print("patladık!!!!!!!! ${response.statusCode}");
      return null;
    }
  }

  Future putUserData(String uid, UserDataModel userDataModel) async {
    String path = '/users/$uid.json';
    var response = await dio.put(path, data: userDataModel.toJson());
    if (response.statusCode == HttpStatus.ok) {
      print(response.data.toString());
      return true;
    }
  }
}
