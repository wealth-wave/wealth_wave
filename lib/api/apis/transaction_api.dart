import 'package:wealth_wave/api/db/app_database.dart';

abstract class TransactionApi {
  Future<int> create(
      {required final int investmentId,
      required final String? description,
      required final double amount,
      required final double qty,
      required final DateTime createdOn,
      final int? sipId});

  Future<List<TransactionDO>> getAll();

  Future<List<TransactionDO>> getBy(
      {final int? investmentId, final int? sipId});

  Future<TransactionDO> getById({required final int id});

  Future<int> update(
      {required final int id,
      required final int investmentId,
      required final String? description,
      required final double amount,
      required final double qty,
      required final DateTime createdOn,
      final int? sipId});

  Future<int> deleteBy(
      {final int? investmentId, final int? sipId, final int? id});
}
