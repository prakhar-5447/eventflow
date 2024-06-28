import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventflow/controllers/user_controller.dart';
import 'package:eventflow/handlers/input_handler.dart';
import 'package:eventflow/handlers/toast_handlers.dart';
import 'package:eventflow/screens/bottom_navigation_tabs.dart';
import 'package:eventflow/services/auth_services.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSliderController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

class ProfileScreen extends StatelessWidget {
  final ImageSliderController controller = Get.put(ImageSliderController());
  final TextEditingController _name = TextEditingController();
  final AuthServices _authServices = AuthServices();
  final _formatter = SingleSpaceInputFormatter();
  var _imagePickerStatus = false;
  final _isEnabled = false.obs;
  final _isLoading = false.obs;
  final List<String> imgList = [
    'assets/hackathon_1_poster.png',
    'assets/event_banner.png',
    'assets/hackathon_1_poster.png',
  ];
  final imagePath = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        primary: true,
        title: const Text(
          "Complete your profile",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(
          size: 18,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.blue.withOpacity(0.5),
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              CarouselSlider(
                items: imgList.map((item) {
                  return ClipOval(
                    child: Image.asset(
                      item,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  );
                }).toList()
                  ..add(
                    ClipOval(
                      child: GestureDetector(
                          onTap: _importImage,
                          child: Obx(() {
                            if (imagePath.value == '') {
                              return Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Color.fromARGB(255, 44, 44, 44),
                                ),
                              );
                            } else {
                              return Image.file(
                                File(imagePath.value),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                            }
                          })),
                    ),
                  ),
                options: CarouselOptions(
                  height: 100.0,
                  viewportFraction: 0.4,
                  initialPage: 0,
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    controller.changeIndex(index);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Obx(() {
                  return TextField(
                    cursorWidth: 1.5,
                    onChanged: (value) {
                      if (!_isEnabled.value && (value.isNotEmpty)) {
                        _isEnabled.value = true;
                        return;
                      }
                      if (value.isEmpty) {
                        _isEnabled.value = false;
                      }
                    },
                    enabled: !_isLoading.value,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z ]'),
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
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() {
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
                          _profile();
                        }
                      },
                      child: Obx(() {
                        return _isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              )
                            : const Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                      }),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _importImage() async {
    if (_imagePickerStatus) return;
    _imagePickerStatus = true;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: const CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ],
      );
      if (croppedImage != null) {
        imagePath.value = croppedImage.path;
        _imagePickerStatus = false;
        return;
      }
    }
    imagePath.value = '';
    showToast("Failed to select image");
    _imagePickerStatus = false;
  }

  void _profile() async {
    _isLoading.value = true;
    final name = _name.text;

    try {
      dynamic response = await _authServices.profile(imagePath.value, name);
      if (response == null) {
        _isLoading.value = false;
        return;
      }

      if (!response["success"]) {
        _isLoading.value = false;
        showToast(response["message"]);
        return;
      }
      
      final userController = Get.find<UserController>();
      userController.name = name;
      final File imageFile = File(imagePath.value);
      final Uint8List imageBytes = await imageFile.readAsBytes();
      userController.avatar = imageBytes;
      Get.offAll(() => BottomNavigationScreen());
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
