import 'package:flutter/material.dart';

class AnnouncementTab extends StatelessWidget {
  const AnnouncementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 18,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 30,
            ),
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            child: const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sorry for Inconvenience, there will be delay in session “Introduction to Web Dev”",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "19:32",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "~John Doe",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
