import 'package:eventflow/handlers/input_handler.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SubmissionTab extends StatelessWidget {
  final TextEditingController _title = TextEditingController(text: "John Doe");
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _url = TextEditingController();
  final TextEditingController _link = TextEditingController();
  final _formatter = SingleSpaceInputFormatter();
  final _isButtonEnabled = false.obs;
  final _isLoading = false.obs;
  final selectedItem = "none".obs;
  final List<String> dropdownItems = <String>[
    "Open Innovation",
    "Tech",
    "Cloud"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Obx(() {
              return DropdownButton<String>(
                value: selectedItem.value == "none" ? null : selectedItem.value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                hint: Text(
                  'Select a domain',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) selectedItem.value = newValue;
                },
                isDense: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                  size: 15,
                ),
                items:
                    dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
            }),
          ),
          const SizedBox(
            height: 14,
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
              controller: _title,
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
                hintText: 'Project title',
              ),
            );
          }),
          const SizedBox(
            height: 16,
          ),
          Obx(() {
            return Stack(
              children: [
                TextField(
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
                  controller: _desc,
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
                    hintText: 'Description',
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _desc,
                    builder: (context, value, _) {
                      int wordCount = value.text.length;
                      return Text(
                        '$wordCount/400',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 165, 165, 165),
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
          const SizedBox(
            height: 16,
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
              controller: _url,
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
                hintText: 'Demo Video url',
              ),
            );
          }),
          const SizedBox(
            height: 16,
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
              controller: _link,
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
                hintText: 'Repository link',
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
                "Submit",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
