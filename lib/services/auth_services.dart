import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:eventflow/handlers/toast_handlers.dart';
import 'package:eventflow/services/constant.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  dynamic auth(String email, String password) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userAccess);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      if (response.statusCode == 200) {
        return authFromJson(response.body);
      } else if (response.statusCode == 401) {
        throw HttpException(response.statusCode.toString());
      } else {
        return {'success': false, 'message': 'Internal server error'};
      }
    } catch (error) {
      if (error is SocketException) {
        showToast('Network error, please check your internet connection');
        rethrow;
      } else if (error is HttpException) {
        rethrow;
      } else {
        showToast('An unexpected error occurred');
        log('Unexpected error: $error');
      }
    }
  }

  dynamic verify(String email, String password, String passcode) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.verify);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {'email': email, 'password': password, "otp": passcode}));
      if (response.statusCode == 200) {
        return authFromJson(response.body);
      } else if (response.statusCode == 401) {
        throw HttpException(response.statusCode.toString());
      } else {
        return {'success': false, 'message': 'Internal server error'};
      }
    } catch (error) {
      if (error is SocketException) {
        showToast('Network error, please check your internet connection');
        rethrow;
      } else if (error is HttpException) {
        rethrow;
      } else {
        showToast('An unexpected error occurred');
        log('Unexpected error: $error');
      }
    }
  }
}

dynamic authFromJson(String json) {
  final data = jsonDecode(json);
  bool success = data['success'];
  String message = data['message'];

  if (success) {
    String? token = data['token'];
    bool status = data['status'] ?? false;
    if (token == null) {
      return {"success": success, "message": message, "verified": false};
    } else if (status) {
      return {
        "success": success,
        "message": message,
        "auth-token": token,
        "status": status,
        "verified": true,
        "data": userDataFromJson(json)
      };
    } else {
      return {
        "success": success,
        "message": message,
        "auth-token": token,
        "status": status,
        "verified": true,
        "_id": data["data"]
      };
    }
  }

  return {
    "success": success,
    "message": message,
  };
}

dynamic userDataFromJson(String json) {
  final data = jsonDecode(json)["data"];
  String id = data["_id"];
  String avatar = data['avatar'];
  String name = "";
  String email = "";
  String phoneNumber = data['phoneNumber'];
  String gender = "";
  String occupation = "";

  if (data["name"] != null) {
    name = data['name'];
    email = data['email'];
    gender = data['gender'];
    occupation = data['occupation'];
  }

  return {
    "_id": id,
    "avatar": avatar,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "gender": gender,
    "occupation": occupation
  };
}

dynamic verifyFromJson(String json) {
  final data = jsonDecode(json);
  bool success = data['success'];
  String message = data['message'];

  if (success) {
    String token = data['token'];
    return {
      "success": success,
      "message": message,
      "auth-token": token,
      "_id": data["data"]
    };
  }
  return {
    "success": success,
    "message": message,
  };
}
