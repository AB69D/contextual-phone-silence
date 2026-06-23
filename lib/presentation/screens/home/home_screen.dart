import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/entities/calendar_event.dart';
import '../../theme/app_theme.dart';
import '../../router/app_router.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/error_banner.dart';
import 'home_viewmodel.dart';
import '../manual_silence/manual_silence_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<HomeViewModel>().loadInitialData());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Contextual Silence'),
        actions: [
          if (vm.unshownDigestCount > 0)
            IconButton(
              onPressed: () => context.go(AppRoutes.missedDigest),
              icon: Badge(
                label: Text('${vm.unshownDigestCount}'),
                child: const Icon(Icons.notifications_outlined),
              ),
            ),
        ],
      ),
      body: vm.isLoading
          ? const _LoadingView()
          : RefreshIndicator(
              onRefresh: vm.loadInitialData,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (vm.hasError)
                    ErrorBanner(
                        message: vm.error!.message,
                        onRetry: vm.loadInitialData),
                  _HeroCard(vm: vm),
                  const SizedBox(height: 20),
                  if (vm.upcomingEvents.isNotEmpty) ...[
                    const _SectionLabel('Upcoming'),
                    const SizedBox(height: 8),
                    ...vm.upcomingEvents.take(5).map((e) => _EventTile(event: e)),
                  ],
                  if (vm.stats != null) ...[
                    const SizedBox(height: 20),
                    _StatsRow(stats: vm.stats!),
                  ],
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => const ManualSilenceSheet(),
        ),
        icon: const Icon(Icons.volume_off_rounded),
        label: const Text('Silence now'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.vm});
  final HomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    final silenced = vm.isSilenced;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: silenced
            ? AppColors.primary.withOpacity(0.12)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: silenced ? AppColors.primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              silenced ? Icons.volume_off_rounded : Icons.volume_up_rounded,
              key: ValueKey(silenced),
              size: 40,
              color: silenced ? AppColors.primary : AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  silenced ? 'Phone is silenced' : 'Phone is active',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: silenced ? AppColors.primary : AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  silenced
                      ? 'Tap to restore immediately'
                      : '${vm.upcomingEvents.where((e) => e.shouldSilence).length} events will auto-silence today',
                  style: const TextStyle(
                      color: AppColors.onSurfaceVariant, fontSize: 13),
                ),
              ],
            ),
          ),
          Switch(
            value: silenced,
            onChanged: (_) => vm.toggleSilence(),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});
  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: event.shouldSilence
                ? AppColors.primary
                : AppColors.onSurfaceVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        title: Text(event.title,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(
            '${_time(event.startTime)} — ${_time(event.endTime)}',
            style: const TextStyle(
                color: AppColors.onSurfaceVariant, fontSize: 12)),
        trailing: event.shouldSilence
            ? const Icon(Icons.volume_off_rounded,
                size: 16, color: AppColors.primary)
            : null,
      ),
    );
  }

  String _time(DateTime dt) {
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m ${dt.hour >= 12 ? 'PM' : 'AM'}';
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats});
  final dynamic stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
            label: 'This week',
            value: '${stats.thisWeekSessions}',
            unit: 'sessions'),
        const SizedBox(width: 8),
        _StatCard(
            label: 'Time protected',
            value:
                '${(stats.thisWeekMinutes / 60).toStringAsFixed(1)}',
            unit: 'hours'),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(
      {required this.label, required this.value, required this.unit});
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    color: AppColors.onSurfaceVariant, fontSize: 11)),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: value,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface)),
                TextSpan(
                    text: ' $unit',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.onSurfaceVariant)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 0.5));
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ShimmerLoading(
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24)),
            ),
          ),
          const SizedBox(height: 20),
          ShimmerLoading(
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}
