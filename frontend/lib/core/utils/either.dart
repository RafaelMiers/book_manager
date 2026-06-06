/// Either type — Left = failure, Right = success.
sealed class Either<L, R> {
  const Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  R get right => (this as Right<L, R>).value;
  L get left => (this as Left<L, R>).value;

  T fold<T>(T Function(L) onLeft, T Function(R) onRight) =>
      this is Left<L, R>
          ? onLeft((this as Left<L, R>).value)
          : onRight((this as Right<L, R>).value);
}

final class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
}

final class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);
}
