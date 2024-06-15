import 'package:eventflow/screens/event/tabs/about.dart';
import 'package:eventflow/screens/event/tabs/announcement.dart';
import 'package:eventflow/screens/event/tabs/guidelines.dart';
import 'package:eventflow/screens/event/tabs/roadmap.dart';
import 'package:eventflow/screens/event/tabs/submission.dart';
import 'package:eventflow/screens/event/tabs/teamtab.dart';
import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailScreen extends StatelessWidget {
  final _tags =
      ["softwaredevelopment", "dev", "robotics", "innovation", "cloud"].obs;

  final List<Tab> _tabs = const <Tab>[
    Tab(
      text: 'About',
    ),
    Tab(
      text: 'Roadmap',
    ),
    Tab(
      text: 'Guidelines',
    ),
    Tab(
      text: 'Announcements',
    ),
    Tab(
      text: 'Team',
    ),
    Tab(
      text: 'Submission',
    ),
  ];

  final List<Widget> _tabsWidget = <Widget>[
    AboutTab(),
    RoadmapTab(),
    GuidelinesTab(),
    AnnouncementTab(),
    TeamTab(),
    SubmissionTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/event_banner.png",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "HackTheLeague",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              5,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Hybrid",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: const TextSpan(
                      text: "Registration ends on: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "05 May 2024",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: "Venue: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "SSTC CSE block, Junwani Road, Bhilai",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_rounded,
                        size: 18,
                        color: AppColors.blue,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "05 May - 06 May",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.group_add_outlined,
                        size: 18,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: [
                      for (var i in _tags)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          color: const Color.fromARGB(255, 241, 241, 241),
                          child: Text(
                            i,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: _tabs.length,
                child: Scaffold(
                  appBar: AppBar(
                    primary: false,
                    toolbarHeight: 0,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 0,
                      ),
                      tabs: _tabs,
                      tabAlignment: TabAlignment.start,
                      padding: EdgeInsets.zero,
                      isScrollable: true,
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TabBarView(
                      children: _tabsWidget,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 35,
          left: 18,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
            ),
          ),
        ),
      ],
    ));
  }
}
