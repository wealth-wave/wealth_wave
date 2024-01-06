import 'package:wealth_wave/api/apis/backup_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';

class MainPresenter extends Presenter<MainViewState> {
  final BackupApi _backupApi;

  MainPresenter({final BackupApi? backupApi})
      : _backupApi = backupApi ?? BackupApi(),
        super(MainViewState());

  void performImportFile() {
    _backupApi.importDatabase().then((value) => updateViewState((viewState) {
          viewState.onImportCompleted = SingleEvent(null);
        }));
  }

  void performBackup() {
    _backupApi.exportDatabase().then((value) => updateViewState((viewState) {
          viewState.onBackupCompleted = SingleEvent(null);
        }));
  }
}

class MainViewState {
  SingleEvent<void>? onBackupCompleted;
  SingleEvent<void>? onImportCompleted;
}
