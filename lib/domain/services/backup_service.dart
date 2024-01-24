import 'package:wealth_wave/api/apis/backup_api.dart';

class BackupService {
  final BackupApi _backupApi;

  factory BackupService() {
    return _instance;
  }

  static final BackupService _instance = BackupService._();

  BackupService._({final BackupApi? backupApi})
      : _backupApi = backupApi ?? BackupApi();

  Future<void> import() async => _backupApi.import();

  Future<void> export() async => _backupApi.export();
}
