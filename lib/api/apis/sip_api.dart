import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/frequency.dart';

abstract class SipApi {
  Future<int> create(
      {required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime? endDate,
      required final Frequency frequency});

  Future<List<SipDO>> getAll();

  Future<List<SipDO>> getBy({final int? investmentId});

  Future<SipDO> getById({required final int id});

  Future<int> update(
      {required final int id,
      required final int investmentId,
      required final String? description,
      required final double amount,
      required final DateTime startDate,
      required final DateTime? endDate,
      required final Frequency frequency});

  Future<int> deleteBy({final int? id, final int? investmentId});
}
