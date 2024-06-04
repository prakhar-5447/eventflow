import 'package:eventflow/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreScreen extends StatelessWidget {
  final _recommendations = [1, 2, 3, 4, 5].obs;
  final _categories = [1, 2, 3, 4, 5].obs;
  final _upcoming = [1, 2, 3, 4, 5, 6, 7].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        primary: true,
        title: Row(
          children: [
            Image.asset(
              "assets/google.png",
              width: 35,
              height: 35,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "EventFlow",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(
          size: 18,
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 18,
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(
                Icons.menu_rounded,
                size: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 130, 170, 255),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.account_circle_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                // Get.to(() => AccountScreen());
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.policy_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final url = Uri.parse(
                    'https://prakhar-5447.github.io/rahobharat_website/privacypolicy');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.support_rounded,
                color: Colors.black,
              ),
              title: const Text(
                'Support',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final url = Uri.parse(
                    'https://prakhar-5447.github.io/rahobharat_website/helpandsupport');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.remove('auth-token');
                // Get.off(() => AuthScreen());
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Discover exciting events\non your ease",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          7,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(50, 0, 0, 0),
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          size: 18,
                          color: AppColors.grey,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Find Events",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 30,
              ),
              child: Text(
                "Featured Events",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 280,
              child: Obx(() {
                return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: _recommendations.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          right: 20,
                        ),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/hackathon_1_poster.png",
                              fit: BoxFit.cover,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "HackTheLeague",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.purple,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 10,
                                          ),
                                          Text(
                                            ": 05 - 06 May",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.orange,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 20,
              ),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 80,
              child: Obx(() {
                return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: _categories.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.blue,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              7,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/category_hackathon.png",
                              width: 22,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Hackathon",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() {
              return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  itemCount: _upcoming.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/hackathon_1_poster.png",
                          fit: BoxFit.fitWidth,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hackathon",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: 10,
                                  ),
                                  Text(
                                    ": 05 - 06 May",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Join us on the hackathon for exciting rewards and more. Also invite your friends and join together in group...",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}
