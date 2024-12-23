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
  static String investment({required final int id}) => '/investments/$id';
  static String goal({required final int id}) => '/goals/$id';
  static const String baskets = '/baskets';
  static const String expenseTags = '/expense-tags';
  static const String upcomingSips = '/upcoming-sips';

  static isMainPagePath(List<String> paths) => paths.isEmpty;

  static isCreateGoalPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == 'create-goal';

  static isCreateInvestmentPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == 'create-investment';

  static isCreateBasketPagePath(List<String> paths) =>
      paths.length == 1 && paths[0] == 'create-basket';

  static isInvestmentPagePath(List<String> paths) =>
      paths.length == 2 && paths[0] == 'investments';

  static isGoalPagePath(List<String> paths) =>
      paths.length == 2 && paths[0] == 'goals';

  static isBasketsPagePath(List<String> paths) => paths.length == 1 && paths[0] == 'baskets';
  
  static isExpenseTagsPagePath(List<String> paths) => paths.length == 1 && paths[0] == 'expense-tags';

  static isUpcomingSipPath(List<String> paths) => paths.length == 1 && paths[0] == 'upcoming-sips';
}
