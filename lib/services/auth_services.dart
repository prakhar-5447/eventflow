import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:eventflow/handlers/toast_handlers.dart';
import 'package:eventflow/services/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  dynamic profile(
    String image,
    String name,
  ) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.profile);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth-token');
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = '$token'
        ..files.add(await http.MultipartFile.fromPath(
          'avatar',
          image,
        ));
      request.fields['name'] = name;
      var response = await request.send();
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            jsonDecode(await response.stream.bytesToString());
        return {
          "success": responseData["success"],
          "message": responseData["message"]
        };
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

  dynamic getAccount() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getAccount);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth-token');
      var response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token'
      });
      if (response.statusCode == 200) {
        return getFromJson(response.body);
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
  List<int> avatar = (data['avatar']["data"]["data"] as List<dynamic>)
      .map((e) => e as int)
      .toList();
  String name = data['name'];

  return {
    "_id": id,
    "avatar": avatar,
    "name": name,
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

dynamic getFromJson(String json) {
  final data = jsonDecode(json);
  bool success = data['success'];
  String message = data['message'];
  if (success) {
    String name = data["data"]["name"] ?? "";
    if (name.isNotEmpty) {
      return {
        "success": success,
        "message": message,
        "status": true,
        "data": userDataFromJson(json)
      };
    } else {
      log("5");
      return {
        "success": success,
        "message": message,
        "status": false,
        "_id": data["data"]["_id"]
      };
    }
  }

  return {
    "success": success,
    "message": message,
  };
}
