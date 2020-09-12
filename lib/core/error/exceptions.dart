class ServerException implements Exception {}

class SQLiteException implements Exception {}

class EmptyDataException implements Exception {
  final String systemMessage;

  EmptyDataException(this.systemMessage);

  String get message => systemMessage;
}
