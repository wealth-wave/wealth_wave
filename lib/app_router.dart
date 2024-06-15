import 'package:flutter/material.dart';
import 'package:wealth_wave/ui/nav_path.dart';
import 'package:wealth_wave/ui/pages/investment_page.dart';
import 'package:wealth_wave/ui/pages/main_page.dart';

class AppRouter {
  static Widget route(String path) {
    final uri = Uri.parse(path);
    if (NavPath.isMainPagePath(uri.pathSegments)) {
      return MainPage(path: uri.pathSegments);
    } else if(NavPath.isInvestmentPagePath(uri.pathSegments)) {
      return InvestmentPage(investmentId: int.parse(uri.pathSegments[1]));
    }
    return const MainPage(path: []);
  }
}
