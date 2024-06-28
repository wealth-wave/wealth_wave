import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';

abstract class InvestmentApi {

  Future<int> create({
    required final String name,
    required final String? description,
    required final int? basketId,
    required final RiskLevel riskLevel,
    required final double? value,
    required final DateTime? valueUpdatedOn,
    required final double? irr,
    required final DateTime? maturityDate,
  });

  Future<List<InvestmentDO>> getAll();

  Future<List<InvestmentDO>> getEnriched();

  Future<InvestmentDO> getById({required final int id});

  Future<List<InvestmentDO>> getBy({final int? basketId});

  Future<int> update({
    required final int id,
    required final String name,
    required final String? description,
    required final double? value,
    required final double? qty,
    required final DateTime? valueUpdatedOn,
    required final double? irr,
    required final DateTime? maturityDate,
    required final RiskLevel riskLevel,
    required final int? basketId,
  });

  Future<int> updateValue({
    required final int id,
    required final double value,
    required final DateTime valueUpdatedOn,
  });

  Future<int> deleteBy({required final int id});
}
