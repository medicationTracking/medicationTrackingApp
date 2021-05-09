import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:medication_app_v0/core/components/models/others/firebase_auth_error.dart';
import 'package:medication_app_v0/core/components/models/others/user_request.dart';

class FirebaseService {
  final dio = Dio();
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
  /*
  Future postModel(T model){
    try {
      var jsonBody = jsonEncode(model.toJson());
      final response = await dio.post(_firebaseAuthUrl, data: jsonBody);
      print(response.toString());
      return response;
    } catch (e) {
      return FirebaseAuthError();
    }
  }*/

}
