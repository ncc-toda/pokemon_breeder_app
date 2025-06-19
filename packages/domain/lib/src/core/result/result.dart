/// A simple Result type representing either a [Success] with value [S]
/// or a [Failure] with error [F].
sealed class Result<S, F> {
  const Result();

  /// Pattern matching utility to handle both branches.
  T when<T>(
      {required T Function(S data) success,
      required T Function(F failure) failure});
}

/// Represents a successful result containing [value].
class Success<S, F> extends Result<S, F> {
  const Success(this.value);

  final S value;

  @override
  T when<T>(
      {required T Function(S data) success,
      required T Function(F failure) failure}) {
    return success(value);
  }
}

/// Represents a failed result containing [failure].
class Failure<S, F> extends Result<S, F> {
  const Failure(this.failure);

  final F failure;

  @override
  T when<T>(
      {required T Function(S data) success,
      required T Function(F failure) failure}) {
    return failure(this.failure);
  }
}
