class NavPath {
  static const String home = '';
  static const String baskets = 'baskets';
  static const String dashboard = 'dashboard';
  static const String goals = 'goals';
  static const String investments = 'investments';

  static isMainPagePath(List<String> paths) {
    if (paths.isEmpty) return true;
    final firstPath = paths[0];
    return firstPath == dashboard ||
        firstPath == goals ||
        firstPath == investments;
  }

  static isDashboardPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == dashboard;

  static isGoalsPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == goals;

  static isInvestmentsPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == investments;

  static isBasketPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == baskets;
}
