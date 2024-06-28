import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:eventflow/controllers/user_controller.dart';
import 'package:eventflow/handlers/toast_handlers.dart';
import 'package:eventflow/screens/auth/profile.dart';
import 'package:eventflow/screens/auth/auth_screen.dart';
import 'package:eventflow/screens/bottom_navigation_tabs.dart';
import 'package:eventflow/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
  final AuthServices _authServices = AuthServices();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    loadToken();
  }

  void loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String authToken = prefs.getString('auth-token') ?? '';
      if (authToken.isEmpty) {
        Get.off(() => AuthScreen());
        return;
      }

      dynamic response = await widget._authServices.getAccount();
      if (response == null) {
        prefs.remove('auth-token');
        Get.off(() => AuthScreen());
        return;
      }

      if (!response["success"] || !response["status"]) {
        showToast(response["message"]);
        prefs.remove('auth-token');
        Get.off(() => AuthScreen());
        return;
      }

      final userController = Get.find<UserController>();
      userController.id = response["data"]["_id"];
      final avatar = Uint8List.fromList(response["data"]["avatar"]);
      userController.avatar = avatar;
      userController.name = response["data"]["name"];
      Get.offAll(() => BottomNavigationScreen());
    } catch (error) {
      prefs.remove('auth-token');
      Get.off(() => AuthScreen());
      showToast("Failed to login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Image.asset(
            "assets/eventflow.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
