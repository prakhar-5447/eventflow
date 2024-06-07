import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';

class RoadmapTab extends StatelessWidget {
  final List<Map<String, String>> _sessions = [
    {
      'title': 'Introduction to Web Dev',
      'banner': 'assets/hackathon_1_poster.png',
      'desc':
          "Introduction to Html, Css and javascript. with use of bootstrap and stylesheet etc."
    },
    {
      'title': 'Introduction to Web Dev',
      'banner': 'assets/hackathon_1_poster.png',
      'desc':
          "Introduction to Html, Css and javascript. with use of bootstrap and stylesheet etc."
    },
    {
      'title': 'Introduction to Web Dev',
      'banner': 'assets/hackathon_1_poster.png',
      'desc':
          "Introduction to Html, Css and javascript. with use of bootstrap and stylesheet etc."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          for (var i in _sessions)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 12,
                        color: AppColors.orange,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "HackTheLeague",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 4.5,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(
                            left: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(11),
                                ),
                                child: Image.asset(
                                  "assets/hackathon_1_poster.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "${i["desc"]}",
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
