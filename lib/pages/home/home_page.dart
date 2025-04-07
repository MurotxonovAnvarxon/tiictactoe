import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tiictactoe/main.dart';
import 'package:tiictactoe/pages/game/game_page.dart';

import 'light.dart';

part 'game_mode_selection_widget.dart';
part 'game_title_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Efekti AppBar ortida ham ko‘rinishi uchun:
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Obx(() {
          bool isDark = themeController.isDarkMode.value;
          return GestureDetector(
            onTap: () {
              themeController.toggleTheme();
            },
            child: Icon(Icons.light_outlined, size: 80, color: isDark ? Colors.white : Colors.black),
          );
        }),
      ),
      body: Stack(
        children: [
          // Faqat dark mode bo'lganda spotlight effektini ko'rsatish:
          Obx(() {
            return themeController.isDarkMode.value
                ? Positioned.fill(
              top: 65,
              child: CustomPaint(
                painter: RectangularSpotlightPainter(
                  topWidth: 56, // Yorug'lik manbai (AppBar dagi ikonka) kengligi
                  color: Colors.white,
                ),
              ),
            )
                : const SizedBox.shrink();
          }),
          // Ustida qolgan vidjetlar:
          Column(
            children: const [
              Spacer(flex: 3),
              SizedBox(height: 10),
              GameTitleWidget(),
              Spacer(),
              GameModeSelectionWidget(),
              Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
