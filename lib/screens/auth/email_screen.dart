import 'dart:io';

import 'package:eventflow/handlers/toast_handlers.dart';
import 'package:eventflow/screens/auth/profile.dart';
import 'package:eventflow/services/auth_services.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailScreen extends StatelessWidget {
  late String _email;
  late String _password;
  final AuthServices _authServices = AuthServices();
  var _passcode = "";
  final _isEnabled = false.obs;
  final _isLoading = false.obs;

  EmailScreen({required String? email, required String? password}) {
    if (email == null || password == null) {
      Get.back();
      return;
    }
    _email = email;
    _password = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        primary: true,
        title: Image.asset(
          "assets/eventflow.png",
          width: 100,
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(
          size: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 197, 229, 255),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      100,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: const Icon(
                  Icons.email_outlined,
                  size: 30,
                  color: Color.fromARGB(255, 126, 197, 255),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Enter pincode you received in your email address $_email@gmail.com.\n(only active for 2 minutes)",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    _passcode = value;
                    if (_passcode.length == 6) {
                      _isEnabled.value = true;
                    } else {
                      _isEnabled.value = false;
                    }
                  },
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  pinTheme: PinTheme(
                    fieldWidth: 35,
                    fieldHeight: 50,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        4,
                      ),
                    ),
                    shape: PinCodeFieldShape.box,
                    inactiveColor: Colors.grey,
                    activeColor: const Color.fromARGB(255, 128, 126, 255),
                    selectedColor: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Obx(() {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: !_isLoading.value && _isEnabled.value
                      ? AppColors.blue
                      : AppColors.disabledColor,
                  foregroundColor: _isEnabled.value
                      ? Colors.white
                      : const Color.fromARGB(255, 230, 230, 230),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        5,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (!_isLoading.value && _isEnabled.value) {
                    _verify();
                  }
                },
                child: Obx(() {
                  return _isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      : const Text(
                          "Verify",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _verify() async {
    _isLoading.value = true;
    final passcode = _passcode;

    try {
      dynamic response =
          await _authServices.verify(_email, _password, passcode);
      if (response == null) {
        _isLoading.value = false;
        return;
      }

      if (!response["success"]) {
        _isLoading.value = false;
        showToast(response["message"]);
        return;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth-token', response["auth-token"]);
      Get.to(() => ProfileScreen());
      _isLoading.value = false;
      return;
    } catch (error) {
      _isLoading.value = false;
      if (error is SocketException) {
        return;
      }
      if (error is HttpException) {
        if (error.message == "401") {
          _isEnabled.value = false;
          showToast("Failed to verify");
          return;
        }
      }
    }
  }
}
