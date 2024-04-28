import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wealth_wave/domain/services/dsl_parser.dart';
import 'package:wealth_wave/domain/services/script_executor_service.dart';

import 'script_executor_service_test.mocks.dart';

@GenerateMocks([http.Client, DSLParser])
void main() {
  late MockClient mockClient;
  late MockDSLParser mockDSLParser;

  setUp(() {
    mockClient = MockClient();
    mockDSLParser = MockDSLParser();
  });

  test('should fetch data from script', () async {
    const String script = 'test_script';
    when(mockDSLParser.parse(script)).thenReturn(
      ParsedScript(
        url: 'https://api.mfapi.in/mf/128074/latest?user=11',
        headers: {'Authorization': 'Bearer'},
        responsePath: 'data.0.nav',
      ),
    );
    final scriptExecutorService = ScriptExecutorService.withMock(
        client: mockClient, dslParser: mockDSLParser);
    when(mockClient.get(
            Uri.parse('https://api.mfapi.in/mf/128074/latest?user=11'),
            headers: {'Authorization': 'Bearer'}))
        .thenAnswer((_) async => http.Response('{"data":[{"nav":3.0}]}', 200));
    final value =
        await scriptExecutorService.executeScript(script: script);

    expect(value, equals(3.0));
  });

  test('should fetch data from script for dot values', () async {
    const String script = 'test_script';
    when(mockDSLParser.parse(script)).thenReturn(
      ParsedScript(
        url: 'https://api.mfapi.in/mf/128074/latest?user=11',
        headers: {'Authorization': 'Bearer'},
        responsePath: 'Global Quote.05%2e price',
      ),
    );
    final scriptExecutorService = ScriptExecutorService.withMock(
        client: mockClient, dslParser: mockDSLParser);
    when(mockClient.get(
        Uri.parse('https://api.mfapi.in/mf/128074/latest?user=11'),
        headers: {'Authorization': 'Bearer'}))
        .thenAnswer((_) async => http.Response('{"Global Quote":{"05. price": "3"}}', 200));
    final value =
    await scriptExecutorService.executeScript(script: script);

    expect(value, equals(3.0));
  });
}
