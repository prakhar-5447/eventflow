import 'dart:typed_data';

import 'package:get/get.dart';

class UserController extends GetxController {
  final Rx<String?> _id = Rx<String?>(null);
  final Rx<Uint8List?> _avatar = Rx<Uint8List?>(null);
  final Rx<String?> _name = Rx<String?>(null);

  String? get id => _id.value;
  set id(String? value) => _id.value = value;

  Uint8List? get avatar => _avatar.value;
  set avatar(Uint8List? value) => _avatar.value = value;

  String? get name => _name.value;
  set name(String? value) => _name.value = value;

  void logout() {
    _id.value = null;
    _avatar.value = null;
    _name.value = null;

    update();
  }
}
