import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:tiictactoe/main.dart';

import '../../widgets/circle_widget.dart';
import '../../widgets/cross_widget.dart';
import '../game/game_page.dart';

part 'game_title_widget.dart';

part 'game_mode_selection_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final themeController = Get.find<ThemeController>();
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle', autoplay: false);
  }

  void _startAnimation() {
    // Agar animatsiya hali ishga tushmagan bo'lsa, uni ishga tushiramiz
    setState(() {
      _controller.isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(() {
            // Obx ichida to'g'ridan-to'g'ri observabledan foydalanamiz
            bool isDark = themeController.isDarkMode.value;
            return IconButton(
              icon: Icon(Icons.light, size: 24, color: isDark ? Colors.yellow : Colors.black),
              onPressed: () {
                themeController.toggleTheme();
                _startAnimation();
              },
            );
          }),
        ],
      ),
      body: Column(
        children: [
          // SizedBox(width: 300, height: 300, child: RiveAnimation.asset("assets/lamp.riv", controllers: [_controller])),
          Spacer(flex: 2),
          GameTitleWidget(),
          Spacer(),
          GameModeSelectionWidget(),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
