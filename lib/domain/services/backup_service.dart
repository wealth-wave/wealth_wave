import 'package:wealth_wave/api/apis/backup_api.dart';

class BackupService {
  final BackupApi _backupApi;

  BackupService({final BackupApi? backupApi})
      : _backupApi = backupApi ?? BackupApi();

  Future<void> import() async {
    return _backupApi.import();
  }

  Future<void> export() async {
    return _backupApi.export();
  }
}
