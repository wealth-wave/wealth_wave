import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/services/backup_service.dart';
import 'package:wealth_wave/domain/services/boot_strap_service.dart';

class MainPresenter extends Presenter<MainViewState> {
  final BackupService _backupService;
  final BootStrapService _bootStrapService;

  MainPresenter(
      {final BackupService? backupService,
      final BootStrapService? bootStrapService})
      : _backupService = backupService ?? BackupService(),
        _bootStrapService = bootStrapService ?? BootStrapService(),
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

  void performSync() {
    _bootStrapService
        .performBootStrapOperations()
        .then((value) => updateViewState((viewState) {
              viewState.contentLoading = false;
            }))
        .onError((error, stackTrace) => updateViewState((viewState) {
              viewState.contentLoading = false;
            }));
  }
}

class MainViewState {
  SingleEvent<void>? onBackupCompleted;
  SingleEvent<void>? onImportCompleted;
  bool contentLoading = true;
}
