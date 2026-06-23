import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/silence_session.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shimmer_loading.dart';
import 'history_viewmodel.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<HistoryViewModel>().load());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HistoryViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        bottom: vm.stats != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: _StatsBar(stats: vm.stats!),
              )
            : null,
      ),
      body: vm.isLoading
          ? _shimmer()
          : vm.sessions.isEmpty
              ? const _EmptyView()
              : NotificationListener<ScrollNotification>(
                  onNotification: (n) {
                    if (n.metrics.pixels >=
                        n.metrics.maxScrollExtent - 200) {
                      vm.loadMore();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: vm.sessions.length,
                    itemBuilder: (_, i) =>
                        _SessionCard(session: vm.sessions[i]),
                  ),
                ),
    );
  }

  Widget _shimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (_, __) => ShimmerLoading(
        child: Container(
          height: 72,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class _StatsBar extends StatelessWidget {
  const _StatsBar({required this.stats});
  final SilenceStats stats;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          _Stat(
              value: '${stats.totalSessions}', label: 'Total sessions'),
          const SizedBox(width: 24),
          _Stat(
              value:
                  '${(stats.totalDurationMinutes / 60).toStringAsFixed(0)}h',
              label: 'Protected'),
          const SizedBox(width: 24),
          _Stat(
              value: '${stats.missedCallsProtected}',
              label: 'Calls blocked'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary)),
        Text(label,
            style: const TextStyle(
                fontSize: 11, color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});
  final SilenceSession session;

  @override
  Widget build(BuildContext context) {
    final d = session.duration;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          session.silenceType == SilenceType.automatic
              ? Icons.calendar_today_outlined
              : Icons.touch_app_outlined,
          color: AppColors.primary,
        ),
        title: Text(session.eventTitle,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
          _date(session.startTime) +
              (d != null ? ' · ${_dur(d)}' : ' · ongoing'),
          style: const TextStyle(
              color: AppColors.onSurfaceVariant, fontSize: 12),
        ),
        trailing: session.missedCallCount > 0
            ? Chip(
                label: Text('${session.missedCallCount}',
                    style: const TextStyle(fontSize: 11)),
                avatar: const Icon(Icons.call_missed, size: 12),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              )
            : null,
      ),
    );
  }

  String _date(DateTime dt) {
    final now = DateTime.now();
    if (dt.day == now.day && dt.month == now.month && dt.year == now.year) {
      return 'Today';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (dt.day == yesterday.day &&
        dt.month == yesterday.month &&
        dt.year == yesterday.year) return 'Yesterday';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  String _dur(Duration d) {
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history_outlined,
              size: 64, color: AppColors.onSurfaceVariant),
          SizedBox(height: 16),
          Text('No sessions yet',
              style: TextStyle(
                  color: AppColors.onSurfaceVariant, fontSize: 16)),
          SizedBox(height: 8),
          Text('Sessions will appear here after your first silence.',
              style: TextStyle(
                  color: AppColors.onSurfaceVariant, fontSize: 13),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
