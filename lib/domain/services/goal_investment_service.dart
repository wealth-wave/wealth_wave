import 'package:wealth_wave/api/apis/goal_investment_api.dart';
import 'package:wealth_wave/domain/models/goal_investment_tag.dart';

class GoalInvestmentService {
  final GoalInvestmentApi _goalInvestmentApi;

  factory GoalInvestmentService() {
    return _instance;
  }

  static final GoalInvestmentService _instance = GoalInvestmentService._();

  GoalInvestmentService._({final GoalInvestmentApi? goalInvestmentApi})
      : _goalInvestmentApi = goalInvestmentApi ?? GoalInvestmentApi();

  Future<GoalInvestmentTag> getBy({required final int id}) async {
    return _goalInvestmentApi.getById(id: id).then((goalInvestmentDO) {
      return GoalInvestmentTag.from(goalInvestmentDO: goalInvestmentDO);
    });
  }
}
