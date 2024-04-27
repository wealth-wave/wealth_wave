import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wealth_wave/domain/services/dsl_parser.dart';

class ScriptExecutorService {
  final DSLParser _dslParser;
  final http.Client _client;

  factory ScriptExecutorService() {
    return _instance;
  }

  factory ScriptExecutorService.withMock({required http.Client client}) {
    return ScriptExecutorService._(client: client);
  }

  static final ScriptExecutorService _instance = ScriptExecutorService._();

  ScriptExecutorService._(
      {final DSLParser? dslParserDefinition, final http.Client? client})
      : _dslParser = dslParserDefinition ?? DSLParser(),
        _client = client ?? http.Client();

  Future<double?> executeScript({required final String script}) async {
    final parsedDefn = _dslParser.parse(script);

    final response = await _client.get(
      Uri.parse(parsedDefn.url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      double? value =
          _getValueFromJsonPath(response.body, parsedDefn.responsePath);
      if (value != null) {
        switch (parsedDefn.computeOperation) {
          case 'multiplyBy':
            value *= parsedDefn.computeOn;
            break;
          case 'divideBy':
            value /= parsedDefn.computeOn;
            break;
          case 'add':
            value += parsedDefn.computeOn;
            break;
          case 'subtract':
            value -= parsedDefn.computeOn;
            break;
          default:
            value = value;
        }
      }
      return value;
    } else {
      throw Exception('Failed to execute script');
    }
  }

  double? _getValueFromJsonPath(String json, String jsonPath) {
    Map<String, dynamic> map = jsonDecode(json);
    List<String> keys = jsonPath.split('.');
    dynamic current = map;

    for (String key in keys) {
      if (current is Map<String, dynamic>) {
        current = current[key];
      } else if (current is List<dynamic>) {
        int index = int.parse(key);
        current = current[index];
      } else {
        throw Exception('Invalid JSON path');
      }
    }

    if (current is int) {
      return current.toDouble();
    } else if (current is double) {
      return current;
    } else if (current is String) {
      return double.tryParse(current);
    } else {
      return null;
    }
  }
}
