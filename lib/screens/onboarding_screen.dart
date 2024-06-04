import 'package:eventflow/handlers/toast_handlers.dart';
import 'package:eventflow/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    loadToken();
  }

  void loadToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String authToken = prefs.getString('auth-token') ?? '';

      if (authToken.isEmpty) {
        Get.off(() => AuthScreen());
        return;
      }

      Get.off(() => AuthScreen());
    } catch (error) {
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
