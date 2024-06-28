import 'dart:typed_data';

import 'package:eventflow/controllers/bottom_navigation_controller.dart';
import 'package:eventflow/controllers/user_controller.dart';
import 'package:eventflow/screens/chat/chats.dart';
import 'package:eventflow/screens/event/events.dart';
import 'package:eventflow/screens/home/explore.dart';
import 'package:eventflow/screens/account/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationScreen extends StatelessWidget {
  final BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());
  final UserController usercontroller = Get.put(UserController());

  final List<Widget> screens = [
    ExploreScreen(),
    EventsScreen(),
    ChatsScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 3,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.grey,
        shape: const CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
        notchMargin: 8,
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              splashColor: Colors.transparent,
              enableFeedback: false,
              onPressed: () => controller.changeTabIndex(0),
              icon: Obx(() {
                return Icon(
                  Icons.home_rounded,
                  color: controller.selectedIndex.value == 0
                      ? Colors.black
                      : Colors.grey,
                  size: 22,
                );
              }),
            ),
            IconButton(
              splashColor: Colors.transparent,
              enableFeedback: false,
              onPressed: () => controller.changeTabIndex(1),
              icon: Obx(() {
                return Icon(
                  Icons.event_note_rounded,
                  color: controller.selectedIndex.value == 1
                      ? Colors.black
                      : Colors.grey,
                  size: 22,
                );
              }),
            ),
            const SizedBox(width: 50),
            IconButton(
              splashColor: Colors.transparent,
              enableFeedback: false,
              onPressed: () => controller.changeTabIndex(2),
              icon: Obx(() {
                return Icon(
                  controller.selectedIndex.value == 2
                      ? Icons.chat_rounded
                      : Icons.chat_outlined,
                  color: controller.selectedIndex.value == 2
                      ? Colors.black
                      : Colors.grey,
                  size: 22,
                );
              }),
            ),
            GestureDetector(
              onTap: () {
                controller.changeTabIndex(3);
              },
              child: Obx(() {
                return Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: controller.selectedIndex.value == 3
                          ? Colors.black
                          : Colors.grey.withOpacity(0.5),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        80,
                      ),
                    ),
                    child: Image.memory(
                      usercontroller.avatar ?? Uint8List(0),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        focusElevation: 0,
        shape: const CircleBorder(),
        elevation: 0,
        splashColor: Colors.transparent,
        enableFeedback: false,
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 90, 113, 240),
        child: const Icon(
          Icons.add,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
