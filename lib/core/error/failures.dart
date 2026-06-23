sealed class AppFailure {
  const AppFailure(this.message);
  final String message;

  factory AppFailure.permission(String message) = PermissionFailure;
  factory AppFailure.database(String message) = DatabaseFailure;
  factory AppFailure.platform(String message) = PlatformFailure;
  factory AppFailure.notFound(String message) = NotFoundFailure;
  factory AppFailure.unexpected(String message) = UnexpectedFailure;
  factory AppFailure.network(String message) = NetworkFailure;

  @override
  String toString() => '${runtimeType}: $message';
}

final class PermissionFailure extends AppFailure {
  const PermissionFailure(super.message);
}

final class DatabaseFailure extends AppFailure {
  const DatabaseFailure(super.message);
}

final class PlatformFailure extends AppFailure {
  const PlatformFailure(super.message);
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure(super.message);
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure(super.message);
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure(super.message);
}
