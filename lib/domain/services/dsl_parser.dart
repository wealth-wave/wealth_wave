import 'package:petitparser/petitparser.dart';

class DSLParser {
  late final Parser<String> _apiUrlParser;
  late final Parser<Map<String, String>> _pathParamsParser;
  late final Parser<Map<String, String>> _queryParamsParser;
  late final Parser<String> _responseJsonPathParser;
  late final Parser<String> _computeParser;

  DSLParser() {
    // URL parser
    _apiUrlParser = (string('http://') | string('https://'))
        .seq(any().star())
        .flatten()
        .trim();

    // Path params parser
    _pathParamsParser = pattern('^[^=]')
        .plus()
        .seq(char('='))
        .seq(pattern('^[^&]').plus())
        .map((value) => {value[0].join(): value[2].join()})
        .star()
        .map((value) =>
            value.fold({}, (prev, element) => {...prev, ...element}));

    // Query params parser
    _queryParamsParser = pattern('^[^=]')
        .plus()
        .seq(char('='))
        .seq(pattern('^[^&]').plus())
        .map((value) => {value[0].join(): value[2].join()})
        .star()
        .map((value) =>
            value.fold({}, (prev, element) => {...prev, ...element}));

    // Response JSON path parser
    _responseJsonPathParser =
        pattern('^\\\$').optional().seq(any().star()).flatten().trim();
    // Compute operation parser
    _computeParser = pattern('^[^(]')
        .plus()
        .seq(char('('))
        .seq(pattern('^[^)]').plus())
        .seq(char(')'))
        .flatten()
        .trim();
  }

  ParsedScript parse(String script) {
    List<String> lines = script.split('\n');
    String apiUrl = _apiUrlParser.parse(lines[0].split(': ')[1]).value;
    Map<String, String> pathParams =
        _pathParamsParser.parse(lines[1].split(': ')[1]).value;
    Map<String, String> queryParams =
        _queryParamsParser.parse(lines[2].split(': ')[1]).value;
    String responseJsonPath =
        _responseJsonPathParser.parse(lines[3].split(': ')[1]).value;
    String compute = _computeParser.parse(lines[4].split(': ')[1]).value;

    pathParams.forEach((key, value) {
      apiUrl = apiUrl.replaceAll(':$key', value);
    });

    bool isFirstQueryParam = true;
    queryParams.forEach((key, value) {
      if (isFirstQueryParam) {
        apiUrl += '?$key=$value';
        isFirstQueryParam = false;
      } else {
        apiUrl += '$key=$value';
      }
    });

    return ParsedScript(
        url: apiUrl,
        responsePath: responseJsonPath,
        computeOperation: compute.split('(')[0],
        computeOn: double.parse(compute.split('(')[1].split(')')[0]));
  }
}

class ParsedScript {
  final String url;
  final String responsePath;
  final String computeOperation;
  final double computeOn;

  ParsedScript(
      {required this.url,
      required this.responsePath,
      required this.computeOperation,
      required this.computeOn});
}
