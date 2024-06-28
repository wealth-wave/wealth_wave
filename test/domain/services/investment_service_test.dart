import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/script_api.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/domain/services/script_executor_service.dart';

import 'investment_service_test.mocks.dart';

@GenerateMocks([
  InvestmentApi,
  ScriptApi,
  ScriptExecutorService,
  TransactionApi,
  SipApi
])
void main() {
  late MockInvestmentApi mockInvestmentApi;
  late MockScriptApi mockScriptApi;
  late MockScriptExecutorService mockScriptExecutorService;
  late MockTransactionApi mockTransactionApi;
  late MockSipApi mockSipApi;
  late InvestmentService investmentService;

  setUp(() {
    mockInvestmentApi = MockInvestmentApi();
    mockScriptApi = MockScriptApi();
    mockScriptExecutorService = MockScriptExecutorService();
    mockTransactionApi = MockTransactionApi();
    mockSipApi = MockSipApi();
    investmentService = InvestmentService.withMock(
        investmentApi: mockInvestmentApi,
        scriptApi: mockScriptApi,
        scriptExecutorService: mockScriptExecutorService,
        sipApi: mockSipApi,
        transactionApi: mockTransactionApi);
  });

  test('updateValues skips investment if value updated within last day',
      () async {
    when(mockInvestmentApi.getAll()).thenAnswer((_) async => [
          InvestmentDO(
              id: 1,
              name: '',
              riskLevel: RiskLevel.low,
              valueUpdatedOn: DateTime.now())
        ]);
    await investmentService.updateValues();
    verifyNever(mockInvestmentApi.updateValue(
        id: anyNamed('id'),
        value: anyNamed('value'),
        valueUpdatedOn: anyNamed('valueUpdatedOn')));
  });

  test('updateValues skips investment if no script found', () async {
    when(mockInvestmentApi.getAll()).thenAnswer((_) async => [
          InvestmentDO(
              id: 1,
              name: '',
              riskLevel: RiskLevel.low,
              valueUpdatedOn: DateTime.now().subtract(const Duration(days: 1)))
        ]);
    when(mockScriptApi.getBy(investmentId: anyNamed('investmentId')))
        .thenAnswer((_) async => null);

    await investmentService.updateValues();

    verifyNever(mockInvestmentApi.updateValue(
        id: anyNamed('id'),
        value: anyNamed('value'),
        valueUpdatedOn: anyNamed('valueUpdatedOn')));
  });

  test(
      'updateValues updates investment value if script found and executed successfully',
      () async {
    when(mockInvestmentApi.getAll()).thenAnswer((_) async => [
          InvestmentDO(
              id: 1,
              name: '',
              riskLevel: RiskLevel.low,
              valueUpdatedOn: DateTime.now().subtract(const Duration(days: 1)))
        ]);
    when(mockScriptApi.getBy(investmentId: anyNamed('investmentId')))
        .thenAnswer(
            (_) async => const ScriptDO(id: 1, script: '', investmentId: 1));
    when(mockScriptExecutorService.executeScript(script: anyNamed('script')))
        .thenAnswer((_) async => 100.0);
    when(mockInvestmentApi.updateValue(id: 1, value: 100.0, valueUpdatedOn: anyNamed('valueUpdatedOn')))
        .thenAnswer((_) async => 1);

    await investmentService.updateValues();

    verify(mockInvestmentApi.updateValue(
            id: 1, value: 100.0, valueUpdatedOn: anyNamed('valueUpdatedOn')))
        .called(1);
  });
}
