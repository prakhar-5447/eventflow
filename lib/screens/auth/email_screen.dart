import 'package:eventflow/screens/auth/profile.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final _passcode = "".obs;
  final _isEnabled = false.obs;
  final _isLoading = false.obs;

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
              "Enter pincode you received in your email address ${_email.text}@gmail.com.\n(only active for 2 minutes)",
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
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    _passcode.value = value;
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      5,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Get.off(() => ProfileScreen());
              },
              child: const Text(
                "Verify",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
