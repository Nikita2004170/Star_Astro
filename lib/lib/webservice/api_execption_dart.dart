class ApiException implements Exception {
  final _message;
  final _prefix;

  ApiException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class InvalidRequest extends ApiException {
  InvalidRequest([String? message]) : super(message, "Invalid request.");
}

class UnauthorizedRequest extends ApiException {
  UnauthorizedRequest([String? message])
      : super(message, "Unauthorized request.");
}

class NotFoundRequest extends ApiException {
  NotFoundRequest([String? message]) : super(message, "Request not found.");
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, "Error during communication.");
}
