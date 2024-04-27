import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:wealth_wave/api/apis/script_api.dart';
import 'package:wealth_wave/domain/services/script_service.dart';

import 'script_service_test.mocks.dart';

@GenerateMocks([ScriptApi])
void main() {
  late MockScriptApi scriptApi;

  setUp(() {
    scriptApi = MockScriptApi();
  });

  test('should fetch data from script', () async {
    const String script = '''
api: https://api.example.com/data
params: 
  key1: value1
  key2: value2
extract: 
  path: data.items
compute: add   
      ''';
    final scriptService = ScriptService.mock(scriptApi: scriptApi);
    final value = await scriptService.executeScript(script: script);

    expect(value, equals(3));
  });
}
