import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'pages/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

// GetX orqali temani boshqarish uchun controller
class ThemeController extends GetxController {
  // Dastlabki holat: light theme
  RxBool isDarkMode = false.obs;

  // Tema almashtirish metodi
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ilovaning barcha joyida foydalanish uchun ThemeController ni yarating
    final themeController = Get.put(ThemeController());
    return Obx(
          () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tic Tac Toe',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        // themeMode themeController.isDarkMode ga qarab yangilanadi
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: const HomePage(),
      ),
    );
  }
}
