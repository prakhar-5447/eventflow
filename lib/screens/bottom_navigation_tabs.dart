import 'package:eventflow/controllers/bottom_navigation_controller.dart';
import 'package:eventflow/screens/chats.dart';
import 'package:eventflow/screens/events.dart';
import 'package:eventflow/screens/explore.dart';
import 'package:eventflow/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationScreen extends StatelessWidget {
  final BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());

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
                      width: 1.5,
                      color: controller.selectedIndex.value == 3
                          ? Colors.black
                          : Colors.transparent,
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
                    // child: Image.memory(
                    //   Uint8List(0),
                    //   fit: BoxFit.cover,
                    //   filterQuality: FilterQuality.low,
                    //   colorBlendMode: BlendMode.darken,
                    // ),
                    child: Image.asset(
                      "assets/profile_dummy.png",
                      width: 30,
                      height: 30,
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
