import 'package:eventflow/handlers/input_handler.dart';
import 'package:eventflow/screens/bottom_navigation_tabs.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formatter = SingleSpaceInputFormatter();
  final _isButtonEnabled = false.obs;
  final _isLoading = false.obs;
  final _isVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("English"),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/eventflow.png",
                      height: 40,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Obx(() {
                      return TextField(
                        cursorWidth: 1.5,
                        onChanged: (value) {
                          if (!_isButtonEnabled.value &&
                              (_password.text.isNotEmpty && value.isNotEmpty)) {
                            _isButtonEnabled.value = true;
                            return;
                          }
                          if (value.isEmpty) {
                            _isButtonEnabled.value = false;
                          }
                        },
                        enabled: !_isLoading.value,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9@.]'),
                          ),
                          _formatter,
                        ],
                        controller: _email,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 250, 250, 250),
                          contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          hintText: 'Email',
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return TextField(
                        cursorWidth: 1.5,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autocorrect: false,
                        obscureText: !_isVisible.value,
                        onChanged: (value) {
                          if (!_isButtonEnabled.value &&
                              (_email.text.isNotEmpty && value.isNotEmpty)) {
                            _isButtonEnabled.value = true;
                            return;
                          }
                          if (value.isEmpty) {
                            _isButtonEnabled.value = false;
                          }
                        },
                        enabled: !_isLoading.value,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9@]'),
                          ),
                          _formatter,
                        ],
                        controller: _password,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 250, 250, 250),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 18, 20, 18),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                          ),
                          hintStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Obx(() {
                              return Icon(
                                _isVisible.value
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                color: Colors.grey,
                              );
                            }),
                            onPressed: () {
                              _isVisible.value = !_isVisible.value;
                            },
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: Obx(() {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                !_isLoading.value && _isButtonEnabled.value
                                    ? AppColors.blue
                                    : AppColors.disabledColor,
                            foregroundColor: _isButtonEnabled.value
                                ? Colors.white
                                : const Color.fromARGB(255, 230, 230, 230),
                            shape: const LinearBorder(),
                          ),
                          onPressed: () async {
                            if (!_isLoading.value && _isButtonEnabled.value) {
                              Get.off(() => BottomNavigationScreen());
                            }
                          },
                          child: Obx(() {
                            return _isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  )
                                : const Text(
                                    "Continue",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                          }),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('OR'),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                2,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(50, 0, 0, 0),
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/google.png",
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                2,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(57, 0, 0, 0),
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/github.png",
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Sign in with Github",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: Color.fromARGB(255, 216, 216, 216),
                    ),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'By continuing, you agree to our ',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 175, 175, 175),
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final url = Uri.parse(
                                'https://prakhar-5447.github.io/eventflow/termsandconditions');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                      ),
                      const TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            final url = Uri.parse(
                                'https://prakhar-5447.github.io/eventflow/privacypolicy');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
