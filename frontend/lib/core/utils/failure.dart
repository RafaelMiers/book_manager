sealed class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Session expired. Please sign in again.');
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
