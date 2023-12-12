import 'package:flutter/material.dart';
import 'package:wealth_wave/ui/pages/dashboard_page.dart';

class AppRouter {
  static Widget route(String path) {
    if (DashboardPage.isMatchingPath(path)) {
      return const DashboardPage();
    }
    return const DashboardPage();
  }
}
