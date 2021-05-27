import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:medication_app_v0/core/components/models/others/firebase_auth_error.dart';
import 'package:medication_app_v0/core/components/models/others/user_data_model.dart';
import 'package:medication_app_v0/core/components/models/others/user_request.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';

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

  Future<List<InventoryModel>> getMedications(String token, String uid) async {
    String path = '/medications/$uid.json';
    List<InventoryModel> modelList = [];
    var response = await dio.get(path, queryParameters: {'auth': token});
    var data = response.data;
    if (response.statusCode == HttpStatus.ok) {
      if (data is Map) {
        //convert json to List of InventoryModel
        data.forEach((key, value) {
          //.fromJson change to .fromMap! firebase response is map!
          modelList.add(InventoryModel.fromMap(value));
        });
        return modelList;
      } else {
        print("Firebase Medication Error");
      }
    }
    return [];
  }

  Future<bool> postMedication(
      String uid, String token, InventoryModel model) async {
    String path = '/medications/$uid.json';
    var response = await dio
        .post(path, data: model.toJson(), queryParameters: {'auth': token});
    if (response.statusCode == HttpStatus.ok) {
      print(response.data.toString());
      return true;
    } else {
      print("postmedication error!!");
      return false;
    }
  }

  Future deleteMedication(
      String uid, String token, InventoryModel model) async {
    String path = '/medications/$uid.json';
    var response = await dio.delete(path, queryParameters: {'auth': token});
    print(response);
  }
}
