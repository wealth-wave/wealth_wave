import 'package:petitparser/petitparser.dart';

class DSLParserDefinition extends GrammarDefinition {
  @override
  Parser start() => ref0(document).end();

  Parser token(String input) => input.toParser().trim();

  Parser tokens(String input) => input.toParser().star().trim();

  Parser document() =>
      ref0(apiBlock) &
      ref0(paramsBlock) &
      ref0(extractBlock) &
      ref0(computeBlock);

  Parser apiBlock() => token('api:') & ref0(url).flatten();

  Parser url() => pattern('^\\s+').neg().plus().flatten();

  Parser paramsBlock() => token('params:') & ref0(param).plus();

  Parser param() =>
      ref0(key) & token(':') & ref0(value) & token('\n').optional();

  Parser key() => word().plus().flatten();

  Parser value() => ref0(quotedString) | ref0(number);

  Parser extractBlock() =>
      token('extract:') & token('path:') & ref0(jsonPath).flatten();

  Parser jsonPath() => pattern('^\\s+').neg().plus().flatten();

  Parser computeBlock() => token('compute:') & ref0(operation).plus();

  Parser operation() => (token('add:') | token('multiply:')) & ref0(number);

  Parser number() => pattern('0-9').plus().flatten().trim();

  Parser quotedString() =>
      char('\'') & pattern("^'").neg().star() & char('\'').flatten();
}
