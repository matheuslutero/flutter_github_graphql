import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

class QueryResultMock<TParsed extends Object?> extends Mock implements QueryResult<TParsed> {
  @override
  final TParsed? parsedData;

  @override
  final OperationException? exception;

  @override
  bool get hasException => exception != null;

  QueryResultMock({
    this.parsedData,
    this.exception,
  });
}
