import 'package:flutter/foundation.dart';
import '../error/failures.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  AppFailure? _error;
  bool _disposed = false;

  bool get isLoading => _isLoading;
  AppFailure? get error => _error;
  bool get hasError => _error != null;

  @protected
  void setLoading(bool loading) {
    if (_disposed) return;
    _isLoading = loading;
    notifyListeners();
  }

  @protected
  void setError(AppFailure? failure) {
    if (_disposed) return;
    _error = failure;
    notifyListeners();
  }

  @protected
  void clearError() => setError(null);

  @protected
  Future<void> runWithLoading(Future<void> Function() fn) async {
    setLoading(true);
    clearError();
    try {
      await fn();
    } catch (e) {
      setError(AppFailure.unexpected(e.toString()));
    } finally {
      if (!_disposed) setLoading(false);
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
