import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatelessWidget {
  final _chats = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        primary: true,
        title: const Text(
          "CHATS",
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
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i in _chats)
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  100,
                                ),
                              ),
                              child: Image.asset(
                                "assets/profile_dummy.png",
                                width: 55,
                                height: 55,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "John Doe",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "19:32",
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Just want to discuss about the last session. I will send you meet..",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
