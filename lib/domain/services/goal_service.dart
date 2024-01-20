import 'package:wealth_wave/api/apis/goal_api.dart';
import 'package:wealth_wave/contract/goal_importance.dart';
import 'package:wealth_wave/domain/models/goal.dart';

class GoalService {
  final GoalApi _goalApi;

  factory GoalService() {
    return _instance;
  }

  static final GoalService _instance = GoalService._();

  GoalService._({GoalApi? goalApi}) : _goalApi = goalApi ?? GoalApi();

  Future<Goal> create({
    required final String name,
    required final String? description,
    required final double amount,
    required final DateTime amountUpdatedOn,
    required final DateTime maturityDate,
    required final double inflation,
    required final GoalImportance importance,
  }) {
    return _goalApi
        .create(
            name: name,
            description: description,
            amount: amount,
            amountUpdatedOn: amountUpdatedOn,
            maturityDate: maturityDate,
            inflation: inflation,
            importance: importance)
        .then((goalId) => _goalApi.getBy(id: goalId))
        .then((goalDO) => Goal.from(goalDO: goalDO));
  }

  Future<List<Goal>> get() async {
    return _goalApi.get().then(
        (goals) => goals.map((goalDO) => Goal.from(goalDO: goalDO)).toList());
  }

  Future<Goal> getBy({required final int id}) async {
    return _goalApi.getBy(id: id).then((goalDO) {
      return Goal.from(goalDO: goalDO);
    });
  }

  Future<Goal> update({
    required final int id,
    required final String name,
    required final String? description,
    required final double amount,
    required final DateTime amountUpdatedOn,
    required final DateTime maturityDate,
    required final double inflation,
    required final GoalImportance importance,
  }) {
    return _goalApi
        .update(
            id: id,
            name: name,
            description: description,
            amount: amount,
            amountUpdatedOn: amountUpdatedOn,
            maturityDate: maturityDate,
            inflation: inflation,
            importance: importance)
        .then((value) => _goalApi.getBy(id: id))
        .then((goalDO) => Goal.from(goalDO: goalDO));
  }

  Future<void> deleteBy({required final int id}) {
    return _goalApi.deleteBy(id: id);
  }
}
