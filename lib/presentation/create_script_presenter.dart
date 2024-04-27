import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/script.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/domain/services/script_service.dart';

class CreateScriptPresenter extends Presenter<CreateScriptViewState> {
  final int _investmentId;
  final ScriptService _scriptService;

  CreateScriptPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService,
      final ScriptService? scriptService})
      : _investmentId = investmentId,
        _scriptService = scriptService ?? ScriptService(),
        super(CreateScriptViewState());

  void createScript() {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String dsl = viewState.dsl;
    _scriptService.createScript(investmentId: _investmentId, script: dsl).then(
        (_) => updateViewState(
            (viewState) => viewState.onScriptCreated = SingleEvent(null)));
  }

  void onDSLChanged(String text) {
    updateViewState((viewState) => viewState.dsl = text);
  }

  void _setScript(Script scriptToUpdate) {
    updateViewState((viewState) {
      viewState.dsl = scriptToUpdate.dsl;
      viewState.onScriptLoaded = SingleEvent(null);
    });
  }

  void fetchScript({required int investmentId}) {
    _scriptService
        .getBy(investmentId: investmentId)
        .then((sip) => _setScript(sip));
  }
}

class CreateScriptViewState {
  String dsl = '''apiUrl: http://api.stock.com/fund/:fundId/details
pathParams: fundId=123
queryParams: fundId=123
responseJsonPath: \$.data.details.value
compute: multiplyBy(5)''';
  SingleEvent<void>? onScriptCreated;
  SingleEvent<void>? onScriptLoaded;

  bool isValid() {
    return dsl.isNotEmpty;
  }
}
