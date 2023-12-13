import 'package:flutter/material.dart';
import 'package:wealth_wave/ui/pages/main_page.dart';

class AppRouter {
  static Widget route(String path) {
    if (MainPage.isMatchingPath(path)) {
      return const MainPage();
    }
    return const MainPage();
  }
}
