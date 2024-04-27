import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wealth_wave/domain/services/script_executor_service.dart';

import 'script_executor_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  test('should fetch data from script', () async {
    const String script = '''apiUrl: https://api.mfapi.in/mf/:mf/latest
pathParams: mf=128074
queryParams: 
responseJsonPath: data.0.nav
compute: multiplyBy(5)''';
    final scriptExecutorService =
        ScriptExecutorService.withMock(client: mockClient);
    when(mockClient.get(Uri.parse('https://api.mfapi.in/mf/128074/latest'),
            headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        }))
        .thenAnswer((_) async => http.Response('{"data":[{"nav":3.0}]}', 200));
    final value = await scriptExecutorService.executeScript(script: script);

    expect(value, equals(15.0));
  });
}
