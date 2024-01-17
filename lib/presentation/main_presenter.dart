import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/services/backup_service.dart';

class MainPresenter extends Presenter<MainViewState> {
  final BackupService _backupService;

  MainPresenter({final BackupService? backupService})
      : _backupService = backupService ?? BackupService(),
        super(MainViewState());

  void performImportFile() {
    _backupService.import().then((value) => updateViewState((viewState) {
          viewState.onImportCompleted = SingleEvent(null);
        }));
  }

  void performBackup() {
    _backupService.export().then((value) => updateViewState((viewState) {
          viewState.onBackupCompleted = SingleEvent(null);
        }));
  }
}

class MainViewState {
  SingleEvent<void>? onBackupCompleted;
  SingleEvent<void>? onImportCompleted;
}
