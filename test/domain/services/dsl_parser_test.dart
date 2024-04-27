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
responseJsonPath: \$.data.details.value
compute: multiplyBy(5)''';
    final ParsedScript actual = dslParser.parse(script);
    final ParsedScript expected = ParsedScript(
        url: 'http://api.stock.com/funds/123/details?fundId=123&sort=desc',
        responsePath: '\$.data.details.value',
        computeOperation: 'multiplyBy',
        computeOn: 5);

    expect(actual.url, equals(expected.url));
    expect(actual.responsePath, equals(expected.responsePath));
    expect(actual.computeOperation, equals(expected.computeOperation));
    expect(actual.computeOn, equals(expected.computeOn));
  });

  test('should parse script without query params', () {
    const String script = '''apiUrl: http://api.stock.com/funds/:fundId/details
pathParams: fundId=123
queryParams: 
responseJsonPath: \$.data.details.value
compute: multiplyBy(5)''';
    final ParsedScript actual = dslParser.parse(script);
    final ParsedScript expected = ParsedScript(
        url: 'http://api.stock.com/funds/123/details',
        responsePath: '\$.data.details.value',
        computeOperation: 'multiplyBy',
        computeOn: 5);

    expect(actual.url, equals(expected.url));
    expect(actual.responsePath, equals(expected.responsePath));
    expect(actual.computeOperation, equals(expected.computeOperation));
    expect(actual.computeOn, equals(expected.computeOn));
  });

  test('should parse script without path params', () {
    const String script = '''apiUrl: http://api.stock.com/funds/1/details
pathParams: 
queryParams: 
responseJsonPath: \$.data.details.value
compute: multiplyBy(5)''';
    final ParsedScript actual = dslParser.parse(script);
    final ParsedScript expected = ParsedScript(
        url: 'http://api.stock.com/funds/1/details',
        responsePath: '\$.data.details.value',
        computeOperation: 'multiplyBy',
        computeOn: 5);

    expect(actual.url, equals(expected.url));
    expect(actual.responsePath, equals(expected.responsePath));
    expect(actual.computeOperation, equals(expected.computeOperation));
    expect(actual.computeOn, equals(expected.computeOn));
  });
}
