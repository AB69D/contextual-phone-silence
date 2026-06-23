import '../../../core/base/base_viewmodel.dart';
import '../../../domain/entities/silence_session.dart';
import '../../../domain/repositories/silence_session_repository.dart';

class HistoryViewModel extends BaseViewModel {
  HistoryViewModel({required this.sessionRepo});
  final SilenceSessionRepository sessionRepo;

  List<SilenceSession> _sessions = [];
  SilenceStats? _stats;
  bool _hasMore = true;
  static const _pageSize = 30;

  List<SilenceSession> get sessions => _sessions;
  SilenceStats? get stats => _stats;
  bool get hasMore => _hasMore;

  Future<void> load() async {
    setLoading(true);
    final sessionsResult = await sessionRepo.getRecentSessions(limit: _pageSize);
    final statsResult = await sessionRepo.getStats();
    if (sessionsResult.isSuccess) {
      _sessions = sessionsResult.valueOrNull ?? [];
      _hasMore = _sessions.length >= _pageSize;
    }
    if (statsResult.isSuccess) {
      _stats = statsResult.valueOrNull;
    }
    setLoading(false);
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    final result =
        await sessionRepo.getRecentSessions(limit: _sessions.length + _pageSize);
    if (result.isSuccess) {
      final all = result.valueOrNull ?? [];
      _hasMore = all.length > _sessions.length;
      _sessions = all;
      notifyListeners();
    }
  }
}
