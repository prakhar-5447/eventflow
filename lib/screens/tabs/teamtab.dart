import 'package:eventflow/handlers/input_handler.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TeamTab extends StatelessWidget {
  final TextEditingController _code = TextEditingController();
  final _formatter = SingleSpaceInputFormatter();
  final _isButtonEnabled = false.obs;
  final _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 26,
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.all(
              Radius.circular(
                5,
              ),
            ),
          ),
          child: Obx(() {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
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
                    controller: _code,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      hintText: 'Enter Team Code',
                    ),
                  ),
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
                  onPressed: () {},
                  child: const Text(
                    "Join",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          }),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "or",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
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
              "Create Team",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/team_code.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TEAM CODE: 564372",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.copy_all_rounded,
                  size: 20,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
