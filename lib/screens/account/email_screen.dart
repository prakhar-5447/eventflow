import 'package:eventflow/handlers/toast_handlers.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailScreen extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final _isEnabled = false.obs;
  final _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        title: const Text(
          "Email",
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
          Obx(
            () => _isLoading.value
                ? const CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: Colors.black,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.check_rounded,
                      color: _isEnabled.value
                          ? const Color.fromARGB(255, 33, 65, 243)
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (_isEnabled.value) {
                        if (_email.text.isEmpty) {
                          return;
                        }
                        final RegExp emailRegex = RegExp(r'^.+@gmail\.com$');
                        if (emailRegex.hasMatch("${_email.text}@gmail.com")) {
                          if (context.mounted) {
                            _showPincodeBottomSheet(context);
                          }
                        } else {
                          showToast('Please enter a valid email address');
                        }
                      }
                    },
                  ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email_outlined,
                  size: 24,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Obx(() {
                    return TextField(
                      cursorWidth: 1.5,
                      onChanged: (value) {
                        const String emailWithoutSuffix = '';
                        if (value != emailWithoutSuffix) {
                          _isEnabled.value = true;
                          return;
                        }
                        if (emailWithoutSuffix == value) {
                          _isEnabled.value = false;
                        }
                      },
                      enabled: !_isLoading.value,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[a-z0-9.]'),
                        ),
                      ],
                      controller: _email,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: UnderlineInputBorder(),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(),
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        hintText: 'Email (optional)',
                        suffixText: '@gmail.com',
                        suffixStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              "*We will send you otp for verification. OTP will expire after 2 min.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPincodeBottomSheet(BuildContext context) {
    final passcode = "".obs;
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Enter Pincode',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Enter pincode you received in your email address ${_email.text}@gmail.com.\n(only active for 2 minutes)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: PinCodeTextField(
                            appContext: context,
                            length: 6,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              passcode.value = value;
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
                              activeColor:
                                  const Color.fromARGB(255, 128, 126, 255),
                              selectedColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
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
                        "Verify",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
