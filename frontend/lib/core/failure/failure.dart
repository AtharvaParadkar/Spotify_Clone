class ApiFailure {
  final String message;

  ApiFailure([this.message = 'Sorry, an unexpected error occured!']);

  @override
  String toString() => 'ApiFailure(message: $message)';
}
