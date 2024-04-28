import 'package:test/test.dart';
import 'package:wealth_wave/domain/services/dsl_parser.dart';

void main() {
  late DSLParser dslParser;

  setUp(() {
    dslParser = DSLParser();
  });

  test('should parse script correctly', () {
    const String script = '''apiUrl: http://api.stock.com/funds/:fundId/details
pathParams: fundId=123
queryParams: fundId=123&sort=desc
headerParams: Authorization=Bearer token
responseJsonPath: \$.data.details.value''';
    final ParsedScript actual = dslParser.parse(script);
    final ParsedScript expected = ParsedScript(
        url: 'http://api.stock.com/funds/123/details?fundId=123&sort=desc',
        headers: {'Authorization': 'Bearer token'},
        responsePath: '\$.data.details.value');

    expect(actual.url, equals(expected.url));
    expect(actual.responsePath, equals(expected.responsePath));
    expect(actual.headers, equals(expected.headers));
  });
}
