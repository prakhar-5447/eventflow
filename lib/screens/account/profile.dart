import 'package:eventflow/handlers/input_handler.dart';
import 'package:eventflow/screens/account/email_screen.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController _name = TextEditingController(text: "John Doe");
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _org = TextEditingController();
  final _formatter = SingleSpaceInputFormatter();
  final _isButtonEnabled = false.obs;
  final _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        primary: true,
        title: const Text(
          "PROFILE",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(
          size: 18,
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 18,
            ),
          ),
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openEndDrawer();
              },
              child: const Icon(
                Icons.menu_rounded,
                size: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 130, 170, 255),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                // Get.to(() => AccountScreen());
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.policy_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final url = Uri.parse(
                    'https://prakhar-5447.github.io/rahobharat_website/privacypolicy');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.support_rounded,
                color: Colors.black,
              ),
              title: const Text(
                'Support',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final url = Uri.parse(
                    'https://prakhar-5447.github.io/rahobharat_website/helpandsupport');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('auth-token');
                // Get.off(() => AuthScreen());
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              120,
                            ),
                          ),
                          child: Image.asset(
                            "assets/profile_dummy.png",
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(
                              8,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  100,
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "UID: 312098237428",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w300,
                            color: AppColors.grey,
                          ),
                        ),
                        Obx(() {
                          return TextField(
                            cursorWidth: 1.5,
                            onChanged: (value) {
                              if (!_isButtonEnabled.value &&
                                  (value.isNotEmpty)) {
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
                            controller: _name,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 241, 241, 241),
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    5,
                                  ),
                                ),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              hintText: 'Name',
                            ),
                          );
                        }),
                        const Text(
                          "Last updated on 3rd June",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() {
                return TextField(
                  cursorWidth: 1.5,
                  minLines: 6,
                  maxLines: 6,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _isButtonEnabled.value = true;
                      return;
                    }
                    if (value.isEmpty) {
                      _isButtonEnabled.value = false;
                    }
                  },
                  enabled: !_isLoading.value,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z0-9./, ]'),
                    ),
                    LengthLimitingTextInputFormatter(400),
                    _formatter,
                  ],
                  controller: _bio,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  decoration: const InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    fillColor: Color.fromARGB(255, 241, 241, 241),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    hintText: 'Bio',
                  ),
                );
              }),
              const SizedBox(
                height: 12,
              ),
              Obx(() {
                return TextField(
                  cursorWidth: 1.5,
                  onChanged: (value) {
                    if (!_isButtonEnabled.value && (value.isNotEmpty)) {
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
                  controller: _org,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 241, 241, 241),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 241, 241, 241),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    hintText: 'Organisation',
                  ),
                );
              }),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
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
                  onPressed: () {},
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                "Contact Info",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Get.to(() => EmailScreen());
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                "Social Account",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Google",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
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
                              width: 15,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Sign in with Google",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "By integrating Google Sign-In, users can authenticate themselves with their Google account, leveraging Google's robust security infrastructure to ensure safe and straightforward access to your platform.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Google",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 7,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "prakhar_5447",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "By integrating Github, users can authenticate themselves with their Google account, leveraging Github's robust security infrastructure to ensure safe and straightforward access to your platform.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
