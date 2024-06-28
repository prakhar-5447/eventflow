import 'package:eventflow/controllers/user_controller.dart';
import 'package:eventflow/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MainApp());
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      title: 'EventFlow',
      home: OnboardingScreen(),
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
            elevation: WidgetStateProperty.all<double>(0),
            enableFeedback: false,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.transparent;
                }
                return null;
              },
            ),
          ),
        ),
        buttonTheme: const ButtonThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          enableFeedback: false,
        )),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
            elevation: WidgetStateProperty.all<double>(0),
            enableFeedback: false,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) {
                  return Colors.transparent;
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}
