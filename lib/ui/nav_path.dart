class NavPath {
  static const String home = '/';
  static const String createGoal = '/create-goal';
  static String updateGoal({required final int id}) => '/goals/$id/update';
  static const String investments = '/investments';
  static const String createInvestment = '/create-investment';
  static String updateInvestment({required final int id}) =>
      '/investments/$id/update';
  static const String createBasket = '/create-basket';
  static String updateBasket({required final int id}) => '/baskets/$id/update';

  static isMainPagePath(List<String> paths) => paths.isEmpty;

  static isCreateGoalPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == 'create-goal';

  static isCreateInvestmentPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == 'create-investment';

  static isCreateBasketPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == 'create-basket';
}
