sealed class ResultState<T> {
  const ResultState();

  const factory ResultState.success(T data) = Success<T>;
  const factory ResultState.loading() = Loading<T>;
  const factory ResultState.error(String message) = Error<T>;

  bool get isSuccess => this is Success<T>;
  bool get isLoading => this is Loading<T>;
  bool get isError => this is Error<T>;

  T? get resultData => isSuccess ? (this as Success<T>).data : null;
  String? get errorMessage => isError ? (this as Error<T>).message : null;
}

class Success<T> extends ResultState<T> {
  final T data;

  const Success(this.data);
}

class Loading<T> extends ResultState<T> {
  const Loading();
}

class Error<T> extends ResultState<T> {
  final String message;

  const Error(this.message);
}
